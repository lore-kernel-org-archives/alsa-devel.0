From: Kailang <kailang@realtek.com>
Subject: Set eapd to follow stream on or off
Date: Tue, 20 May 2014 15:15:49 +0800
Message-ID: <3143A3763CC94AB9AAD48E43EA2B4DFC@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0088_01CF743E.61F19390"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C234261A1D
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 09:15:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_0088_01CF743E.61F19390
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

HP machine had pop noise via speaker.
If EAPD on or off, speaker will have pop noise.
So, they want to set eapd to follow with stream on or off.

Many Thanks.

BR,
Kailang
------=_NextPart_000_0088_01CF743E.61F19390
Content-Type: application/octet-stream;
	name="0000-set-eapd-follow-stream-on-off.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-set-eapd-follow-stream-on-off.patch"

>From 8af68c6454203361cce2128df2144afe88e5842a Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Tue, 20 May 2014 15:00:19 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Set EAPD to follow stream on or off=0A=
=0A=
HP machine has pop noise via speaker.=0A=
Set EAPD on when system open stream.=0A=
Set EAPD off when system close stream.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 35acbd0..67dd06c 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4175,6 +4175,37 @@ static void alc290_fixup_mono_speakers(struct =
hda_codec *codec,=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * ALC290 PCM hooks=0A=
+ */=0A=
+static void ALC290_playback_pcm_hook(struct hda_pcm_stream *hinfo,=0A=
+				   struct hda_codec *codec,=0A=
+				   struct snd_pcm_substream *substream,=0A=
+				   int action)=0A=
+{=0A=
+	struct sigmatel_spec *spec =3D codec->spec;=0A=
+=0A=
+	switch (action) {=0A=
+	case HDA_GEN_PCM_ACT_OPEN:=0A=
+		set_eapd(codec, 0x14, true);=0A=
+		break;=0A=
+	case HDA_GEN_PCM_ACT_CLOSE:=0A=
+		set_eapd(codec, 0x14, false);=0A=
+		break;=0A=
+	}=0A=
+}=0A=
+=0A=
+static void alc290_fixup_pop_noise(struct hda_codec *codec,=0A=
+				       const struct hda_fixup *fix, int action)=0A=
+{=0A=
+	struct alc_spec *spec =3D codec->spec;=0A=
+=0A=
+	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE) {=0A=
+		set_eapd(codec, 0x14, false);=0A=
+		spec->gen.pcm_playback_hook =3D ALC290_playback_pcm_hook;=0A=
+	}=0A=
+}=0A=
+=0A=
 /* for hda_fixup_thinkpad_acpi() */=0A=
 #include "thinkpad_helper.c"=0A=
 =0A=
@@ -4237,6 +4268,7 @@ enum {=0A=
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,=0A=
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,=0A=
 	ALC292_FIXUP_TPT440_DOCK,=0A=
+	ALC290_FIXUP_HP_DEPOP,=0A=
 };=0A=
 =0A=
 static const struct hda_fixup alc269_fixups[] =3D {=0A=
@@ -4650,6 +4682,12 @@ static const struct hda_fixup alc269_fixups[] =3D =
{=0A=
 		.chained =3D true,=0A=
 		.chain_id =3D ALC269_FIXUP_LIMIT_INT_MIC_BOOST=0A=
 	},=0A=
+	[ALC290_FIXUP_HP_DEPOP] =3D {=0A=
+		.type =3D HDA_FIXUP_FUNC,=0A=
+		.v.func =3D alc290_fixup_pop_noise,=0A=
+		.chained =3D true,=0A=
+		.chain_id =3D ALC269_FIXUP_HP_MUTE_LED_MIC1,=0A=
+	},=0A=
 };=0A=
 =0A=
 static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {=0A=
@@ -4772,12 +4810,14 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x2280, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2281, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2282, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
-	SND_PCI_QUIRK(0x103c, 0x2289, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2289, "HP", ALC290_FIXUP_HP_DEPOP),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
-	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC290_FIXUP_HP_DEPOP),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228f, "HP", ALC290_FIXUP_HP_DEPOP),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22a8, "HP", ALC290_FIXUP_HP_DEPOP),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c5, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c6, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=

------=_NextPart_000_0088_01CF743E.61F19390
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0088_01CF743E.61F19390--
