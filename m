From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 3/3] HDA VIA: Replace buggy Mic Boost
Date: Mon, 15 Sep 2008 22:43:23 +0800
Message-ID: <20080915144323.GD8061@prithivi.gnumonks.org>
References: <20080915144005.GA8061@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 48C362413F
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Sep 2008 16:43:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080915144005.GA8061@prithivi.gnumonks.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Logan Li <loganli@viatech.com.cn>
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Replace buggy Mic Boost
    
VT1708S' Mic Boost should be hidden in hardware design according to some
customers' requirements.  However, in case of bugs, it has to be exhibited to
normal users, so we need to:
* open a software backdoor, which is disabled by default in hardware
* re-write .tlv & .info, to indicate the actual necessary info, which we cannot
  get from amplifier's capabiliies
    
Signed-off-by: Logan Li <LoganLi@viatech.com.cn>
Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -35,6 +35,7 @@
 /* 2008-04-09  Lydia Wang  Add mute front speaker when HP plugin             */
 /* 2008-04-09  Lydia Wang  Add Independent HP feature                        */
 /* 2008-05-28  Lydia Wang  Add second S/PDIF Out support for VT1702	     */
+/* 2008-09-15  Logan Li    Add VT1708S Mic Boost workaround/backdoor	     */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
@@ -87,6 +88,48 @@
 #define IS_VT1708S_VENDORID(x)		((x) >= 0x11060397 && (x) <= 0x11067397)
 #define IS_VT1702_VENDORID(x)		((x) >= 0x11060398 && (x) <= 0x11067398)
 
+enum VIA_HDA_CODEC {
+	UNKNOWN = -1,
+	VT1708,
+	VT1709_10CH,
+	VT1709_6CH,
+	VT1708B_8CH,
+	VT1708B_4CH,
+	VT1708S,
+	VT1702,
+	CODEC_TYPES,
+};
+
+static enum VIA_HDA_CODEC get_codec_type(u32 vendor_id)
+{
+	u16 ven_id = vendor_id >> 16;
+	u16 dev_id = vendor_id & 0xffff;
+	enum VIA_HDA_CODEC codec_type;
+
+	/* get codec type */
+	if (ven_id != 0x1106)
+		codec_type = UNKNOWN;
+	else if (dev_id >= 0x1708 && dev_id <= 0x170b)
+		codec_type = VT1708;
+	else if (dev_id >= 0xe710 && dev_id <= 0xe713)
+		codec_type = VT1709_10CH;
+	else if (dev_id >= 0xe714 && dev_id <= 0xe717)
+		codec_type = VT1709_6CH;
+	else if (dev_id >= 0xe720 && dev_id <= 0xe723)
+		codec_type = VT1708B_8CH;
+	else if (dev_id >= 0xe724 && dev_id <= 0xe727)
+		codec_type = VT1708B_4CH;
+	else if ((dev_id & 0xfff) == 0x397
+		 && (dev_id >> 12) < 8)
+		codec_type = VT1708S;
+	else if ((dev_id & 0xfff) == 0x398
+		 && (dev_id >> 12) < 8)
+		codec_type = VT1702;
+	else
+		codec_type = UNKNOWN;
+	return codec_type;
+};
+
 #define VIA_HP_EVENT		0x01
 #define VIA_GPIO_EVENT		0x02
 
@@ -102,6 +145,48 @@ enum {
 	AUTO_SEQ_SIDE
 };
 
+#define get_amp_nid(kc)	((kc)->private_value & 0xffff)
+
+/* Some VT1708S based boards gets the micboost setting wrong, so we have
+ * to apply some brute-force and re-write the TLV's by software. */
+static int mic_boost_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+			 unsigned int size, unsigned int __user *_tlv)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = get_amp_nid(kcontrol);
+
+	if (get_codec_type(codec->vendor_id) == VT1708S
+	    && (nid == 0x1a || nid == 0x1e)) {
+		if (size < 4 * sizeof(unsigned int))
+			return -ENOMEM;
+		if (put_user(1, _tlv))	/* SNDRV_CTL_TLVT_DB_SCALE */
+			return -EFAULT;
+		if (put_user(2 * sizeof(unsigned int), _tlv + 1))
+			return -EFAULT;
+		if (put_user(0, _tlv + 2)) /* offset = 0 */
+			return -EFAULT;
+		if (put_user(1000, _tlv + 3)) /* step size = 10 dB */
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int mic_boost_volume_info(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = get_amp_nid(kcontrol);
+
+	if (get_codec_type(codec->vendor_id) == VT1708S
+	    && (nid == 0x1a || nid == 0x1e)) {
+		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+		uinfo->count = 2;
+		uinfo->value.integer.min = 0;
+		uinfo->value.integer.max = 3;
+	}
+	return 0;
+}
+
 static struct snd_kcontrol_new vt1708_control_templates[] = {
 	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
 	HDA_CODEC_MUTE(NULL, 0, 0, 0),
@@ -2430,14 +2515,29 @@ static int patch_vt1708B_4ch(struct hda_codec *codec)
 
 /* Patch for VT1708S */
 
+/* VT1708S software backdoor based override for buggy hardware micboost
+ * setting */
+#define MIC_BOOST_VOLUME(xname, nid) {				\
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,		\
+	.name = xname,					\
+	.index = 0,					\
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |	\
+	SNDRV_CTL_ELEM_ACCESS_TLV_READ |		\
+	SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK,		\
+	.info = mic_boost_volume_info,			\
+	.get = snd_hda_mixer_amp_volume_get,		\
+	.put = snd_hda_mixer_amp_volume_put,		\
+	.tlv = { .c = mic_boost_tlv },			\
+	.private_value = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT) }
+
 /* capture mixer elements */
 static struct snd_kcontrol_new vt1708S_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x13, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x13, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x14, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x14, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Boost", 0x1A, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Front Mic Boost", 0x1E, 0x0, HDA_INPUT),
+	MIC_BOOST_VOLUME("Mic Boost Capture Volume", 0x1A),
+	MIC_BOOST_VOLUME("Front Mic Boost Capture Volume", 0x1E),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		/* The multiple "Capture Source" controls confuse alsamixer
@@ -2472,6 +2572,8 @@ static struct hda_verb vt1708S_volume_init_verbs[] = {
 	/* PW9, PW10  Output enable */
 	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{0x21, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
+	/* Enable Mic Boost Volume backdoor */
+	{0x1, 0xf98, 0x1},
 	{ }
 };
 


-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
