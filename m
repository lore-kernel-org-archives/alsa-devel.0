From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/5] ASoC: Intel: add support for configuring
	TDM slots for SSP
Date: Wed,  6 May 2015 22:06:44 +0530
Message-ID: <1430930204-32184-6-git-send-email-vinod.koul@intel.com>
References: <1430930204-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E34D26586F
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 18:36:45 +0200 (CEST)
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

With this machines can now configure TDM settings for SSP port using
set_tdm_slot API

Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c     | 13 +++++++++++++
 sound/soc/intel/atom/sst-atom-controls.h     |  2 ++
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 16 ++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index e024d98948fa..61e240935451 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -774,6 +774,19 @@ int sst_handle_vb_timer(struct snd_soc_dai *dai, bool enable)
 	return ret;
 }
 
+int sst_fill_ssp_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+		unsigned int rx_mask, int slots, int slot_width)
+{
+	struct sst_data *ctx = snd_soc_dai_get_drvdata(dai);
+
+	ctx->ssp_cmd.nb_slots = slots;
+	ctx->ssp_cmd.active_tx_slot_map = tx_mask;
+	ctx->ssp_cmd.active_rx_slot_map = rx_mask;
+	ctx->ssp_cmd.nb_bits_per_slots = slot_width;
+
+	return 0;
+}
+
 static int sst_get_frame_sync_polarity(struct snd_soc_dai *dai,
 		unsigned int fmt)
 {
diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index 53551a657b51..93de8045d4e1 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -869,6 +869,8 @@ struct sst_enum {
 	SOC_DAPM_ENUM(SST_MUX_CTL_NAME(xpname, xinstance), \
 			  SST_SSP_MUX_ENUM(xreg, xshift, xtexts))
 
+int sst_fill_ssp_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				unsigned int rx_mask, int slots, int slot_width);
 int sst_fill_ssp_config(struct snd_soc_dai *dai, unsigned int fmt);
 void sst_fill_ssp_defaults(struct snd_soc_dai *dai);
 
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 580f5e92580e..641ebe61dc08 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -464,6 +464,21 @@ static int sst_set_format(struct snd_soc_dai *dai, unsigned int fmt)
 	return ret;
 }
 
+static int sst_platform_set_ssp_slot(struct snd_soc_dai *dai,
+			unsigned int tx_mask, unsigned int rx_mask,
+			int slots, int slot_width) {
+	int ret = 0;
+
+	if (!dai->active)
+		return ret;
+
+	ret = sst_fill_ssp_slot(dai, tx_mask, rx_mask, slots, slot_width);
+	if (ret < 0)
+		dev_err(dai->dev, "sst_fill_ssp_slot failed..%d\n", ret);
+
+	return ret;
+}
+
 static void sst_disable_ssp(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
@@ -490,6 +505,7 @@ static struct snd_soc_dai_ops sst_be_dai_ops = {
 	.startup = sst_enable_ssp,
 	.hw_params = sst_be_hw_params,
 	.set_fmt = sst_set_format,
+	.set_tdm_slot = sst_platform_set_ssp_slot,
 	.shutdown = sst_disable_ssp,
 };
 
-- 
1.9.1
