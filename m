From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: add SND_SOC_BYTES_EXT
Date: Fri,  2 May 2014 10:58:11 +0530
Message-ID: <1399008491-22388-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B39D22654AA
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 07:40:46 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

we need _EXT version for SND_SOC_BYTES so that DSPs can use this to pass data
for DSP modules

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h  |   13 +++++++++++++
 sound/soc/soc-core.c |   13 +++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0b83168..63202cf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -266,6 +266,13 @@
 		{.base = xbase, .num_regs = xregs,	      \
 		 .mask = xmask }) }
 
+#define SND_SOC_BYTES_EXT(xname, xcount, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_bytes_info_ext, \
+	.get = xhandler_get, .put = xhandler_put, \
+	.private_value = (unsigned long)&(struct soc_bytes_ext) \
+		{.max = xcount} }
+
 #define SOC_SINGLE_XR_SX(xname, xregbase, xregcount, xnbits, \
 		xmin, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -540,6 +547,8 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol);
 int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol);
+int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *ucontrol);
 int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
@@ -1090,6 +1099,10 @@ struct soc_bytes {
 	u32 mask;
 };
 
+struct soc_bytes_ext {
+	int max;
+};
+
 /* multi register control */
 struct soc_mreg_control {
 	long min, max;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 051c006..48e4bba 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3297,6 +3297,19 @@ out:
 }
 EXPORT_SYMBOL_GPL(snd_soc_bytes_put);
 
+int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+
+	ucontrol->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	ucontrol->count = params->max;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_bytes_info_ext);
+
 /**
  * snd_soc_info_xr_sx - signed multi register info callback
  * @kcontrol: mreg control
-- 
1.7.0.4
