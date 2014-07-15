From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC v2] ASoC: core: add a helper for extended byte
	controls using TLV
Date: Tue, 15 Jul 2014 12:17:45 +0530
Message-ID: <1405406865-10636-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 66F0126172C
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 08:50:58 +0200 (CEST)
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
As discussed in [1] we are adding a new approach to solve the byte control
extensions by using existing TLVs and combining them with byte controls.  The
usermode on seeing byte control + TLV can treat it differently as it does for
control + TLV combination today. This way we don't change kernel API and
existing users will be happy, while providing embedded folks facility to pass
large bytes data to kcontrols
[1]:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069483.html

 include/sound/soc.h  |   14 +++++++++++++-
 sound/soc/soc-core.c |   22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ed9e2d7..7522221 100644
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
+		{.max = xcount, .get = xhandler_get, .put = xhandler_put, }}
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
index b87d7d8..e6ad95b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3267,6 +3267,28 @@ int snd_soc_bytes_info_ext(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_bytes_info_ext);
 
+int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
+				unsigned int size, unsigned int __user *tlv)
+{
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+	unsigned int count = size < params->max ? size : params->max;
+
+	switch (op_flag) {
+	case 0:
+		if (params->get)
+			params->get(tlv, count);
+		break;
+	case 1:
+		if (params->put)
+			params->put(tlv, count);
+		break;
+	default:
+		return -ENXIO;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_bytes_tlv_callback);
+
 /**
  * snd_soc_info_xr_sx - signed multi register info callback
  * @kcontrol: mreg control
-- 
1.7.0.4
