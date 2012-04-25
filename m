From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/5] ASoC: dpcm: Add debugFS support for DPCM
Date: Wed, 25 Apr 2012 12:12:50 +0100
Message-ID: <1335352373-5237-2-git-send-email-lrg@ti.com>
References: <1335352373-5237-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id A551A1048AA
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 13:13:48 +0200 (CEST)
Received: by werf3 with SMTP id f3so1427751wer.11
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 04:13:46 -0700 (PDT)
In-Reply-To: <1335352373-5237-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Add debugFS files for DPCM link management information.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dpcm.h |    4 +
 include/sound/soc.h      |    4 +
 sound/soc/soc-core.c     |   11 +++
 sound/soc/soc-pcm.c      |  152 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index cd72c10..e307fa3 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -81,6 +81,9 @@ struct snd_soc_dpcm {
 
 	/* hw params for this link - may be different for each link */
 	struct snd_pcm_hw_params hw_params;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_state;
+#endif
 };
 
 /*
@@ -128,5 +131,6 @@ void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
 
 /* internal use only */
 int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
+int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd);
 
 #endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index c2eb563..c48d89d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -935,6 +935,10 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai *cpu_dai;
 
 	struct delayed_work delayed_work;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_dpcm_root;
+	struct dentry *debugfs_dpcm_state;
+#endif
 };
 
 /* mixer control */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1a2626d..a25ba6f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1187,6 +1187,17 @@ static int soc_post_component_init(struct snd_soc_card *card,
 		dev_err(codec->dev,
 			"asoc: failed to add codec sysfs files: %d\n", ret);
 
+#ifdef CONFIG_DEBUG_FS
+	/* add DPCM sysfs entries */
+	if (!dai_link->dynamic)
+		goto out;
+
+	ret = soc_dpcm_debugfs_add(rtd);
+	if (ret < 0)
+		dev_err(rtd->dev, "asoc: failed to add dpcm sysfs entries: %d\n", ret);
+
+out:
+#endif
 	return 0;
 }
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 458f116..a1d4426 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/export.h>
+#include <linux/debugfs.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -690,6 +691,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			stream ? "capture" : "playback",  fe->dai_link->name,
 			stream ? "<-" : "->", be->dai_link->name);
 
+#ifdef CONFIG_DEBUG_FS
+	dpcm->debugfs_state = debugfs_create_u32(be->dai_link->name, 0644,
+			fe->debugfs_dpcm_root, &dpcm->state);
+#endif
 	return 1;
 }
 
@@ -741,6 +746,9 @@ static void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 		/* BEs still alive need new FE */
 		dpcm_be_reparent(fe, dpcm->be, stream);
 
+#ifdef CONFIG_DEBUG_FS
+		debugfs_remove(dpcm->debugfs_state);
+#endif
 		list_del(&dpcm->list_be);
 		list_del(&dpcm->list_fe);
 		kfree(dpcm);
@@ -1890,3 +1898,147 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 	return 1;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
+
+#ifdef CONFIG_DEBUG_FS
+static char *dpcm_state_string(enum snd_soc_dpcm_state state)
+{
+	switch (state) {
+	case SND_SOC_DPCM_STATE_NEW:
+		return "new";
+	case SND_SOC_DPCM_STATE_OPEN:
+		return "open";
+	case SND_SOC_DPCM_STATE_HW_PARAMS:
+		return "hw_params";
+	case SND_SOC_DPCM_STATE_PREPARE:
+		return "prepare";
+	case SND_SOC_DPCM_STATE_START:
+		return "start";
+	case SND_SOC_DPCM_STATE_STOP:
+		return "stop";
+	case SND_SOC_DPCM_STATE_SUSPEND:
+		return "suspend";
+	case SND_SOC_DPCM_STATE_PAUSED:
+		return "paused";
+	case SND_SOC_DPCM_STATE_HW_FREE:
+		return "hw_free";
+	case SND_SOC_DPCM_STATE_CLOSE:
+		return "close";
+	}
+
+	return "unknown";
+}
+
+static int dpcm_state_open_file(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
+				int stream, char *buf, size_t size)
+{
+	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
+	struct snd_soc_dpcm *dpcm;
+	ssize_t offset = 0;
+
+	/* FE state */
+	offset += snprintf(buf + offset, size - offset,
+			"[%s - %s]\n", fe->dai_link->name,
+			stream ? "Capture" : "Playback");
+
+	offset += snprintf(buf + offset, size - offset, "State: %s\n",
+	                dpcm_state_string(fe->dpcm[stream].state));
+
+	if ((fe->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
+	    (fe->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
+		offset += snprintf(buf + offset, size - offset,
+				"Hardware Params: "
+				"Format = %s, Channels = %d, Rate = %d\n",
+				snd_pcm_format_name(params_format(params)),
+				params_channels(params),
+				params_rate(params));
+
+	/* BEs state */
+	offset += snprintf(buf + offset, size - offset, "Backends:\n");
+
+	if (list_empty(&fe->dpcm[stream].be_clients)) {
+		offset += snprintf(buf + offset, size - offset,
+				" No active DSP links\n");
+		goto out;
+	}
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		params = &dpcm->hw_params;
+
+		offset += snprintf(buf + offset, size - offset,
+				"- %s\n", be->dai_link->name);
+
+		offset += snprintf(buf + offset, size - offset,
+				"   State: %s\n",
+				dpcm_state_string(be->dpcm[stream].state));
+
+		if ((be->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
+		    (be->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
+			offset += snprintf(buf + offset, size - offset,
+				"   Hardware Params: "
+				"Format = %s, Channels = %d, Rate = %d\n",
+				snd_pcm_format_name(params_format(params)),
+				params_channels(params),
+				params_rate(params));
+	}
+
+out:
+	return offset;
+}
+
+static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct snd_soc_pcm_runtime *fe = file->private_data;
+	ssize_t out_count = PAGE_SIZE, offset = 0, ret = 0;
+	char *buf;
+
+	buf = kmalloc(out_count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (fe->cpu_dai->driver->playback.channels_min)
+		offset += dpcm_show_state(fe, SNDRV_PCM_STREAM_PLAYBACK,
+					buf + offset, out_count - offset);
+
+	if (fe->cpu_dai->driver->capture.channels_min)
+		offset += dpcm_show_state(fe, SNDRV_PCM_STREAM_CAPTURE,
+					buf + offset, out_count - offset);
+
+        ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
+
+        kfree(buf);
+
+        return ret;
+}
+
+static const struct file_operations dpcm_state_fops = {
+	.open = dpcm_state_open_file,
+	.read = dpcm_state_read_file,
+	.llseek = default_llseek,
+};
+
+int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
+{
+	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
+			rtd->card->debugfs_card_root);
+	if (!rtd->debugfs_dpcm_root) {
+		dev_dbg(rtd->dev,
+			 "ASoC: Failed to create dpcm debugfs directory %s\n",
+			 rtd->dai_link->name);
+		return -EINVAL;
+	}
+
+	rtd->debugfs_dpcm_state = debugfs_create_file("state", 0644,
+						rtd->debugfs_dpcm_root,
+						rtd, &dpcm_state_fops);
+
+	return 0;
+}
+#endif
-- 
1.7.5.4
