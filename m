From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
Date: Wed, 20 Mar 2019 13:05:33 +0800
Message-ID: <CAPpJ_ec7oWi+ymtHXVwBMWS7=WtGmtPX6GNd+VOKX9xFzGZEVA@mail.gmail.com>
References: <20190315095108.9195-1-jian-hong@endlessm.com> <s5himwkpehk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5himwkpehk.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org, Linux Upstreaming Team <linux@endlessm.com>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> =E6=96=BC 2019=E5=B9=B43=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=887:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 15 Mar 2019 10:51:09 +0100,
> Jian-Hong Pan wrote:
> >
> > Some Acer AIO desktops like Veriton Z6860G, Z4860G and Z4660G cannot
> > record sound from headset MIC.  This patch adds the
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC quirk to fix this issue.
> >
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > ---
> > v2: According to Realtek's suggestion, change the COEF 0x4f from 0xd429=
 to
> >     0x5029.  Thanks to Realtek!
>
> It'd be nicer if we get either Acked-by or Reviewed-by tag from
> Realtek.  Kailang?

Hi Kailang,

May we have your Acked-by or Reviewed-by tag for this patch?
Signed-off will also be great!

Thank you
Jian-Hong Pan

> thanks,
>
> Takashi
>
> >
> >  sound/pci/hda/patch_realtek.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realte=
k.c
> > index 384719d5c44e..191830d4fa40 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -5687,6 +5687,7 @@ enum {
> >       ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE,
> >       ALC225_FIXUP_WYSE_AUTO_MUTE,
> >       ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
> > +     ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
> >  };
> >
> >  static const struct hda_fixup alc269_fixups[] =3D {
> > @@ -6685,6 +6686,16 @@ static const struct hda_fixup alc269_fixups[] =
=3D {
> >               .chained =3D true,
> >               .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> >       },
> > +     [ALC286_FIXUP_ACER_AIO_HEADSET_MIC] =3D {
> > +             .type =3D HDA_FIXUP_VERBS,
> > +             .v.verbs =3D (const struct hda_verb[]) {
> > +                     { 0x20, AC_VERB_SET_COEF_INDEX, 0x4f },
> > +                     { 0x20, AC_VERB_SET_PROC_COEF, 0x5029 },
> > +                     { }
> > +             },
> > +             .chained =3D true,
> > +             .chain_id =3D ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
> > +     },
> >  };
> >
> >  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
> > @@ -6701,9 +6712,9 @@ static const struct snd_pci_quirk alc269_fixup_tb=
l[] =3D {
> >       SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP=
_ASPIRE_V5_PINS),
> >       SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> >       SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_C=
HROME_BOOK),
> > -     SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> > -     SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> > -     SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP=
_ACER_AIO_MIC_NO_PRESENCE),
> > +     SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
> > +     SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
> > +     SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP=
_ACER_AIO_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_=
FIXUP_ACER_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M10=
1Z),
> >       SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_D=
ELL_XPS),
> > --
> > 2.20.1
> >
> >
