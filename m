From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3] ASoC: core: add a helper for extended byte
	controls using TLV
Date: Tue, 15 Jul 2014 21:34:48 +0530
Message-ID: <1405440288-15958-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A5AB0261987
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 18:08:00 +0200 (CEST)
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
Cc: Charles Keepax <Charles.Keepax@Wolfsonmicro.com>, Dimitris Papastamos <Dimitris.Papastamos@Wolfsonmicro.com>, tiwai@suse.de, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

From: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>

ALSA supports arbitrary length TLVs for each kcontrol that can be used
to pass metadata about the control (e.g. volumes, enum information). The
same transport mechanism is now used for arbitrary length data by
defining a new helper.

Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
Changes in v3:
- rebased on tlv-opflag
- fix return error for hanlders/missing ones

 include/sound/soc.h  |   14 +++++++++++++-
 sound/soc/soc-core.c |   21 +++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ed9e2d7..688fa66 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -270,7 +270,14 @@
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = (unsigned long)&(struct soc_bytes_ext) \
 		{.max = xcount} }
-
+#define SND_SOC_BYTES_TLV(xname, xcount, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE | \
+		  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
+	.tlv.c = (snd_soc_bytes_tlv_callback), \
+	.info = snd_soc_info_bytes_ext, \
+	.private_value = (unsigned long)&(struct soc_bytes_ext) \
+		{.max = xcount, .get = xhandler_get, .put = xhandler_put, } }
 #define SOC_SINGLE_XR_SX(xname, xregbase, xregcount, xnbits, \
 		xmin, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
@@ -552,6 +559,8 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
 		      struct snd_ctl_elem_value *ucontrol);
 int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *ucontrol);
+int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
+	unsigned int size, unsigned int __user *tlv);
 int snd_soc_info_xr_sx(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
@@ -1119,6 +1128,9 @@ struct soc_bytes {
 
 struct soc_bytes_ext {
 	int max;
+	/* used for TLV byte control */
+	int (*get)(unsigned int __user *bytes, unsigned int size);
+	int (*put)(const unsigned int __user *bytes, unsigned int size);
 };
 
 /* multi register control */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b87d7d8..a9ce63f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3267,6 +3267,27 @@ int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_bytes_info_ext);
 
+int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
+				unsigned int size, unsigned int __user *tlv)
+{
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+	unsigned int count = size < params->max ? size : params->max;
+	int ret = -ENXIO;
+
+	switch (op_flag) {
+	case SNDRV_CTL_TLV_OP_READ:
+		if (params->get)
+			ret = params->get(tlv, count);
+		break;
+	case SNDRV_CTL_TLV_OP_WRITE:
+		if (params->put)
+			ret = params->put(tlv, count);
+		break;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_bytes_tlv_callback);
+
 /**
  * snd_soc_info_xr_sx - signed multi register info callback
  * @kcontrol: mreg control
-- 
1.7.0.4
