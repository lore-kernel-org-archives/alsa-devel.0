From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 3/3] ASoC: wm_adsp: Add basic debugfs entries
Date: Wed, 10 Jun 2015 16:12:48 +0100
Message-ID: <1433949168-25615-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1433949168-25615-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433949168-25615-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds some debugfs nodes to get information
about the currently running firmware.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  195 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm_adsp.h |   11 ++-
 2 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1694636..4b2dd34 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
+#include <linux/debugfs.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -243,6 +244,175 @@ struct wm_coeff_ctl {
 	unsigned int flags;
 };
 
+#ifdef CONFIG_DEBUG_FS
+static void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp, const char *s)
+{
+	char *tmp = kasprintf(GFP_KERNEL, "%s\n", s);
+
+	mutex_lock(&dsp->debugfs_lock);
+	kfree(dsp->wmfw_file_name);
+	dsp->wmfw_file_name = tmp;
+	mutex_unlock(&dsp->debugfs_lock);
+}
+
+static void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp, const char *s)
+{
+	char *tmp = kasprintf(GFP_KERNEL, "%s\n", s);
+
+	mutex_lock(&dsp->debugfs_lock);
+	kfree(dsp->bin_file_name);
+	dsp->bin_file_name = tmp;
+	mutex_unlock(&dsp->debugfs_lock);
+}
+
+static void wm_adsp_debugfs_clear(struct wm_adsp *dsp)
+{
+	mutex_lock(&dsp->debugfs_lock);
+	kfree(dsp->wmfw_file_name);
+	kfree(dsp->bin_file_name);
+	dsp->wmfw_file_name = NULL;
+	dsp->bin_file_name = NULL;
+	mutex_unlock(&dsp->debugfs_lock);
+}
+
+static ssize_t wm_adsp_debugfs_wmfw_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct wm_adsp *dsp = file->private_data;
+	ssize_t ret;
+
+	mutex_lock(&dsp->debugfs_lock);
+
+	if (!dsp->wmfw_file_name || !dsp->running)
+		ret = 0;
+	else
+		ret = simple_read_from_buffer(user_buf, count, ppos,
+					      dsp->wmfw_file_name,
+					      strlen(dsp->wmfw_file_name));
+
+	mutex_unlock(&dsp->debugfs_lock);
+	return ret;
+}
+
+static ssize_t wm_adsp_debugfs_bin_read(struct file *file,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct wm_adsp *dsp = file->private_data;
+	ssize_t ret;
+
+	mutex_lock(&dsp->debugfs_lock);
+
+	if (!dsp->bin_file_name || !dsp->running)
+		ret = 0;
+	else
+		ret = simple_read_from_buffer(user_buf, count, ppos,
+					      dsp->bin_file_name,
+					      strlen(dsp->bin_file_name));
+
+	mutex_unlock(&dsp->debugfs_lock);
+	return ret;
+}
+
+static const struct {
+	const char *name;
+	const struct file_operations fops;
+} wm_adsp_debugfs_fops[] = {
+	{
+		.name = "wmfw_file_name",
+		.fops = {
+			.open = simple_open,
+			.read = wm_adsp_debugfs_wmfw_read,
+		},
+	},
+	{
+		.name = "bin_file_name",
+		.fops = {
+			.open = simple_open,
+			.read = wm_adsp_debugfs_bin_read,
+		},
+	},
+};
+
+static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
+				  struct snd_soc_codec *codec)
+{
+	struct dentry *root = NULL;
+	char *root_name;
+	int i;
+
+	if (!codec->component.debugfs_root) {
+		adsp_err(dsp, "No codec debugfs root\n");
+		goto err;
+	}
+
+	root_name = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!root_name)
+		goto err;
+
+	snprintf(root_name, PAGE_SIZE, "dsp%d", dsp->num);
+	root = debugfs_create_dir(root_name, codec->component.debugfs_root);
+	kfree(root_name);
+
+	if (!root)
+		goto err;
+
+	if (!debugfs_create_bool("running", S_IRUGO, root, &dsp->running))
+		goto err;
+
+	if (!debugfs_create_x32("fw_id", S_IRUGO, root, &dsp->fw_id))
+		goto err;
+
+	if (!debugfs_create_x32("fw_version", S_IRUGO, root,
+				&dsp->fw_id_version))
+		goto err;
+
+	for (i = 0; i < ARRAY_SIZE(wm_adsp_debugfs_fops); ++i) {
+		if (!debugfs_create_file(wm_adsp_debugfs_fops[i].name,
+					 S_IRUGO, root, dsp,
+					 &wm_adsp_debugfs_fops[i].fops))
+			goto err;
+	}
+
+	dsp->debugfs_root = root;
+	return;
+
+err:
+	debugfs_remove_recursive(root);
+	adsp_err(dsp, "Failed to create debugfs\n");
+}
+
+static void wm_adsp2_cleanup_debugfs(struct wm_adsp *dsp)
+{
+	wm_adsp_debugfs_clear(dsp);
+	debugfs_remove_recursive(dsp->debugfs_root);
+}
+#else
+static inline void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
+					 struct snd_soc_codec *codec)
+{
+}
+
+static inline void wm_adsp2_cleanup_debugfs(struct wm_adsp *dsp)
+{
+}
+
+static inline void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp,
+						 const char *s)
+{
+}
+
+static inline void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp,
+						const char *s)
+{
+}
+
+static inline void wm_adsp_debugfs_clear(struct wm_adsp *dsp)
+{
+}
+#endif
+
 static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
@@ -1109,6 +1279,8 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			  file, regions, pos - firmware->size);
 
+	wm_adsp_debugfs_save_wmfwname(dsp, file);
+
 out_fw:
 	regmap_async_complete(regmap);
 	wm_adsp_buf_free(&buf_list);
@@ -1326,11 +1498,12 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 
 	n_algs = be32_to_cpu(adsp2_id.n_algs);
 	dsp->fw_id = be32_to_cpu(adsp2_id.fw.id);
+	dsp->fw_id_version = be32_to_cpu(adsp2_id.fw.ver);
 	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
 		  dsp->fw_id,
-		  (be32_to_cpu(adsp2_id.fw.ver) & 0xff0000) >> 16,
-		  (be32_to_cpu(adsp2_id.fw.ver) & 0xff00) >> 8,
-		  be32_to_cpu(adsp2_id.fw.ver) & 0xff,
+		  (dsp->fw_id_version & 0xff0000) >> 16,
+		  (dsp->fw_id_version & 0xff00) >> 8,
+		  dsp->fw_id_version & 0xff,
 		  n_algs);
 
 	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP2_XM,
@@ -1606,6 +1779,8 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			  file, blocks, pos - firmware->size);
 
+	wm_adsp_debugfs_save_binname(dsp, file);
+
 out_fw:
 	regmap_async_complete(regmap);
 	release_firmware(firmware);
@@ -1619,6 +1794,9 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 {
 	INIT_LIST_HEAD(&dsp->alg_regions);
 
+#ifdef CONFIG_DEBUG_FS
+	mutex_init(&dsp->debugfs_lock);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
@@ -1874,6 +2052,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		wm_adsp_debugfs_clear(dsp);
+
+		dsp->fw_id = 0;
+		dsp->fw_id_version = 0;
 		dsp->running = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
@@ -1913,6 +2095,8 @@ EXPORT_SYMBOL_GPL(wm_adsp2_event);
 
 int wm_adsp2_codec_probe(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 {
+	wm_adsp2_init_debugfs(dsp, codec);
+
 	return snd_soc_add_codec_controls(codec,
 					  wm_adsp2_fw_controls[dsp->num - 1],
 					  ARRAY_SIZE(wm_adsp2_fw_controls[0]));
@@ -1921,6 +2105,8 @@ EXPORT_SYMBOL_GPL(wm_adsp2_codec_probe);
 
 int wm_adsp2_codec_remove(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 {
+	wm_adsp2_cleanup_debugfs(dsp);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_codec_remove);
@@ -1944,6 +2130,9 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 	INIT_LIST_HEAD(&dsp->ctl_list);
 	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
+#ifdef CONFIG_DEBUG_FS
+	mutex_init(&dsp->debugfs_lock);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 9059632..5042cbd 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -46,17 +46,26 @@ struct wm_adsp {
 	struct list_head alg_regions;
 
 	int fw_id;
+	int fw_id_version;
 
 	const struct wm_adsp_region *mem;
 	int num_mems;
 
 	int fw;
 	int fw_ver;
-	bool running;
+	u32 running;
 
 	struct list_head ctl_list;
 
 	struct work_struct boot_work;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_root;
+	struct mutex debugfs_lock;
+	char *wmfw_file_name;
+	char *bin_file_name;
+#endif
+
 };
 
 #define WM_ADSP1(wname, num) \
-- 
1.7.2.5
