From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 13/31] HDA patch_via.c: Refresh front
	playback mute if hp plug-in mutes speaker.
Date: Tue, 6 Oct 2009 13:10:54 +0800
Message-ID: <16685ee0910052210w41bd590fy6cfd75d38580f0bf@mail.gmail.com>
References: <16685ee0910050727k72411ca7kd80cbb8eb6771f6e@mail.gmail.com>
	<s5h8wfp6fq9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id B6B1A2447C
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 07:10:54 +0200 (CEST)
Received: by fxm8 with SMTP id 8so3311551fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 22:10:54 -0700 (PDT)
In-Reply-To: <s5h8wfp6fq9.wl%tiwai@suse.de>
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
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 5, 2009 at 11:08 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 5 Oct 2009 22:27:16 +0800,
> Li Bo wrote:
>>
>> [ALSA] HDA VIA: Refresh front playback mute if hp plug-in mutes speaker.
>>
>> Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
>>
>> Index: sound-2.6/sound/pci/hda/patch_via.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- sound-2.6.orig/sound/pci/hda/patch_via.c =A02009-10-05 15:10:13.0000=
00000 +0800
>> +++ sound-2.6/sound/pci/hda/patch_via.c =A0 =A0 =A0 2009-10-05 15:10:22.=
000000000 +0800
>> @@ -1346,14 +1346,26 @@
>> =A0/* mute internal speaker if HP is plugged */
>> =A0static void via_hp_automute(struct hda_codec *codec)
>> =A0{
>> - =A0 =A0 unsigned int present;
>> + =A0 =A0 unsigned int present =3D 0;
>> =A0 =A0 =A0 struct via_spec *spec =3D codec->spec;
>> + =A0 =A0 char name[32] =3D "Front Playback Switch";
>
> Use a constant string, at least a form like: const char *name =3D "...";
> But...
OK


>
>>
>> =A0 =A0 =A0 present =3D snd_hda_codec_read(codec, spec->autocfg.hp_pins[=
0], 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0A=
C_VERB_GET_PIN_SENSE, 0) & 0x80000000;
>> - =A0 =A0 snd_hda_codec_amp_stereo(codec, spec->autocfg.line_out_pins[0],
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HDA_OUTPUT,=
 0, HDA_AMP_MUTE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0present ? H=
DA_AMP_MUTE : 0);
>> +
>> + =A0 =A0 if (!spec->hp_independent_mode) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct snd_card *card =3D codec->bus->card;
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct snd_kcontrol *kctl;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* auto mute */
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_amp_stereo(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec, spec->autocfg.line_out_=
pins[0], HDA_OUTPUT, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HDA_AMP_MUTE, present ? HDA_AM=
P_MUTE : 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* notify change */
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(kctl, &card->controls, lis=
t)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(kctl->id.name, name=
) =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_ctl_notify=
(card, SNDRV_CTL_EVENT_MASK_VALUE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0&kctl->id);
>
> Don't search for a kctl here.
> Just set up kctl->id, and let snd_ctl_notify() to search for the
> element.
I tried to setup kctl->id, but found that to setup it properly, we
also need search.
Maybe we have to search here?


>
>
> Takashi
>
