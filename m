From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/5] ASoC: intel: add support for specifying
	PCM format
Date: Wed,  6 May 2015 22:06:43 +0530
Message-ID: <1430930204-32184-5-git-send-email-vinod.koul@intel.com>
References: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C3456265802
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:36:42 +0200 (CEST)
In-Reply-To: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, praveen.diwakar@intel.com, liam.r.girdwood@linux.intel.com, yang.a.fang@intel.com, broonie@kernel.org, sathyanarayana.nujella@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

With this machines can configure the PCM format applied on SSP port using
the set_fmt API

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c     | 99 ++++++++++++++++++++++++++++
 sound/soc/intel/atom/sst-atom-controls.h     |  1 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 15 +++++
 3 files changed, 115 insertions(+)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 93c6c8b5fbc6..e024d98948fa 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -774,8 +774,107 @@ int sst_handle_vb_timer(struct snd_soc_dai *dai, bool enable)
 	return ret;
 }
 
+static int sst_get_frame_sync_polarity(struct snd_soc_dai *dai,
+		unsigned int fmt)
+{
+	int format;
+
+	format = fmt & SND_SOC_DAIFMT_INV_MASK;
+	dev_dbg(dai->dev, "Enter:%s, format=%x\n", __func__, format);
+
+	switch (format) {
+	case SND_SOC_DAIFMT_NB_NF:
+		return SSP_FS_ACTIVE_LOW;
+	case SND_SOC_DAIFMT_NB_IF:
+		return SSP_FS_ACTIVE_HIGH;
+	case SND_SOC_DAIFMT_IB_IF:
+		return SSP_FS_ACTIVE_LOW;
+	case SND_SOC_DAIFMT_IB_NF:
+		return SSP_FS_ACTIVE_HIGH;
+	default:
+		dev_err(dai->dev, "Invalid frame sync polarity %d\n", format);
+	}
+
+	return -EINVAL;
+}
+
+static int sst_get_ssp_mode(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	int format;
+
+	format = (fmt & SND_SOC_DAIFMT_MASTER_MASK);
+	dev_dbg(dai->dev, "Enter:%s, format=%x\n", __func__, format);
+
+	switch (format) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		return SSP_MODE_MASTER;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		return SSP_MODE_SLAVE;
+	default:
+		dev_err(dai->dev, "Invalid ssp protocol: %d\n", format);
+	}
+
+	return -EINVAL;
+}
+
+
+int sst_fill_ssp_config(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	unsigned int mode;
+	int fs_polarity;
+	struct sst_data *ctx = snd_soc_dai_get_drvdata(dai);
+
+	mode = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+
+	switch (mode) {
+	case SND_SOC_DAIFMT_DSP_B:
+		ctx->ssp_cmd.ssp_protocol = SSP_MODE_PCM;
+		ctx->ssp_cmd.mode = sst_get_ssp_mode(dai, fmt) | (SSP_PCM_MODE_NETWORK << 1);
+		ctx->ssp_cmd.start_delay = 0;
+		ctx->ssp_cmd.data_polarity = 1;
+		ctx->ssp_cmd.frame_sync_width = 1;
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A:
+		ctx->ssp_cmd.ssp_protocol = SSP_MODE_PCM;
+		ctx->ssp_cmd.mode = sst_get_ssp_mode(dai, fmt) | (SSP_PCM_MODE_NETWORK << 1);
+		ctx->ssp_cmd.start_delay = 1;
+		ctx->ssp_cmd.data_polarity = 1;
+		ctx->ssp_cmd.frame_sync_width = 1;
+		break;
+
+	case SND_SOC_DAIFMT_I2S:
+		ctx->ssp_cmd.ssp_protocol = SSP_MODE_I2S;
+		ctx->ssp_cmd.mode = sst_get_ssp_mode(dai, fmt) | (SSP_PCM_MODE_NORMAL << 1);
+		ctx->ssp_cmd.start_delay = 1;
+		ctx->ssp_cmd.data_polarity = 0;
+		ctx->ssp_cmd.frame_sync_width = ctx->ssp_cmd.nb_bits_per_slots;
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctx->ssp_cmd.ssp_protocol = SSP_MODE_I2S;
+		ctx->ssp_cmd.mode = sst_get_ssp_mode(dai, fmt) | (SSP_PCM_MODE_NORMAL << 1);
+		ctx->ssp_cmd.start_delay = 0;
+		ctx->ssp_cmd.data_polarity = 0;
+		ctx->ssp_cmd.frame_sync_width = ctx->ssp_cmd.nb_bits_per_slots;
+		break;
+
+	default:
+		dev_dbg(dai->dev, "using default ssp configs\n");
+	}
+
+	fs_polarity = sst_get_frame_sync_polarity(dai, fmt);
+	if (fs_polarity < 0)
+		return fs_polarity;
+
+	ctx->ssp_cmd.frame_sync_polarity = fs_polarity;
+
+	return 0;
+}
+
 /**
  * sst_ssp_config - contains SSP configuration for media UC
+ * this can be overwritten by set_dai_xxx APIs
  */
 static const struct sst_ssp_config sst_ssp_configs = {
 	.ssp_id = SSP_CODEC,
diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index da13f6fa7d1c..53551a657b51 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -869,6 +869,7 @@ struct sst_enum {
 	SOC_DAPM_ENUM(SST_MUX_CTL_NAME(xpname, xinstance), \
 			  SST_SSP_MUX_ENUM(xreg, xshift, xtexts))
 
+int sst_fill_ssp_config(struct snd_soc_dai *dai, unsigned int fmt);
 void sst_fill_ssp_defaults(struct snd_soc_dai *dai);
 
 #endif
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 1fb2448e0fed..580f5e92580e 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -450,6 +450,20 @@ static int sst_be_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int sst_set_format(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	int ret = 0;
+
+	if (!dai->active)
+		return 0;
+
+	ret = sst_fill_ssp_config(dai, fmt);
+	if (ret < 0)
+		dev_err(dai->dev, "sst_set_format failed..\n");
+
+	return ret;
+}
+
 static void sst_disable_ssp(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
@@ -475,6 +489,7 @@ static struct snd_soc_dai_ops sst_compr_dai_ops = {
 static struct snd_soc_dai_ops sst_be_dai_ops = {
 	.startup = sst_enable_ssp,
 	.hw_params = sst_be_hw_params,
+	.set_fmt = sst_set_format,
 	.shutdown = sst_disable_ssp,
 };
 
-- 
1.9.1
