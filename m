From: "joey.jiaojg" <joey.jiaojg@gmail.com>
Subject: Re: Bug report - patch_realtek.c - Laptop HP COMPAQ
 B1900 Series
Date: Wed, 15 Feb 2012 17:31:44 +0800
Message-ID: <4F3B7B80.5030102@gmail.com>
References: <4F35C191.9080401@gmail.com>
	<20120211020502.GA25041@marvin.atrad.com.au>
	<CAN8cciZejU6suH_pF5OzpVgjjUYsYgTCf14T5J=0G-c0wSfyAA@mail.gmail.com>
	<CAKOmCvoS+tgvyPZJey4gfFFq=Uz01pnZY7YvGbxgQPpAzQ7KCA@mail.gmail.com>
	<CAKOmCvofbM9+5SGSMkAP=ansfxCz835LF3GfM6=OF3zn-+10iw@mail.gmail.com>
	<CAN8cciY2M+9h-3BROUV03VuNL5WLJsxG-Tx1+MG5=+kxrZqaoQ@mail.gmail.com>
	<4F3B761D.4060306@gmail.com> <s5h8vk4wivv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070204030905000302070303"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 602EF24474
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 10:31:56 +0100 (CET)
Received: by iabz21 with SMTP id z21so1275042iab.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 01:31:54 -0800 (PST)
In-Reply-To: <s5h8vk4wivv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, pshou@realtek.com.tw, ALSA Development Mailing List <alsa-devel@alsa-project.org>, kailang@realtek.com.tw
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070204030905000302070303
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Here is the diff file.

On 2012=E5=B9=B402=E6=9C=8815=E6=97=A5 17:22, Takashi Iwai wrote:
> At Wed, 15 Feb 2012 17:08:45 +0800,
> joey.jiaojg wrote:
>> Well, now I have fully fixed the speaker/headphone issue for HP COMPAQ
>> B1900 by adding a new model=3Db1900 into patch_realtek.c which also ca=
n
>> automute by detect HP state.
> That's great.
>
>> As I cannot compile alsa-driver-1.0.25 on my ubuntu 11.10, so I modifi=
ed
>> based on kernel-3.0.13 (alsa version 1.0.24) from ubuntu src.
>> Attached with stocked source and my updated one, please consider addin=
g
>> into next alsa-driver.
> Could you simply give a patch file (with "diff -up")?
> Then I can check your changes more easily.
>
>
> thanks,
>
> Takashi


--------------070204030905000302070303
Content-Type: text/x-csrc;
 name="patch_realtek_diff.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch_realtek_diff.c"

--- patch_realtek.c.bk	2012-02-15 17:29:44.851620661 +0800
+++ patch_realtek.c	2012-02-15 17:29:40.887601285 +0800
@@ -80,6 +80,7 @@ enum {
 	ALC260_WILL,
 	ALC260_REPLACER_672V,
 	ALC260_FAVORIT100,
+	ALC260_B1900,
 #ifdef CONFIG_SND_DEBUG
 	ALC260_TEST,
 #endif
@@ -1323,6 +1324,34 @@ static void alc_inithook(struct hda_code
 	alc_mic_automute(codec);
 }
 
+/* toggle speaker-output according to the hp-jack state */
+static void alc260_b1900_automute(struct hda_codec *codec)
+{
+        unsigned int present;
+
+	present = snd_hda_jack_detect(codec, 0x0f);
+	if (present) {
+		snd_hda_codec_write_cache(codec, 0x01, 0,
+					  AC_VERB_SET_GPIO_MASK, 0);
+		snd_hda_codec_write_cache(codec, 0x01, 0,
+					  AC_VERB_SET_GPIO_DIRECTION,
+					  0);
+		snd_hda_codec_write_cache(codec, 0x0f, 0,
+					  AC_VERB_SET_PIN_WIDGET_CONTROL,
+					  PIN_HP);
+	} else {
+		snd_hda_codec_write_cache(codec, 0x01, 0,
+					  AC_VERB_SET_GPIO_MASK, 1);
+		snd_hda_codec_write_cache(codec, 0x01, 0,
+					  AC_VERB_SET_GPIO_DIRECTION,
+					  1);
+		snd_hda_codec_write_cache(codec, 0x0f, 0,
+					  AC_VERB_SET_PIN_WIDGET_CONTROL,
+					  PIN_OUT);
+	}
+}
+
+
 /* additional initialization for ALC888 variants */
 static void alc888_coef_init(struct hda_codec *codec)
 {
@@ -6899,6 +6928,18 @@ static const struct hda_verb alc260_will
 	{}
 };
 
+static const struct hda_verb alc260_b1900_verbs[] = {
+	{0x0f, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
+	{0x0b, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{0x0f, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	{0x1a, AC_VERB_SET_COEF_INDEX, 0x07},
+	{0x1a, AC_VERB_SET_PROC_COEF, 0x3040},
+	{0x0f, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_HP_EVENT},
+	{}
+};
+
+
 static const struct hda_verb alc260_replacer_672v_verbs[] = {
 	{0x0f, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
 	{0x1a, AC_VERB_SET_COEF_INDEX, 0x07},
@@ -6941,6 +6982,12 @@ static void alc260_replacer_672v_unsol_e
                 alc260_replacer_672v_automute(codec);
 }
 
+static void alc260_b1900_unsol_event(struct hda_codec *codec,
+                                       unsigned int res)
+{
+        if ((res >> 26) == ALC880_HP_EVENT)
+                alc260_b1900_automute(codec);
+}
 static const struct hda_verb alc260_hp_dc7600_verbs[] = {
 	{0x05, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x01},
@@ -7431,6 +7478,7 @@ static const char * const alc260_models[
 	[ALC260_WILL]		= "will",
 	[ALC260_REPLACER_672V]	= "replacer",
 	[ALC260_FAVORIT100]	= "favorit100",
+	[ALC260_B1900]  	= "b1900",
 #ifdef CONFIG_SND_DEBUG
 	[ALC260_TEST]		= "test",
 #endif
@@ -7458,6 +7506,7 @@ static const struct snd_pci_quirk alc260
 	SND_PCI_QUIRK(0x152d, 0x0729, "CTL U553W", ALC260_BASIC),
 	SND_PCI_QUIRK(0x161f, 0x2057, "Replacer 672V", ALC260_REPLACER_672V),
 	SND_PCI_QUIRK(0x1631, 0xc017, "PB V7900", ALC260_WILL),
+	SND_PCI_QUIRK(0x103c, 0x007f, "HP COMPAQ", ALC260_B1900),
 	{}
 };
 
@@ -7570,6 +7619,20 @@ static const struct alc_config_preset al
 		.channel_mode = alc260_modes,
 		.input_mux = &alc260_capture_source,
 	},
+	[ALC260_B1900] = {
+		.mixers = { alc260_will_mixer },
+		.init_verbs = { alc260_init_verbs, alc260_b1900_verbs },
+		.num_dacs = ARRAY_SIZE(alc260_dac_nids),
+		.dac_nids = alc260_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc260_adc_nids),
+		.adc_nids = alc260_adc_nids,
+		.dig_out_nid = ALC260_DIGOUT_NID,
+		.num_channel_mode = ARRAY_SIZE(alc260_modes),
+		.channel_mode = alc260_modes,
+		.input_mux = &alc260_capture_source,
+		.unsol_event = alc260_b1900_unsol_event,
+		.init_hook = alc260_b1900_automute,
+	},
 	[ALC260_REPLACER_672V] = {
 		.mixers = { alc260_replacer_672v_mixer },
 		.init_verbs = { alc260_init_verbs, alc260_replacer_672v_verbs },

--------------070204030905000302070303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070204030905000302070303--
