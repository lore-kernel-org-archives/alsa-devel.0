From: Jian-Hong Pan <jian-hong@endlessm.com>
Subject: Re: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS
 UX533FD with ALC294
Date: Fri, 7 Dec 2018 11:48:08 +0800
Message-ID: <CAPpJ_ed36NyopArw98qhkstAm=L9A4=xiLPaa2ju0+qMR0tE9Q@mail.gmail.com>
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com> <20181206084554.4728-3-jian-hong@endlessm.com>
 <6FAB7C47BCF00940BB0999A99BE3547A18420211@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A18420211@RTITMBSV02.realtek.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: Kailang Yang <kailang@realtek.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Kailang <kailang@realtek.com> =E6=96=BC 2018=E5=B9=B412=E6=9C=887=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=8811:32=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Jian Hong,
>
> Could I know who give you the value as below?
>
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
> +                       { 0x20, 0x4c4, 0x20 },
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
> +                       { 0x20, 0x488, 0x00 },

A module maker.

Regards,
Jian-Hong Pan

> -----Original Message-----
> From: Jian-Hong Pan <jian-hong@endlessm.com>
> Sent: Thursday, December 6, 2018 4:46 PM
> To: Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Kail=
ang <kailang@realtek.com>
> Cc: Hui Wang <hui.wang@canonical.com>; alsa-devel@alsa-project.org; linux=
-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan <jian-hong@endle=
ssm.com>; Daniel Drake <drake@endlessm.com>
> Subject: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX5=
33FD with ALC294
>
> The ASUS UX533FD with ALC294 cannot detect the headset MIC and output thr=
ough the internal speaker and the headphone until ALC294_FIXUP_ASUS_SPK_NOI=
SE quirk applied.
>
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
> v2:
> - Modify the HDA verbs for UX333FA support
> - Make a new ALC294_FIXUP_ASUS_HEADSET_MIC quirk for ALC294 chain
> - .chain_id =3D ALC256_FIXUP_ASUS_HEADSET_MODE  =3D=3D> change to ALC269_=
FIXUP_HEADSET_MODE_NO_HP_MIC
>
>  sound/pci/hda/patch_realtek.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.=
c index d32e50b1ed60..1525bcdf96e8 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5518,6 +5518,8 @@ enum {
>         ALC295_FIXUP_HP_AUTO_MUTE,
>         ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
>         ALC294_FIXUP_ASUS_MIC,
> +       ALC294_FIXUP_ASUS_HEADSET_MIC,
> +       ALC294_FIXUP_ASUS_SPK_NOISE,
>  };
>
>  static const struct hda_fixup alc269_fixups[] =3D { @@ -6414,6 +6416,28 =
@@ static const struct hda_fixup alc269_fixups[] =3D {
>                 .chained =3D true,
>                 .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
>         },
> +       [ALC294_FIXUP_ASUS_HEADSET_MIC] =3D {
> +               .type =3D HDA_FIXUP_PINS,
> +               .v.pins =3D (const struct hda_pintbl[]) {
> +                       { 0x19, 0x01a1113c }, /* use as headset mic, with=
out its own jack detect */
> +                       { }
> +               },
> +               .chained =3D true,
> +               .chain_id =3D ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
> +       },
> +       [ALC294_FIXUP_ASUS_SPK_NOISE] =3D {
> +               .type =3D HDA_FIXUP_VERBS,
> +               .v.verbs =3D (const struct hda_verb[]) {
> +                       /* Set EAPD high */
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
> +                       { 0x20, 0x4c4, 0x20 },
> +                       { 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
> +                       { 0x20, 0x488, 0x00 },
> +                       { }
> +               },
> +               .chained =3D true,
> +               .chain_id =3D ALC294_FIXUP_ASUS_HEADSET_MIC
> +       },
>  };
>
>  static const struct snd_pci_quirk alc269_fixup_tbl[] =3D { @@ -6556,6 +6=
580,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =3D {
>         SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MI=
C),
>         SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MI=
C),
>         SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXU=
P_ASUS_ZENBOOK),
> +       SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD",
> +ALC294_FIXUP_ASUS_SPK_NOISE),
>         SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXU=
P_ASUS_ZENBOOK_UX31A),
>         SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DM=
IC),
>         SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73=
JW),
> --
> 2.11.0
>
