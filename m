From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Add basic debugfs entries
Date: Mon,  8 Jun 2015 15:37:02 +0100
Message-ID: <1433774222-25103-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds some debugfs nodes to get information
about the currently running firmware.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c  |    4 +
 sound/soc/codecs/wm5110.c  |    9 ++-
 sound/soc/codecs/wm_adsp.c |  182 ++++++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm_adsp.h |   25 ++++++-
 4 files changed, 212 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 11eba0e..22fc9e9 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1875,6 +1875,8 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
+	wm_adsp_init_debugfs(&priv->core.adsp[0], codec);
+
 	ret = snd_soc_add_codec_controls(codec, wm_adsp2_fw_controls, 2);
 	if (ret != 0)
 		return ret;
@@ -1893,6 +1895,8 @@ static int wm5102_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
 
+	wm_adsp_cleanup_debugfs(&priv->core.adsp[0]);
+
 	priv->core.arizona->dapm = NULL;
 
 	return 0;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index d65364e..f9ca1a9 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1599,7 +1599,10 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
 {
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
-	int ret;
+	int i, ret;
+
+	for (i = 0; i < WM5110_NUM_ADSP; i++)
+		wm_adsp_init_debugfs(&priv->core.adsp[i], codec);
 
 	priv->core.arizona->dapm = &codec->dapm;
 
@@ -1621,6 +1624,10 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 static int wm5110_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int i;
+
+	for (i = 0; i < WM5110_NUM_ADSP; i++)
+		wm_adsp_cleanup_debugfs(&priv->core.adsp[i]);
 
 	priv->core.arizona->dapm = NULL;
 
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6e358b5..c8def3ea 100644
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
@@ -243,6 +244,26 @@ struct wm_coeff_ctl {
 	unsigned int flags;
 };
 
+#ifdef CONFIG_DEBUG_FS
+static void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp, const char *s);
+static void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp, const char *s);
+static void wm_adsp_debugfs_clear(struct wm_adsp *dsp);
+#else
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
@@ -1104,6 +1125,8 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			  file, regions, pos - firmware->size);
 
+	wm_adsp_debugfs_save_wmfwname(dsp, file);
+
 out_fw:
 	regmap_async_complete(regmap);
 	wm_adsp_buf_free(&buf_list);
@@ -1218,11 +1241,12 @@ static int wm_adsp1_setup_algs(struct wm_adsp *dsp)
 
 	n_algs = be32_to_cpu(adsp1_id.n_algs);
 	dsp->fw_id = be32_to_cpu(adsp1_id.fw.id);
+	dsp->fw_id_version = be32_to_cpu(adsp1_id.fw.ver);
 	adsp_info(dsp, "Firmware: %x v%d.%d.%d, %zu algorithms\n",
 		  dsp->fw_id,
-		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff0000) >> 16,
-		  (be32_to_cpu(adsp1_id.fw.ver) & 0xff00) >> 8,
-		  be32_to_cpu(adsp1_id.fw.ver) & 0xff,
+		  (dsp->fw_id_version & 0xff0000) >> 16,
+		  (dsp->fw_id_version & 0xff00) >> 8,
+		  dsp->fw_id_version & 0xff,
 		  n_algs);
 
 	alg_region = wm_adsp_create_region(dsp, WMFW_ADSP1_ZM,
@@ -1321,11 +1345,12 @@ static int wm_adsp2_setup_algs(struct wm_adsp *dsp)
 
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
@@ -1601,6 +1626,8 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 		adsp_warn(dsp, "%s.%d: %zu bytes at end of file\n",
 			  file, blocks, pos - firmware->size);
 
+	wm_adsp_debugfs_save_binname(dsp, file);
+
 out_fw:
 	regmap_async_complete(regmap);
 	release_firmware(firmware);
@@ -1869,6 +1896,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
+		wm_adsp_debugfs_clear(dsp);
+
+		dsp->fw_id = 0;
+		dsp->fw_id_version = 0;
 		dsp->running = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
@@ -1929,4 +1960,143 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
 
+#ifdef CONFIG_DEBUG_FS
+static void wm_adsp_debugfs_save_wmfwname(struct wm_adsp *dsp, const char *s)
+{
+	kfree(dsp->wmfw_file_name);
+	dsp->wmfw_file_name = kstrdup(s, GFP_KERNEL);
+}
+
+static void wm_adsp_debugfs_save_binname(struct wm_adsp *dsp, const char *s)
+{
+	kfree(dsp->bin_file_name);
+	dsp->bin_file_name = kstrdup(s, GFP_KERNEL);
+}
+
+static void wm_adsp_debugfs_clear(struct wm_adsp *dsp)
+{
+	kfree(dsp->wmfw_file_name);
+	kfree(dsp->bin_file_name);
+	dsp->wmfw_file_name = NULL;
+	dsp->bin_file_name = NULL;
+}
+
+static ssize_t wm_adsp_debugfs_string_read(struct wm_adsp *dsp,
+					  char __user *user_buf,
+					  size_t count, loff_t *ppos,
+					  const char *string)
+{
+	char *temp;
+	int len;
+	ssize_t ret;
+
+	if (!string || !dsp->running)
+		return 0;
+
+	temp = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	len = snprintf(temp, PAGE_SIZE, "%s\n", string);
+	ret = simple_read_from_buffer(user_buf, count, ppos, temp, len);
+	kfree(temp);
+	return ret;
+}
+
+static ssize_t wm_adsp_debugfs_wmfw_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct wm_adsp *dsp = file->private_data;
+
+	return wm_adsp_debugfs_string_read(dsp, user_buf, count, ppos,
+					   dsp->wmfw_file_name);
+}
+
+static ssize_t wm_adsp_debugfs_bin_read(struct file *file,
+					 char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct wm_adsp *dsp = file->private_data;
+
+	return wm_adsp_debugfs_string_read(dsp, user_buf, count, ppos,
+					   dsp->bin_file_name);
+}
+
+static const struct {
+	const char *name;
+	const struct file_operations fops;
+} wm_adsp_debugfs_fops[] = {
+	{
+		.name = "wmfw_file",
+		.fops = {
+			.open = simple_open,
+			.read = wm_adsp_debugfs_wmfw_read,
+		},
+	},
+	{
+		.name = "bin_file",
+		.fops = {
+			.open = simple_open,
+			.read = wm_adsp_debugfs_bin_read,
+		},
+	},
+};
+
+void wm_adsp_init_debugfs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
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
+EXPORT_SYMBOL_GPL(wm_adsp_init_debugfs);
+
+
+void wm_adsp_cleanup_debugfs(struct wm_adsp *dsp)
+{
+	debugfs_remove_recursive(dsp->debugfs_root);
+}
+EXPORT_SYMBOL_GPL(wm_adsp_cleanup_debugfs);
+#endif
+
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 0e5f07c..1d563fe 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -46,17 +46,25 @@ struct wm_adsp {
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
+	char *wmfw_file_name;
+	char *bin_file_name;
+#endif
+
 };
 
 #define WM_ADSP1(wname, num) \
@@ -79,6 +87,21 @@ extern const struct snd_kcontrol_new wm_adsp2_fw_controls[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
 int wm_adsp2_init(struct wm_adsp *dsp);
+
+#ifdef CONFIG_DEBUG_FS
+void wm_adsp_init_debugfs(struct wm_adsp *dsp, struct snd_soc_codec *codec);
+void wm_adsp_cleanup_debugfs(struct wm_adsp *dsp);
+#else
+static inline void wm_adsp_init_debugfs(struct wm_adsp *dsp,
+					struct snd_soc_codec *codec)
+{
+}
+
+void wm_adsp_cleanup_debugfs(struct wm_adsp *dsp)
+{
+}
+#endif
+
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
-- 
1.7.2.5
