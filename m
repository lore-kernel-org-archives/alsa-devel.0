From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/14] ALSA: pcm: Suspend streams globally via
	device type PM ops
Date: Tue, 15 Jan 2019 17:21:42 +0100
Message-ID: <20190115162155.6308-2-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2772F2667F5
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:56 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Until now we rely on each driver calling snd_pcm_suspend*() explicitly
at its own PM handling.  However, this can be done far more easily by
setting the PM ops to each actual snd_pcm device object.

This patch adds the device_type object for PCM stream and assigns to
each PCM stream object.  The type contains only the PM ops for system
suspend; we don't need to deal with the resume in general.

The suspend hook simply calls snd_pcm_suspend_all() for the given PCM
streams.  This implies that the PM order is correctly put, i.e. PCM is
suspended before the main (or codec) driver, which should be true in
general.  If a special ordering is needed, you'd need to adjust the
device PM order manually later.

This patch introduces a new flag, snd_pcm.no_device_suspend, too.
With this flag set, the PCM device object won't invoke
snd_pcm_suspend_all() by itself.  This is needed for ASoC who wants to
manage the PM call orders in its serialized way, and the flag is set
in soc_new_pcm() as default.

For the non-ASoC world, we can get rid of the manual snd_pcm_suspend
calls.  This will be done in the later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/pcm.h |  1 +
 sound/core/pcm.c    | 26 ++++++++++++++++++++++++++
 sound/soc/soc-pcm.c |  1 +
 3 files changed, 28 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index d6bd3caf6878..04e97564949c 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -538,6 +538,7 @@ struct snd_pcm {
 	void (*private_free) (struct snd_pcm *pcm);
 	bool internal; /* pcm is for internal use only */
 	bool nonatomic; /* whole PCM operations are in non-atomic context */
+	bool no_device_suspend; /* don't invoke device PM suspend */
 #if IS_ENABLED(CONFIG_SND_PCM_OSS)
 	struct snd_pcm_oss oss;
 #endif
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 01b9d62eef14..ca1ea3cf9350 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -683,6 +683,31 @@ static inline int snd_pcm_substream_proc_done(struct snd_pcm_substream *substrea
 
 static const struct attribute_group *pcm_dev_attr_groups[];
 
+/*
+ * PM callbacks: we need to deal only with suspend here, as the resume is
+ * triggered either from user-space or the driver's resume callback
+ */
+#ifdef CONFIG_PM_SLEEP
+static int do_pcm_suspend(struct device *dev)
+{
+	struct snd_pcm_str *pstr = container_of(dev, struct snd_pcm_str, dev);
+
+	if (!pstr->pcm->no_device_suspend)
+		snd_pcm_suspend_all(pstr->pcm);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops pcm_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(do_pcm_suspend, NULL)
+};
+
+/* device type for PCM -- basically only for passing PM callbacks */
+static const struct device_type pcm_dev_type = {
+	.name = "pcm",
+	.pm = &pcm_dev_pm_ops,
+};
+
 /**
  * snd_pcm_new_stream - create a new PCM stream
  * @pcm: the pcm instance
@@ -713,6 +738,7 @@ int snd_pcm_new_stream(struct snd_pcm *pcm, int stream, int substream_count)
 
 	snd_device_initialize(&pstr->dev, pcm->card);
 	pstr->dev.groups = pcm_dev_attr_groups;
+	pstr->dev.type = &pcm_dev_type;
 	dev_set_name(&pstr->dev, "pcmC%iD%i%c", pcm->card->number, pcm->device,
 		     stream == SNDRV_PCM_STREAM_PLAYBACK ? 'p' : 'c');
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 03f36e534050..485eec5be608 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -3155,6 +3155,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	}
 
 	pcm->private_free = soc_pcm_private_free;
+	pcm->no_device_suspend = true;
 out:
 	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
 		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
-- 
2.20.1
