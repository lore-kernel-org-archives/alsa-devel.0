From: Kailang <kailang@realtek.com>
Subject: Re: Set eapd to follow stream on or off
Date: Wed, 21 May 2014 14:28:12 +0800
Message-ID: <2BA29E879D5348299D5D82B47C851285@realtek.com.tw>
References: <3143A3763CC94AB9AAD48E43EA2B4DFC@realtek.com.tw><s5h8upw6gf6.wl%tiwai@suse.de><72897913D05F4C12BCED9FF890C77D61@realtek.com.tw><s5hha4kbz4q.wl%tiwai@suse.de><66A4EBB5FA74484E9FB040780F3C8965@realtek.com.tw><s5hd2f8bxns.wl%tiwai@suse.de><AC509D0AEA71499FB3503597855A4B0A@realtek.com.tw><s5h4n0kbw0e.wl%tiwai@suse.de><DA522F18DEB345498651505F8E1E9873@realtek.com.tw>
 <s5hwqdf4qd5.wl%tiwai@suse.de>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0052_01CF7500.E518EEE0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id C48A5261B28
 for <alsa-devel@alsa-project.org>; Wed, 21 May 2014 08:28:16 +0200 (CEST)
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

------=_NextPart_000_0052_01CF7500.E518EEE0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Attach is the update patch.
Many thanks.

BR,
Kailang


> At Wed, 21 May 2014 13:58:14 +0800,
> Kailang wrote:
>>
>>
>> > At Tue, 20 May 2014 18:05:42 +0800,
>> > Kailang wrote:
>> >>
>> >> > At Tue, 20 May 2014 17:20:44 +0800,
>> >> > Kailang wrote:
>> >> >>
>> >> >>
>> >> >> > At Tue, 20 May 2014 16:52:43 +0800,
>> >> >> > Kailang wrote:
>> >> >> >>
>> >> >> >>
>> >> >> >> > At Tue, 20 May 2014 15:15:49 +0800,
>> >> >> >> > Kailang wrote:
>> >> >> >> >>
>> >> >> >> >> Hi Takashi,
>> >> >> >> >>
>> >> >> >> >> HP machine had pop noise via speaker.
>> >> >> >> >> If EAPD on or off, speaker will have pop noise.
>> >> >> >> >> So, they want to set eapd to follow with stream on or off.
>> >> >> >> >
>> >> >> >> > I can apply this as is, but still I wonder whether this 
>> >> >> >> > results
>> >> >> >> > in
>> >> >> >> > other problems.  Doing EAPD on/off there means that it happens
>> >> >> >> > far
>> >> >> >> > more often.  For example, what happens if you do like below?
>> >> >> >> >
>> >> >> >> >     while true; do
>> >> >> >> >       echo -n > /dev/snd/pcmC0D0p
>> >> >> >> >     done
>> >> >> >> >
>> >> >> >> > And, what if the device is resumed from power-saving by an 
>> >> >> >> > audio
>> >> >> >> > playback?  Immediately after the power up, it'll start the
>> >> >> >> > streaming,
>> >> >> >> > so it'll turn on EAPD.
>> >> >> >> >
>> >> >> >> > That said, isn't it just a need for some delay before EAPD
>> >> >> >> > on/off?
>> >> >> >>
>> >> >> >> No, eapd on or off will cause pop noise.
>> >> >> >
>> >> >> > Does it do always?
>> >> >> No, pop noise just one pop sound. It can not remove by software.
>> >> >> But this machine need to do this always.
>> >> >
>> >> > So, doing EAPD on/off often is rather worse.  It's what your patch
>> >> > does.
>> >> >
>> >> > Once again: did you try the script above?  If the pop noise always
>> >>
>> >> I had try it on my develop machine. I have no HP issue machine on my
>> >> site.
>> >>
>> >> > happens, the operation like above is the worst scenario.
>> >> >
>> >> > Then, let's think again how to *reduce* it.  We need one EAPD on at
>> >> > least after each power up.  But it's needed only when you actually
>> >> > plays a stream.  That is, we need only enable EAPD at playback 
>> >> > stream
>> >> > open, but leave EAPD as is at close.
>> >> >
>> >>
>> >> [we need only enable EAPD at playback stream open, but leave EAPD as 
>> >> is
>> >> at
>> >> close.]
>> >> Yes.
>> >> So, I need to create eapd low in alc269_shutup. Right?
>> >
>> > Better to create own shutup callback (you can call alc269_shutup()
>> > from there, too) and set it to spec->shutup in the fixup.  The pincfg
>> > cleanup isn't often needed or may have bad effect.  You should test
>> > with real machines what are needed and what are not.
>>
>> static void alc290_fixup_pop_noise(struct hda_codec *codec,
>>            const struct hda_fixup *fix, int action)
>> {
>>  struct alc_spec *spec = codec->spec;
>>
>>  if (action == HDA_FIXUP_ACT_PRE_PROBE) {
>>   spec->gen.pcm_playback_hook = ALC290_playback_pcm_hook;
>>  }
>> if (action ==   HDA_FIXUP_ACT_INIT) {
>>   set_eapd(codec, 0x14, false);
>>  }
>> }
>>
>> Could I modify as upper code?
>> To set eapd low in HDA_FIXUP_ACT_INIT state.
>> If system resume, it will initial eapd to low.
>> To write eapd to same value, it will have no pop noise.
>> It will keep always low for eapd, only stream open and close have change
>> state for eapd.
>
> Yes, it looks OK.
>
>
> Takashi
>
>
>>
>> >
>> >
>> > Takashi
>> >
>> >>
>> >> >
>> >> > Takashi
>> >> >
>> >> >> >> Our customer just want to do eapd on when stream is open.
>> >> >> >> The pop noise will not clear. Because music gain was biger than 
>> >> >> >> pop
>> >> >> >> noise.
>> >> >> >
>> >> >> > Opening a stream doesn't mean that it follows the loud sound
>> >> >> > immediately.  The script above wouldn't produce any sound but 
>> >> >> > just
>> >> >> > does open/close the stream.  Did you try that?
>> >> >> >
>> >> >> >
>> >> >> > Takashi
>> >> >> >
>> >> >> > ------Please consider the environment before printing this 
>> >> >> > e-mail.
>> >> >>
>> >>
>> 

------=_NextPart_000_0052_01CF7500.E518EEE0
Content-Type: application/octet-stream;
	name="0001-set-eapd-follow-stream-on-off.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-set-eapd-follow-stream-on-off.patch"

>From 71a093ba3198666c4500b30938e080bd887647cb Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Wed, 21 May 2014 14:25:08 +0800=0A=
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
index 35acbd0..87973e2 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4175,6 +4175,39 @@ static void alc290_fixup_mono_speakers(struct =
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
+	switch (action) {=0A=
+	case HDA_FIXUP_ACT_PRE_PROBE:=0A=
+		spec->gen.pcm_playback_hook =3D ALC290_playback_pcm_hook;=0A=
+		break;=0A=
+	case HDA_FIXUP_ACT_INIT:=0A=
+		set_eapd(codec, 0x14, false);=0A=
+		break;=0A=
+	}=0A=
+}=0A=
+=0A=
 /* for hda_fixup_thinkpad_acpi() */=0A=
 #include "thinkpad_helper.c"=0A=
 =0A=
@@ -4237,6 +4270,7 @@ enum {=0A=
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,=0A=
 	ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,=0A=
 	ALC292_FIXUP_TPT440_DOCK,=0A=
+	ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED,=0A=
 };=0A=
 =0A=
 static const struct hda_fixup alc269_fixups[] =3D {=0A=
@@ -4650,6 +4684,12 @@ static const struct hda_fixup alc269_fixups[] =3D =
{=0A=
 		.chained =3D true,=0A=
 		.chain_id =3D ALC269_FIXUP_LIMIT_INT_MIC_BOOST=0A=
 	},=0A=
+	[ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED] =3D {=0A=
+		.type =3D HDA_FIXUP_FUNC,=0A=
+		.v.func =3D alc290_fixup_pop_noise,=0A=
+		.chained =3D true,=0A=
+		.chain_id =3D ALC269_FIXUP_HP_MUTE_LED_MIC1,=0A=
+	},=0A=
 };=0A=
 =0A=
 static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {=0A=
@@ -4772,12 +4812,14 @@ static const struct snd_pci_quirk =
alc269_fixup_tbl[] =3D {=0A=
 	SND_PCI_QUIRK(0x103c, 0x2280, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2281, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x2282, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
-	SND_PCI_QUIRK(0x103c, 0x2289, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x2289, "HP", =
ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228a, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228b, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
-	SND_PCI_QUIRK(0x103c, 0x228c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228c, "HP", =
ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228d, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x228e, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
+	SND_PCI_QUIRK(0x103c, 0x228f, "HP", =
ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),=0A=
+	SND_PCI_QUIRK(0x103c, 0x22a8, "HP", =
ALC290_FIXUP_HP_DEPOP_WITH_MUTE_LED),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c5, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c6, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=
 	SND_PCI_QUIRK(0x103c, 0x22c7, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),=0A=

------=_NextPart_000_0052_01CF7500.E518EEE0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0052_01CF7500.E518EEE0--
