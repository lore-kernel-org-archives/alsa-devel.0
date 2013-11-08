From: Kailang <kailang@realtek.com>
Subject: Re: [PATCH] ALSA: hda - Add multifunction jack support
	for ALC255
Date: Fri, 8 Nov 2013 16:19:22 +0800
Message-ID: <18BB75C648E74F1492FD24591C5C354F@realtek.com.tw>
References: <1383829721-3220-1-git-send-email-david.henningsson@canonical.com>
 <s5hob5wtkhs.wl%tiwai@suse.de> <527B9667.4010404@canonical.com>
 <C48D0657F2504A4FB2CE22E130F7A77A@realtek.com.tw>
 <527C7CBA.3020508@canonical.com>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0060_01CEDC9E.4917C0C0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 54ED82616FA
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 09:19:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 1248949@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_0060_01CEDC9E.4917C0C0
Content-Type: text/plain; format=flowed; charset="ISO-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi David,

I modified as attach patch.
It included coef_idx to use coefex_idx.

BR,
Kailang


> Hi Kailang,
>
> It does not matter. Choose what works best for you and I'll sort it out
> before sending to Takashi.
>
> // David
>
> On 11/08/2013 06:48 AM, Kailang wrote:
>> Hi David,
>>
>> Could I add commemts for belowing context?
>> Or I create new patch for it.
>>
>> BR,
>> Kailang
>>
>>> Hi,
>>>
>>> I can certainly rewrite coef_idx to use coefef_idx (I think that's a
>>> good idea), but for the comments, I know as little as you do about these
>>> verbs.
>>>
>>> Kailang, is it possible for you to add more comments to your patch so it
>>> can be applied upstream?
>>>
>>> Thanks,
>>>  David
>>>
>>> On 11/07/2013 02:22 PM, Takashi Iwai wrote:
>>>> At Thu,  7 Nov 2013 14:08:41 +0100,
>>>> David Henningsson wrote:
>>>>>
>>>>> From: Kailang Yang <kailang@realtek.com>
>>>>>
>>>>> The new codec ALC255 needs its own set of verbs to enable
>>>>> multifunction jacks.
>>>>>
>>>>> (Context and whitespace adjustments by David Henningsson)
>>>>>
>>>>> BugLink: https://bugs.launchpad.net/bugs/1248949
>>>>> Tested-by: Doro Wu <doro.wu@canonical.com>
>>>>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>>>>> ---
>>>>>  sound/pci/hda/patch_realtek.c |   91
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 91 insertions(+)
>>>>>
>>>>> diff --git a/sound/pci/hda/patch_realtek.c
>>>>> b/sound/pci/hda/patch_realtek.c
>>>>> index daf7205..ceadd65 100644
>>>>> --- a/sound/pci/hda/patch_realtek.c
>>>>> +++ b/sound/pci/hda/patch_realtek.c
>>>>> @@ -588,6 +588,18 @@ static int alc_read_coef_idx(struct hda_codec
>>>>> *codec,
>>>>>  return val;
>>>>>  }
>>>>>
>>>>> +static int alc_read_coefex_idx(struct hda_codec *codec,
>>>>> + hda_nid_t nid,
>>>>> + unsigned int coef_idx)
>>>>> +{
>>>>> + unsigned int val;
>>>>> + snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
>>>>> +     coef_idx);
>>>>> + val = snd_hda_codec_read(codec, nid, 0,
>>>>> + AC_VERB_GET_PROC_COEF, 0);
>>>>> + return val;
>>>>> +}
>>>>
>>>> Rewrite alc_read_coef_idx() using this new function, too, e.g.
>>>>
>>>> #define alc_write_coef_idx(codec, idx, val) \
>>>> alc_read_coefex_idx(codec, 0x20, idx, val)
>>>>
>>>>>  static void alc_write_coef_idx(struct hda_codec *codec, unsigned
>>>>> int coef_idx,
>>>>>  unsigned int coef_val)
>>>>>  {
>>>>> @@ -597,6 +609,15 @@ static void alc_write_coef_idx(struct hda_codec
>>>>> *codec, unsigned int coef_idx,
>>>>>      coef_val);
>>>>>  }
>>>>>
>>>>> +static void alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t
>>>>> nid,
>>>>> + unsigned int coef_idx, unsigned int coef_val)
>>>>> +{
>>>>> + snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,
>>>>> +     coef_idx);
>>>>> + snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PROC_COEF,
>>>>> +     coef_val);
>>>>> +}
>>>>
>>>> Ditto.
>>>>
>>>>> +
>>>>>  /* a special bypass for COEF 0; read the cached value at the second
>>>>> time */
>>>>>  static unsigned int alc_get_coef0(struct hda_codec *codec)
>>>>>  {
>>>>> @@ -3109,6 +3130,14 @@ static void alc_headset_mode_unplugged(struct
>>>>> hda_codec *codec)
>>>>>  int val;
>>>>>
>>>>>  switch (codec->vendor_id) {
>>>>> + case 0x10ec0255:
>>>>> + alc_write_coef_idx(codec, 0x1b, 0x0c0b);
>>>>> + alc_write_coef_idx(codec, 0x45, 0xd089);
>>>>> + val = alc_read_coefex_idx(codec, 0x57, 0x05);
>>>>> + alc_write_coefex_idx(codec, 0x57, 0x05, val & ~(1<<14));
>>>>> + alc_write_coef_idx(codec, 0x06, 0x6104);
>>>>> + alc_write_coefex_idx(codec, 0x57, 0x03, 0x8aa6);
>>>>
>>>> Try to comment what these actually do.  Not necessarily too detailed,
>>>> but we need to have some ideas.
>>>>
>>>> I regret to have merged the former Realtek headset patches that have
>>>> lots of such verbs without certain comments.
>>>>
>>>>
>>>> thanks,
>>>>
>>>> Takashi
>>>>
>>>
>>>
>>>
>>> -- 
>>> David Henningsson, Canonical Ltd.
>>> https://launchpad.net/~diwic
>>>
>>> ------Please consider the environment before printing this e-mail.
>>
>
>
>
> -- 
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic 

------=_NextPart_000_0060_01CEDC9E.4917C0C0
Content-Type: application/octet-stream; name="0002-alc255-uaj.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0002-alc255-uaj.patch"

>From 43e1947cdee4e63ed92cfff5e1d08dfa0b99eee4 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Fri, 8 Nov 2013 15:54:49 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add new codec ALC255/ALC3234 UAJ=0A=
 supported=0A=
=0A=
New codec ALC255/ALC3234 support multifunction jacks.=0A=
It used for menual select the input device.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 6a21466..4376c35 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -577,26 +577,35 @@ static void alc_ssid_check(struct hda_codec =
*codec, const hda_nid_t *ports)=0A=
 /*=0A=
  * COEF access helper functions=0A=
  */=0A=
-static int alc_read_coef_idx(struct hda_codec *codec,=0A=
-			unsigned int coef_idx)=0A=
+=0A=
+static int alc_read_coefex_idx(struct hda_codec *codec,=0A=
+					hda_nid_t nid,=0A=
+					unsigned int coef_idx)=0A=
 {=0A=
 	unsigned int val;=0A=
-	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_COEF_INDEX,=0A=
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,=0A=
 		    		coef_idx);=0A=
-	val =3D snd_hda_codec_read(codec, 0x20, 0,=0A=
+	val =3D snd_hda_codec_read(codec, nid, 0,=0A=
 			 	AC_VERB_GET_PROC_COEF, 0);=0A=
 	return val;=0A=
 }=0A=
 =0A=
-static void alc_write_coef_idx(struct hda_codec *codec, unsigned int =
coef_idx,=0A=
+#define alc_read_coef_idx(codec, coef_idx) \=0A=
+	alc_read_coefex_idx(codec, 0x20, coef_idx)=0A=
+=0A=
+static void alc_write_coefex_idx(struct hda_codec *codec, hda_nid_t nid,=0A=
+							unsigned int coef_idx,=0A=
 							unsigned int coef_val)=0A=
 {=0A=
-	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_COEF_INDEX,=0A=
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_COEF_INDEX,=0A=
 			    coef_idx);=0A=
-	snd_hda_codec_write(codec, 0x20, 0, AC_VERB_SET_PROC_COEF,=0A=
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_PROC_COEF,=0A=
 			    coef_val);=0A=
 }=0A=
 =0A=
+#define alc_write_coef_idx(codec, coef_idx, coef_val) \=0A=
+	alc_write_coefex_idx(codec, 0x20, coef_idx, coef_val)=0A=
+=0A=
 /* a special bypass for COEF 0; read the cached value at the second =
time */=0A=
 static unsigned int alc_get_coef0(struct hda_codec *codec)=0A=
 {=0A=
@@ -3109,6 +3118,19 @@ static void alc_headset_mode_unplugged(struct =
hda_codec *codec)=0A=
 	int val;=0A=
 =0A=
 	switch (codec->vendor_id) {=0A=
+	case 0x10ec0255:=0A=
+		/* LDO and MISC control */=0A=
+		alc_write_coef_idx(codec, 0x1b, 0x0c0b);=0A=
+		/* UAJ function set to menual mode */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xd089);=0A=
+		/* Direct Drive HP Amp control(Set to verb control)*/=0A=
+		val =3D alc_read_coefex_idx(codec, 0x57, 0x05);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x05, val & ~(1<<14));=0A=
+		/* Set MIC2 Vref gate with HP */=0A=
+		alc_write_coef_idx(codec, 0x06, 0x6104);=0A=
+		/* Direct Drive HP Amp control */=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8aa6);=0A=
+		break;=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c0b);=0A=
 		alc_write_coef_idx(codec, 0x45, 0xc429);=0A=
@@ -3140,6 +3162,14 @@ static void alc_headset_mode_mic_in(struct =
hda_codec *codec, hda_nid_t hp_pin,=0A=
 	int val;=0A=
 =0A=
 	switch (codec->vendor_id) {=0A=
+	case 0x10ec0255:=0A=
+		alc_write_coef_idx(codec, 0x45, 0xc489);=0A=
+		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8aa6);=0A=
+		/* Set MIC2 Vref gate to normal */=0A=
+		alc_write_coef_idx(codec, 0x06, 0x6100);=0A=
+		snd_hda_set_pin_ctl_cache(codec, mic_pin, PIN_VREF50);=0A=
+		break;=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xc429);=0A=
 		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);=0A=
@@ -3171,6 +3201,12 @@ static void alc_headset_mode_mic_in(struct =
hda_codec *codec, hda_nid_t hp_pin,=0A=
 static void alc_headset_mode_default(struct hda_codec *codec)=0A=
 {=0A=
 	switch (codec->vendor_id) {=0A=
+	case 0x10ec0255:=0A=
+		alc_write_coef_idx(codec, 0x45, 0xc089);=0A=
+		alc_write_coef_idx(codec, 0x45, 0xc489);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);=0A=
+		alc_write_coef_idx(codec, 0x49, 0x0049);=0A=
+		break;=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x06, 0x2100);=0A=
 		alc_write_coef_idx(codec, 0x32, 0x4ea3);=0A=
@@ -3194,6 +3230,12 @@ static void alc_headset_mode_default(struct =
hda_codec *codec)=0A=
 static void alc_headset_mode_ctia(struct hda_codec *codec)=0A=
 {=0A=
 	switch (codec->vendor_id) {=0A=
+	case 0x10ec0255:=0A=
+		/* Set to CTIA type */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xd489);=0A=
+		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);=0A=
+		break;=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xd429);=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
@@ -3216,6 +3258,12 @@ static void alc_headset_mode_ctia(struct =
hda_codec *codec)=0A=
 static void alc_headset_mode_omtp(struct hda_codec *codec)=0A=
 {=0A=
 	switch (codec->vendor_id) {=0A=
+	case 0x10ec0255:=0A=
+		/* Set to OMTP Type */=0A=
+		alc_write_coef_idx(codec, 0x45, 0xe489);=0A=
+		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
+		alc_write_coefex_idx(codec, 0x57, 0x03, 0x8ea6);=0A=
+		break;=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xe429);=0A=
 		alc_write_coef_idx(codec, 0x1b, 0x0c2b);=0A=
@@ -3241,6 +3289,15 @@ static void alc_determine_headset_type(struct =
hda_codec *codec)=0A=
 	struct alc_spec *spec =3D codec->spec;=0A=
 =0A=
 	switch (codec->vendor_id) {=0A=
+	case 0x10ec0255:=0A=
+		/* combo jack auto switch control(Check type)*/=0A=
+		alc_write_coef_idx(codec, 0x45, 0xd089);=0A=
+		/* combo jack auto switch control(Vref conteol) */=0A=
+		alc_write_coef_idx(codec, 0x49, 0x0149);=0A=
+		msleep(300);=0A=
+		val =3D alc_read_coef_idx(codec, 0x46);=0A=
+		is_ctia =3D (val & 0x0070) =3D=3D 0x0070;=0A=
+		break;=0A=
 	case 0x10ec0283:=0A=
 		alc_write_coef_idx(codec, 0x45, 0xd029);=0A=
 		msleep(300);=0A=
@@ -3387,6 +3444,21 @@ static void =
alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,=0A=
 		alc_fixup_headset_mode(codec, fix, action);=0A=
 }=0A=
 =0A=
+static void alc_fixup_headset_mode_alc255(struct hda_codec *codec,=0A=
+				const struct hda_fixup *fix, int action)=0A=
+{=0A=
+	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {=0A=
+		/* Set to iphone type */=0A=
+		alc_write_coef_idx(codec, 0x1b, 0x880b);=0A=
+		alc_write_coef_idx(codec, 0x45, 0xd089);=0A=
+		alc_write_coef_idx(codec, 0x1b, 0x080b);=0A=
+		alc_write_coef_idx(codec, 0x46, 0x0004);=0A=
+		alc_write_coef_idx(codec, 0x1b, 0x0c0b);=0A=
+		msleep(30);=0A=
+	}=0A=
+	alc_fixup_headset_mode(codec, fix, action);=0A=
+}=0A=
+=0A=
 static void alc_fixup_headset_mode_alc668(struct hda_codec *codec,=0A=
 				const struct hda_fixup *fix, int action)=0A=
 {=0A=
@@ -3688,6 +3760,8 @@ enum {=0A=
 	ALC283_FIXUP_INT_MIC,=0A=
 	ALC290_FIXUP_MONO_SPEAKERS,=0A=
 	ALC269_FIXUP_THINKPAD_ACPI,=0A=
+	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,=0A=
+	ALC255_FIXUP_HEADSET_MODE,=0A=
 };=0A=
 =0A=
 static const struct hda_fixup alc269_fixups[] =3D {=0A=
@@ -3997,6 +4071,20 @@ static const struct hda_fixup alc269_fixups[] =3D =
{=0A=
 		.chained =3D true,=0A=
 		.chain_id =3D ALC269_FIXUP_LIMIT_INT_MIC_BOOST=0A=
 	},=0A=
+	[ALC255_FIXUP_DELL1_MIC_NO_PRESENCE] =3D {=0A=
+		.type =3D HDA_FIXUP_PINS,=0A=
+		.v.pins =3D (const struct hda_pintbl[]) {=0A=
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack =
detect */=0A=
+			{ 0x1a, 0x01a1913d }, /* use as headphone mic, without its own jack =
detect */=0A=
+			{ }=0A=
+		},=0A=
+		.chained =3D true,=0A=
+		.chain_id =3D ALC255_FIXUP_HEADSET_MODE=0A=
+	},=0A=
+	[ALC255_FIXUP_HEADSET_MODE] =3D {=0A=
+		.type =3D HDA_FIXUP_FUNC,=0A=
+		.v.func =3D alc_fixup_headset_mode_alc255,=0A=
+	},=0A=
 };=0A=
 =0A=
 static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {=0A=
@@ -4039,6 +4127,8 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x1028, 0x0609, "Dell", =
ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x0613, "Dell", =
ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x0616, "Dell Vostro 5470", =
ALC290_FIXUP_MONO_SPEAKERS),=0A=
+	SND_PCI_QUIRK(0x1028, 0x061f, "Dell", =
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
+	SND_PCI_QUIRK(0x1028, 0x063f, "Dell", =
ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", =
ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", =
ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),=0A=
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),=0A=

------=_NextPart_000_0060_01CEDC9E.4917C0C0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0060_01CEDC9E.4917C0C0--
