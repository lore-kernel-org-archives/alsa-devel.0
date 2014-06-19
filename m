From: Kailang <kailang@realtek.com>
Subject: Re: Enable HP machine to enable capture mute led
	and	output mute led
Date: Thu, 19 Jun 2014 16:18:36 +0800
Message-ID: <52DAB1E96D7E428E8B727EDD42CCED01@realtek.com.tw>
References: <561C9577BEE34837ADA1F3C2AD57F508@realtek.com.tw>
 <s5h61jybhpl.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_00EA_01CF8BDA.1FC63AD0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 14D7326525F
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 10:18:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_00EA_01CF8BDA.1FC63AD0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Attach again.
It include below infomations.
Thanks.

> At Wed, 18 Jun 2014 17:13:57 +0800,
> Kailang wrote:
>> 
>> Hi Takashi,
>> 
>> Attach was HP mute led support patch.
>> It use Line1 vref and Mic1 vref to control mute led for ALC282.
>> Line1 vref to control output mute led.
>> Mic1 vref to control input mute led.
>> 
>> It use GPIO3 and Mic1 vref to control mute led for ALC280.
>> GPIO3 to control output mute led.
>> Mic1 vref to control input mute led.
> 
> Could you include this kind of information in the patch changelog?
> The changelog text is way too short.
> 
>> For the DMI string for output mute led application.
>> I already request from HP to support it in next release.
>> 
>> HP_Mute_LED_0_A  => use Mic1 vref to control mute led.
>> Is the string right?
>> I have tested upper string for Mic1 mute led.
> 
> Yes, this has been working for some machines, AFAIK.
> 
> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
------=_NextPart_000_00EA_01CF8BDA.1FC63AD0
Content-Type: application/octet-stream; name="0001-new-hp-mute-led.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0001-new-hp-mute-led.patch"

>From 4af54b7b4110226b6517d7da37d1a55ce07ae2c0 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Thu, 19 Jun 2014 16:11:36 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Support HP mute led for output and =
input=0A=
=0A=
HP mute led support output mute led and input mute led.=0A=
ALC280:=0A=
GPIO3 to control output mute led.=0A=
Mic1 vref to control input mute led.=0A=
ALC282:=0A=
Line1 vref to control output mute led.=0A=
Mic1 vref to control input mute led.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index af76995..4852120 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -101,6 +101,7 @@ struct alc_spec {=0A=
 	/* mute LED for HP laptops, see alc269_fixup_mic_mute_hook() */=0A=
 	int mute_led_polarity;=0A=
 	hda_nid_t mute_led_nid;=0A=
+	hda_nid_t cap_mute_led_nid;=0A=
 =0A=
 	unsigned int gpio_led; /* used for alc269_fixup_hp_gpio_led() */=0A=
 =0A=
@@ -3520,6 +3521,67 @@ static void alc269_fixup_hp_gpio_led(struct =
hda_codec *codec,=0A=
 	}=0A=
 }=0A=
 =0A=
+/* turn on/off mic-mute LED per capture hook */=0A=
+static void alc269_fixup_hp_cap_mic_mute_hook(struct hda_codec *codec,=0A=
+					       struct snd_kcontrol *kcontrol,=0A=
+					       struct snd_ctl_elem_value *ucontrol)=0A=
+{=0A=
+	struct alc_spec *spec =3D codec->spec;=0A=
+	unsigned int pinval, enable, disable;=0A=
+=0A=
+	pinval =3D snd_hda_codec_get_pin_target(codec, spec->mute_led_nid);=0A=
+	pinval &=3D ~AC_PINCTL_VREFEN;=0A=
+	enable  =3D pinval | AC_PINCTL_VREF_80;=0A=
+	disable =3D pinval | AC_PINCTL_VREF_HIZ;=0A=
+=0A=
+	if (!ucontrol)=0A=
+		return;=0A=
+=0A=
+	if (ucontrol->value.integer.value[0] ||=0A=
+	    ucontrol->value.integer.value[1])=0A=
+		pinval =3D disable;=0A=
+	else=0A=
+		pinval =3D enable;=0A=
+=0A=
+	if (spec->cap_mute_led_nid)=0A=
+		snd_hda_set_pin_ctl_cache(codec, spec->cap_mute_led_nid, pinval);=0A=
+}=0A=
+=0A=
+static void alc269_fixup_hp_gpio_mic1_led(struct hda_codec *codec,=0A=
+				const struct hda_fixup *fix, int action)=0A=
+{=0A=
+	struct alc_spec *spec =3D codec->spec;=0A=
+	static const struct hda_verb gpio_init[] =3D {=0A=
+		{ 0x01, AC_VERB_SET_GPIO_MASK, 0x08 },=0A=
+		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x08 },=0A=
+		{}=0A=
+	};=0A=
+=0A=
+	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {=0A=
+		spec->gen.vmaster_mute.hook =3D alc269_fixup_hp_gpio_mute_hook;=0A=
+		spec->gen.cap_sync_hook =3D alc269_fixup_hp_cap_mic_mute_hook;=0A=
+		spec->gpio_led =3D 0;=0A=
+		spec->cap_mute_led_nid =3D 0x18;=0A=
+		snd_hda_add_verbs(codec, gpio_init);=0A=
+	}=0A=
+}=0A=
+=0A=
+static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,=0A=
+				const struct hda_fixup *fix, int action)=0A=
+{=0A=
+	struct alc_spec *spec =3D codec->spec;=0A=
+=0A=
+	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {=0A=
+		spec->gen.vmaster_mute.hook =3D alc269_fixup_mic_mute_hook;=0A=
+		spec->gen.cap_sync_hook =3D alc269_fixup_hp_cap_mic_mute_hook;=0A=
+		spec->mute_led_polarity =3D 0;=0A=
+		spec->mute_led_nid =3D 0x1a;=0A=
+		spec->cap_mute_led_nid =3D 0x18;=0A=
+		spec->gen.vmaster_mute_enum =3D 1;=0A=
+		codec->power_filter =3D led_power_filter;=0A=
+	}=0A=
+}=0A=
+=0A=
 static void alc_headset_mode_unplugged(struct hda_codec *codec)=0A=
 {=0A=
 	int val;=0A=
@@ -4255,6 +4317,8 @@ enum {=0A=
 	ALC269_FIXUP_HP_MUTE_LED_MIC1,=0A=
 	ALC269_FIXUP_HP_MUTE_LED_MIC2,=0A=
 	ALC269_FIXUP_HP_GPIO_LED,=0A=
+	ALC269_FIXUP_HP_GPIO_MIC1_LED,=0A=
+	ALC269_FIXUP_HP_LINE1_MIC1_LED,=0A=
 	ALC269_FIXUP_INV_DMIC,=0A=
 	ALC269_FIXUP_LENOVO_DOCK,=0A=
 	ALC269_FIXUP_NO_SHUTUP,=0A=
@@ -4447,6 +4511,14 @@ static const struct hda_fixup alc269_fixups[] =3D =
{=0A=
 		.type =3D HDA_FIXUP_FUNC,=0A=
 		.v.func =3D alc269_fixup_hp_gpio_led,=0A=
 	},=0A=
+	[ALC269_FIXUP_HP_GPIO_MIC1_LED] =3D {=0A=
+		.type =3D HDA_FIXUP_FUNC,=0A=
+		.v.func =3D alc269_fixup_hp_gpio_mic1_led,=0A=
+	},=0A=
+	[ALC269_FIXUP_HP_LINE1_MIC1_LED] =3D {=0A=
+		.type =3D HDA_FIXUP_FUNC,=0A=
+		.v.func =3D alc269_fixup_hp_line1_mic1_led,=0A=
+	},=0A=
 	[ALC269_FIXUP_INV_DMIC] =3D {=0A=
 		.type =3D HDA_FIXUP_FUNC,=0A=
 		.v.func =3D alc_fixup_inv_dmic_0x12,=0A=
@@ -4790,6 +4862,20 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x2212, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2213, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2214, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2234, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2235, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2236, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2237, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2238, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2239, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2246, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2247, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2248, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2249, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x224a, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x224b, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x224c, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x224d, "HP", ALC269_FIXUP_HP_LINE1_MIC1_LED),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2266, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2267, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2268, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
@@ -4814,13 +4900,41 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x22ce, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22cf, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22d0, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22da, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22db, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22dc, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22fb, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x8004, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
 	/* ALC290 */=0A=
+	SND_PCI_QUIRK(0x103c, 0x221b, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2220, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2221, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2222, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2223, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2224, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2225, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2246, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2247, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2248, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2249, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2253, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2254, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2255, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2256, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2257, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2258, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2259, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x225a, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2260, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2261, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2262, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2263, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2264, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2265, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2272, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2273, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2277, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2278, "HP", ALC269_FIXUP_HP_GPIO_MIC1_LED),=0A=
 	SND_PCI_QUIRK(0x103c, 0x227d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x227e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x227f, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=

------=_NextPart_000_00EA_01CF8BDA.1FC63AD0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_00EA_01CF8BDA.1FC63AD0--
