From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Mon, 04 May 2015 01:53:37 +0200
Message-ID: <5546B501.7050207@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
 <553E7B34.2080501@gmx.com> <s5h4mo14d72.wl-tiwai@suse.de>
 <553EB55D.4060701@gmx.com> <s5hlhhc3hiy.wl-tiwai@suse.de>
 <55400DF4.2080309@gmx.com> <s5hpp6nf41g.wl-tiwai@suse.de>
 <5540FBFF.6020904@gmx.com> <s5h8uda93pf.wl-tiwai@suse.de>
 <55416BEE.5090003@gmx.com> <s5hvbge6u4x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020804050307070305000907"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1244A260573
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 01:53:31 +0200 (CEST)
Received: from [192.168.69.6] ([95.252.9.144]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mhdex-1Ybdg920tH-00MuMz for
 <alsa-devel@alsa-project.org>; Mon, 04 May 2015 01:53:30 +0200
In-Reply-To: <s5hvbge6u4x.wl-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020804050307070305000907
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 30/04/2015 07:51, Takashi Iwai wrote:
> At Thu, 30 Apr 2015 01:40:30 +0200,
> Gabriele Martino wrote:
>> hdajacksensetest -c 1 -a
>> Pin 0x0b (Internal Speaker): present =3D Yes
>> Pin 0x0c (Not connected): present =3D No
>> Pin 0x0d (Not connected): present =3D No
>> Pin 0x0e (Not connected): present =3D No
>> Pin 0x0f (Not connected): present =3D Yes
>> Pin 0x10 (Not connected): present =3D No
>> Pin 0x11 (Black Line In, Left side): present =3D No
>> Pin 0x12 (Internal Mic, Mobile-In): present =3D No
>> Pin 0x13 (Not connected): present =3D No
>> Pin 0x18 (Not connected): present =3D No
>>
>> Pin 0x0f is still reported as not connected, but correctly detects the=

>> jack if plugged.
>> If I turn off and on the "HP/Speaker Auto Detect" in alsamixer while
>> "HP/Speaker" is off, the correct output is detected.
>> If "HP/Speaker" is on, the behaviour is inconsistent.
>>
>> Is there a configuration file? Where can I find the metadata "Black Li=
ne
>> In, Left side"?
>> I don't know if it is related, but pavucontrol detects only the
>> "speakers" port.
>> On my previous laptop (with Creative Recon 3Di, another ca0132 card) I=

>> could choose between "speakers and "headphones".
> It implies that the whole pin config BIOS provides is buggy.   The
> jack color, location, etc, all are parsed from 32bit pin configuration
> value for each pin.
>
> You need to correct the pin config and sets it statically in the
> driver.  hdajackretask can give you the map and reload it
> dynamically.
>
Finally got it.
I'm not sure about overriding the BIOS configuration: there is a new
version which fixes all the unconnected pins.
There is only a small issue: the internal speakers are now marked as
"Line out", which seems to mess up the "Ports" section in Pulseaudio.

Regards,
Gabriele

--------------020804050307070305000907
Content-Type: text/x-patch;
 name="ca0132-quirks.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ca0132-quirks.patch"

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4a4e7b2..04720ae 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -43,7 +43,7 @@
 #define FLOAT_TWO	0x40000000
 #define FLOAT_MINUS_5	0xc0a00000
=20
-#define UNSOL_TAG_HP	0x10
+hda_nid_t UNSOL_TAG_HP =3D 0x10;
 #define UNSOL_TAG_AMIC1	0x12
 #define UNSOL_TAG_DSP	0x16
=20
@@ -748,6 +748,7 @@ struct ca0132_spec {
=20
 	struct hda_codec *codec;
 	struct delayed_work unsol_hp_work;
+	int quirk;
=20
 #ifdef ENABLE_TUNING_CONTROLS
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
@@ -755,6 +756,19 @@ struct ca0132_spec {
 };
=20
 /*
+ * CA0132 quirks table
+ */
+enum {
+	QUIRK_NONE,
+	QUIRK_ALIENWARE,
+};
+
+static const struct snd_pci_quirk ca0132_quirks[] =3D {
+	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", QUIRK_ALIENWARE),
+	{}
+};
+
+/*
  * CA0132 codec access
  */
 static unsigned int codec_send_command(struct hda_codec *codec, hda_nid_=
t nid,
@@ -4479,8 +4493,19 @@ static struct hda_verb ca0132_init_verbs0[] =3D {
 	{}
 };
=20
-static struct hda_verb ca0132_init_verbs1[] =3D {
-	{0x10, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_HP},
+static struct hda_verb ca0132_init_verbs1_default[] =3D {
+	{0x10, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | 0x10}, /* UNSOL_TA=
G_HP is 0x10 */
+	{0x12, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_AMIC1},
+	/* config EAPD */
+	{0x0b, 0x78D, 0x00},
+	/*{0x0b, AC_VERB_SET_EAPD_BTLENABLE, 0x02},*/
+	/*{0x10, 0x78D, 0x02},*/
+	/*{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x02},*/
+	{}
+};
+
+static struct hda_verb ca0132_init_verbs1_alienware[] =3D {
+	{0x0f, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | 0x0f}, /* UNSOL_TA=
G_HP is 0x0f */
 	{0x12, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_AMIC1},
 	/* config EAPD */
 	{0x0b, 0x78D, 0x00},
@@ -4617,7 +4642,13 @@ static void ca0132_config(struct hda_codec *codec)=

=20
 	spec->num_outputs =3D 2;
 	spec->out_pins[0] =3D 0x0b; /* speaker out */
-	spec->out_pins[1] =3D 0x10; /* headphone out */
+	if (spec->quirk =3D=3D QUIRK_ALIENWARE) {
+		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE applied.\n");
+		spec->out_pins[1] =3D 0x0f;
+	}
+	else{
+		spec->out_pins[1] =3D 0x10; /* headphone out */
+	}
 	spec->shared_out_nid =3D 0x2;
=20
 	spec->num_inputs =3D 3;
@@ -4645,6 +4676,8 @@ static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
 	int err;
+	const struct snd_pci_quirk *quirk;
+	struct hda_verb *ca0132_init_verbs1;
=20
 	codec_dbg(codec, "patch_ca0132\n");
=20
@@ -4654,6 +4687,24 @@ static int patch_ca0132(struct hda_codec *codec)
 	codec->spec =3D spec;
 	spec->codec =3D codec;
=20
+	quirk =3D snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
+	if (quirk) {
+		spec->quirk =3D quirk->value;
+	}
+	else{
+		spec->quirk =3D QUIRK_NONE;
+	}
+
+	/* Apply detected quirks */
+	if (spec->quirk =3D=3D QUIRK_ALIENWARE) {
+		codec_dbg(codec, "patch_ca0132: QUIRK_ALIENWARE applied.\n");
+		UNSOL_TAG_HP =3D 0x0f;
+		ca0132_init_verbs1 =3D ca0132_init_verbs1_alienware;
+	}
+	else{
+		ca0132_init_verbs1 =3D ca0132_init_verbs1_default;
+	}
+
 	spec->dsp_state =3D DSP_DOWNLOAD_INIT;
 	spec->num_mixers =3D 1;
 	spec->mixers[0] =3D ca0132_mixer;

--------------020804050307070305000907
Content-Type: text/plain; charset=UTF-8;
 name="hda-jack-retask.fw"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="hda-jack-retask.fw"

[codec]
0x11020011 0x10280685 0

[pincfg]
0x0b 0x90174010
0x0c 0x014580f0
0x0d 0x014570f0
0x0e 0x01c530f0
0x0f 0x0221401f
0x10 0x02216011
0x11 0x02012014
0x12 0x37a791f0
0x13 0x908700f0
0x18 0x500000f0

--------------020804050307070305000907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020804050307070305000907--
