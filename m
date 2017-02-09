From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: Skylake: Check device type to
	get endpoint configuration
Date: Thu,  9 Feb 2017 16:44:01 +0530
Message-ID: <1486638844-17975-2-git-send-email-subhransu.s.prusty@intel.com>
References: <1486638844-17975-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D3A252669B5
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 12:24:50 +0100 (CET)
In-Reply-To: <1486638844-17975-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>

Geminilake has two different devices connected to the same SSP, so use
device_type check to get correct device configuration.

Signed-off-by: Senthilnathan Veppur <senthilnathanx.veppur@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.c     | 16 ++++++++++------
 sound/soc/intel/skylake/skl-topology.c | 32 ++++++++++++++++++++++++++++++--
 sound/soc/intel/skylake/skl.h          |  3 ++-
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 2710a3704a38..7eb9c419dc7f 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -102,14 +102,16 @@ static void dump_config(struct device *dev, u32 instance_id, u8 linktype,
 }
 
 static bool skl_check_ep_match(struct device *dev, struct nhlt_endpoint *epnt,
-				u32 instance_id, u8 link_type, u8 dirn)
+		u32 instance_id, u8 link_type, u8 dirn, u8 dev_type)
 {
-	dev_dbg(dev, "vbus_id=%d link_type=%d dir=%d\n",
-		epnt->virtual_bus_id, epnt->linktype, epnt->direction);
+	dev_dbg(dev, "vbus_id=%d link_type=%d dir=%d dev_type = %d\n",
+			epnt->virtual_bus_id, epnt->linktype,
+			epnt->direction, epnt->device_type);
 
 	if ((epnt->virtual_bus_id == instance_id) &&
 			(epnt->linktype == link_type) &&
-			(epnt->direction == dirn))
+			(epnt->direction == dirn) &&
+			(epnt->device_type == dev_type))
 		return true;
 	else
 		return false;
@@ -117,7 +119,8 @@ static bool skl_check_ep_match(struct device *dev, struct nhlt_endpoint *epnt,
 
 struct nhlt_specific_cfg
 *skl_get_ep_blob(struct skl *skl, u32 instance, u8 link_type,
-			u8 s_fmt, u8 num_ch, u32 s_rate, u8 dirn)
+			u8 s_fmt, u8 num_ch, u32 s_rate,
+			u8 dirn, u8 dev_type)
 {
 	struct nhlt_fmt *fmt;
 	struct nhlt_endpoint *epnt;
@@ -135,7 +138,8 @@ struct nhlt_specific_cfg
 	dev_dbg(dev, "endpoint count =%d\n", nhlt->endpoint_count);
 
 	for (j = 0; j < nhlt->endpoint_count; j++) {
-		if (skl_check_ep_match(dev, epnt, instance, link_type, dirn)) {
+		if (skl_check_ep_match(dev, epnt, instance, link_type,
+						dirn, dev_type)) {
 			fmt = (struct nhlt_fmt *)(epnt->config.caps +
 						 epnt->config.size);
 			sp_config = skl_get_specific_cfg(dev, fmt, num_ch,
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index e6e76237f46b..ed58b5b3555a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -330,6 +330,31 @@ static void skl_tplg_update_buffer_size(struct skl_sst *ctx,
 			multiplier;
 }
 
+static u8 skl_tplg_be_dev_type(int dev_type)
+{
+	int ret;
+
+	switch (dev_type) {
+	case SKL_DEVICE_BT:
+		ret = NHLT_DEVICE_BT;
+		break;
+
+	case SKL_DEVICE_DMIC:
+		ret = NHLT_DEVICE_DMIC;
+		break;
+
+	case SKL_DEVICE_I2S:
+		ret = NHLT_DEVICE_I2S;
+		break;
+
+	default:
+		ret = NHLT_DEVICE_INVALID;
+		break;
+	}
+
+	return ret;
+}
+
 static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
 						struct skl_sst *ctx)
 {
@@ -338,6 +363,7 @@ static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
 	u32 ch, s_freq, s_fmt;
 	struct nhlt_specific_cfg *cfg;
 	struct skl *skl = get_skl_ctx(ctx->dev);
+	u8 dev_type = skl_tplg_be_dev_type(m_cfg->dev_type);
 
 	/* check if we already have blob */
 	if (m_cfg->formats_config.caps_size > 0)
@@ -374,7 +400,7 @@ static int skl_tplg_update_be_blob(struct snd_soc_dapm_widget *w,
 
 	/* update the blob based on virtual bus_id and default params */
 	cfg = skl_get_ep_blob(skl, m_cfg->vbus_id, link_type,
-					s_fmt, ch, s_freq, dir);
+					s_fmt, ch, s_freq, dir, dev_type);
 	if (cfg) {
 		m_cfg->formats_config.caps_size = cfg->size;
 		m_cfg->formats_config.caps = (u32 *) &cfg->caps;
@@ -1448,6 +1474,7 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 	struct nhlt_specific_cfg *cfg;
 	struct skl *skl = get_skl_ctx(dai->dev);
 	int link_type = skl_tplg_be_link_type(mconfig->dev_type);
+	u8 dev_type = skl_tplg_be_dev_type(mconfig->dev_type);
 
 	skl_tplg_fill_dma_id(mconfig, params);
 
@@ -1457,7 +1484,8 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 	/* update the blob based on virtual bus_id*/
 	cfg = skl_get_ep_blob(skl, mconfig->vbus_id, link_type,
 					params->s_fmt, params->ch,
-					params->s_freq, params->stream);
+					params->s_freq, params->stream,
+					dev_type);
 	if (cfg) {
 		mconfig->formats_config.caps_size = cfg->size;
 		mconfig->formats_config.caps = (u32 *) &cfg->caps;
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 0a1b02e21277..bbef77d2b917 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -118,7 +118,8 @@ struct skl_dsp_ops {
 struct nhlt_acpi_table *skl_nhlt_init(struct device *dev);
 void skl_nhlt_free(struct nhlt_acpi_table *addr);
 struct nhlt_specific_cfg *skl_get_ep_blob(struct skl *skl, u32 instance,
-			u8 link_type, u8 s_fmt, u8 no_ch, u32 s_rate, u8 dirn);
+					u8 link_type, u8 s_fmt, u8 no_ch,
+					u32 s_rate, u8 dirn, u8 dev_type);
 
 int skl_get_dmic_geo(struct skl *skl);
 int skl_nhlt_update_topology_bin(struct skl *skl);
-- 
1.9.1
