From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Enable audio line out on ASUS D640SA
Date: Tue, 3 Apr 2018 16:43:02 +0800
Message-ID: <CAPpJ_eeYthiOiEMijRAvk05JR7cZLFpSiV8mVCHjxv_GL5Bjpg@mail.gmail.com>
References: <20180402073313.13247-1-jian-hong@endlessm.com> <s5hwoxp3kyz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwoxp3kyz.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>, linux@endlessm.com, Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2018-04-02 19:29 GMT+08:00 Takashi Iwai <tiwai@suse.de>:
>
> On Mon, 02 Apr 2018 09:33:13 +0200,
> Jian-Hong Pan wrote:
> >
> > This ASUS D640SA desktop whose mother board is D640MB has
> > - two jacks which are a headphone and a mic on the front panel,
> > - three jacks which are a mic, a line out and a line in on the rear pan=
el
> > - one internal speaker.
> >
> > If I plug a headphone to the front headphone jack, there will be sound
> > through the headphone jack, and no sound through the internal speaker.
> > If I unplug the headphone from the the headphone jack, there will be
> > sound through the internal speaker.  And always no sound through rear
> > line out, when I plug a headphone or an externel speaker to the rear
> > line out jack.
> >
> > Besides, I had checked and toggled the Auto-Mute Mode in alsamixer, but
> > the rear line out still was not working.  Then I checked the sound
> > settings in GUI, and found there was no "Line Out" could be chosen, onl=
y
> > the "Headphones" and "HDMI/DisplayPort".
> > However, system does know that there is an "Intel PCH Line Out".
> >
> > [   10.089082] snd_hda_codec_realtek hdaudioC0D0: autoconfig for
> > ALC887-VD: line_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
> > [   10.089083] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D1
> > (0x1a/0x0/0x0/0x0/0x0)
> > [   10.089084] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1
> > (0x1b/0x0/0x0/0x0/0x0)
> > [   10.089085] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0=
x0
> > [   10.089086] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> > [   10.089087] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x18
> > [   10.089088] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x19
> > [   10.089089] snd_hda_codec_realtek hdaudioC0D0:      Line=3D0x15
> > [   10.104387] input: HDA Intel PCH Rear Mic as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
> > [   10.104416] input: HDA Intel PCH Front Mic as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
> > [   10.104441] input: HDA Intel PCH Line as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
> > [   10.104467] input: HDA Intel PCH Line Out as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
> > [   10.104494] input: HDA Intel PCH Front Headphone as
> > /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
> >
> > Consequently, I checked the pin widgets' default configuration values:
> > - Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
> >     Pin Default 0x01014010: [Jack] Line Out at Ext Rear
> >
> > - Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
> >     Pin Default 0x02214030: [Jack] HP Out at Ext Front
> >
> > Because the headphone jack (Node ID:0x1b) locates on the desktop's fron=
t
> > panel, not rear panel, I change the headphone jack's configuration from
> > primary chassis to separate chassis.  So, the configuration value of
> > Node ID:0x1b should be 0x22214030.
>
> This is OK, but...
>
> > Additionally, I toggle the Auto-Mute Mode of Realtek codecs to =E2=80=
=9CSpeaker
> > Only=E2=80=9D which makes signal outputs through line out jack when the=
 "Line
> > Out" is chosen in the sound settings.
>
> ... this is a matter of taste, and I don't think it good to set a
> different default from others.  You can change it once and save it via
> alsactl.

The default state of Auto-Mute Mode of Realtek codec on this machine is
"Line Out + Speaker".
This disallows to output audio signal through the line out jack, even I alr=
eady
choose the "Line Out" as the audio output device in the sound settings.
It means there is no way to use the line out jack in "Line Out + Speaker" s=
tate
of Auto-Mute Mode on this machine.

To enhance the user experience, especially the new one who first uses Linux=
,
changing this machine's Auto-Mute Mode to "Speaker Only" state, which allow=
s
to output the audio signal through the line out jack, will be the better ch=
oice.

By the way, if the "Headphones" is chosen as the audio output device in the
sound settings, the audio signal will not output through the line out jack
automatically.

Therefore, I think this part of the quirk is still needed on this machine.

> And, the code to change this doesn't look good, either.  If any, it'd
> be easier to just set spec->gen.automute_speaker and
> spec->gen.automute_lo in the fixup with HDA_FIXUP_ACT_PROBE (that is
> performed after the parser call).

Oh!  This advice looks great and more directly!  I will try this.
Thanks for the suggestion.

Jian-Hong

> So, for now, I prefer having a change only touching the pinconfig.
> Care to resend the reduced one?
>
>
> thanks,
>
> Takashi
>
> >
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
> > index aef1f52db7d9..a066d84c6478 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -1810,6 +1810,8 @@ enum {
> >       ALC887_FIXUP_BASS_CHMAP,
> >       ALC1220_FIXUP_GB_DUAL_CODECS,
> >       ALC1220_FIXUP_CLEVO_P950,
> > +     ALC887_FIXUP_ASUS_AUTOMUTE_MODE,
> > +     ALC887_FIXUP_ASUS_FRONT_HP,
> >  };
> >
> >  static void alc889_fixup_coef(struct hda_codec *codec,
> > @@ -2044,6 +2046,24 @@ static void alc1220_fixup_clevo_p950(struct hda_=
codec *codec,
> >       snd_hda_override_conn_list(codec, 0x1b, 1, conn1);
> >  }
> >
> > +/* fix the default Auto-Mute Mode in mixer */
> > +static void alc887_fixup_asus_automute_mode(struct hda_codec *codec,
> > +                                         const struct hda_fixup *fix, =
int action)
> > +{
> > +     struct snd_kcontrol *kctl;
> > +     struct snd_ctl_elem_value *uctl;
> > +
> > +     kctl =3D snd_hda_find_mixer_ctl(codec, "Auto-Mute Mode");
> > +     if (!kctl)
> > +             return;
> > +     uctl =3D kzalloc(sizeof(*uctl), GFP_KERNEL);
> > +     if (!uctl)
> > +             return;
> > +     uctl->value.enumerated.item[0] =3D 1;
> > +     kctl->put(kctl, uctl);
> > +     kfree(uctl);
> > +}
> > +
> >  static const struct hda_fixup alc882_fixups[] =3D {
> >       [ALC882_FIXUP_ABIT_AW9D_MAX] =3D {
> >               .type =3D HDA_FIXUP_PINS,
> > @@ -2288,6 +2308,19 @@ static const struct hda_fixup alc882_fixups[] =
=3D {
> >               .type =3D HDA_FIXUP_FUNC,
> >               .v.func =3D alc1220_fixup_clevo_p950,
> >       },
> > +     [ALC887_FIXUP_ASUS_AUTOMUTE_MODE] =3D {
> > +             .type =3D HDA_FIXUP_FUNC,
> > +             .v.func =3D alc887_fixup_asus_automute_mode,
> > +     },
> > +     [ALC887_FIXUP_ASUS_FRONT_HP] =3D {
> > +             .type =3D HDA_FIXUP_PINS,
> > +             .v.pins =3D (const struct hda_pintbl[]) {
> > +                     {0x1b, 0x22214030},
> > +                     {}
> > +             },
> > +             .chained =3D true,
> > +             .chain_id =3D ALC887_FIXUP_ASUS_AUTOMUTE_MODE,
> > +     },
> >  };
> >
> >  static const struct snd_pci_quirk alc882_fixup_tbl[] =3D {
> > @@ -2321,6 +2354,7 @@ static const struct snd_pci_quirk alc882_fixup_tb=
l[] =3D {
> >       SND_PCI_QUIRK(0x1043, 0x13c2, "Asus A7M", ALC882_FIXUP_EAPD),
> >       SND_PCI_QUIRK(0x1043, 0x1873, "ASUS W90V", ALC882_FIXUP_ASUS_W90V=
),
> >       SND_PCI_QUIRK(0x1043, 0x1971, "Asus W2JC", ALC882_FIXUP_ASUS_W2JC=
),
> > +     SND_PCI_QUIRK(0x1043, 0x2160, "ASUSPRO D640MB", ALC887_FIXUP_ASUS=
_FRONT_HP),
> >       SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE16=
01),
> >       SND_PCI_QUIRK(0x1043, 0x84bc, "ASUS ET2700", ALC887_FIXUP_ASUS_BA=
SS),
> >       SND_PCI_QUIRK(0x1043, 0x8691, "ASUS ROG Ranger VIII", ALC882_FIXU=
P_GPIO3),
> > --
> > 2.11.0
> >
> >
