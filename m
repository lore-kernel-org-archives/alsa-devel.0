From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 21/31] HDA patch_via.c: Substitue
	snd_hda_override_amp_caps for MIC_BOOST_VOLUME
Date: Thu, 8 Oct 2009 13:47:21 +0800
Message-ID: <16685ee0910072247u61e9faady651314d04d8a783a@mail.gmail.com>
References: <16685ee0910050727j6667b29dn39c6bb0b32eace02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id CDC6F1039B4
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:47:22 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1483671bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:47:21 -0700 (PDT)
In-Reply-To: <16685ee0910050727j6667b29dn39c6bb0b32eace02@mail.gmail.com>
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Substitue snd_hda_override_amp_caps for MIC_BOOST_VOLUME

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   72 +++++++++-------------------------------------
 1 file changed, 15 insertions(+), 57 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -197,46 +197,6 @@
 	AUTO_SEQ_SIDE
 };

-/* Some VT1708S based boards gets the micboost setting wrong, so we have
- * to apply some brute-force and re-write the TLV's by software. */
-static int mic_boost_tlv(struct snd_kcontrol *kcontrol, int op_flag,
-			 unsigned int size, unsigned int __user *_tlv)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = get_amp_nid(kcontrol);
-
-	if (get_codec_type(codec) == VT1708S
-	    && (nid == 0x1a || nid == 0x1e)) {
-		if (size < 4 * sizeof(unsigned int))
-			return -ENOMEM;
-		if (put_user(1, _tlv))	/* SNDRV_CTL_TLVT_DB_SCALE */
-			return -EFAULT;
-		if (put_user(2 * sizeof(unsigned int), _tlv + 1))
-			return -EFAULT;
-		if (put_user(0, _tlv + 2)) /* offset = 0 */
-			return -EFAULT;
-		if (put_user(1000, _tlv + 3)) /* step size = 10 dB */
-			return -EFAULT;
-	}
-	return 0;
-}
-
-static int mic_boost_volume_info(struct snd_kcontrol *kcontrol,
-				 struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = get_amp_nid(kcontrol);
-
-	if (get_codec_type(codec) == VT1708S
-	    && (nid == 0x1a || nid == 0x1e)) {
-		uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-		uinfo->count = 2;
-		uinfo->value.integer.min = 0;
-		uinfo->value.integer.max = 3;
-	}
-	return 0;
-}
-
 static void analog_low_current_mode(struct hda_codec *codec, int stream_idle);
 static void set_jack_power_state(struct hda_codec *codec);
 static int is_aa_path_mute(struct hda_codec *codec);
@@ -3078,29 +3038,15 @@

 /* Patch for VT1708S */

-/* VT1708S software backdoor based override for buggy hardware micboost
- * setting */
-#define MIC_BOOST_VOLUME(xname, nid) {				\
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,		\
-	.name = xname,					\
-	.index = 0,					\
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |	\
-	SNDRV_CTL_ELEM_ACCESS_TLV_READ |		\
-	SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK,		\
-	.info = mic_boost_volume_info,			\
-	.get = snd_hda_mixer_amp_volume_get,		\
-	.put = snd_hda_mixer_amp_volume_put,		\
-	.tlv = { .c = mic_boost_tlv },			\
-	.private_value = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT) }
-
 /* capture mixer elements */
 static struct snd_kcontrol_new vt1708S_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x13, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x13, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Volume", 1, 0x14, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE_IDX("Capture Switch", 1, 0x14, 0x0, HDA_INPUT),
-	MIC_BOOST_VOLUME("Mic Boost Capture Volume", 0x1A),
-	MIC_BOOST_VOLUME("Front Mic Boost Capture Volume", 0x1E),
+	HDA_CODEC_VOLUME("Mic Boost Capture Volume", 0x1A, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Front Mic Boost Capture Volume", 0x1E, 0x0,
+			 HDA_INPUT),
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
 		/* The multiple "Capture Source" controls confuse alsamixer
@@ -3472,6 +3418,16 @@
 };
 #endif

+static void override_mic_boost(struct hda_codec *codec, hda_nid_t pin,
+			       int offset, int num_steps, int step_size)
+{
+	snd_hda_override_amp_caps(codec, pin, HDA_INPUT,
+				  (offset << AC_AMPCAP_OFFSET_SHIFT) |
+				  (num_steps << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				  (step_size << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				  (0 << AC_AMPCAP_MUTE_SHIFT));
+}
+
 static int patch_vt1708S(struct hda_codec *codec)
 {
 	struct via_spec *spec;
@@ -3508,6 +3464,8 @@
 		spec->adc_nids = vt1708S_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1708S_adc_nids);
 		get_mux_nids(codec);
+		override_mic_boost(codec, 0x1a, 0, 3, 40);
+		override_mic_boost(codec, 0x1e, 0, 3, 40);
 		spec->mixers[spec->num_mixers] = vt1708S_capture_mixer;
 		spec->num_mixers++;
 	}
