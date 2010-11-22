From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Re: [PATCH] Enable jack sense for Thinkpad Edge 11
Date: Mon, 22 Nov 2010 08:58:25 -0600
Message-ID: <AANLkTi=esSJJreo-avXjM4_OafqbjV=s7Lnudzrc_30i@mail.gmail.com>
References: <AANLkTin2zKWLLxsRn+T+U+NpAmbQiOTM_vrg_Z-8JZd-@mail.gmail.com>
	<AANLkTinWMv0XEt1ERcNdcPiqhSfqi59jH_G2T-SBHGaN@mail.gmail.com>
	<s5h8w0lsvsi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h8w0lsvsi.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 12:43 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 18 Nov 2010 23:20:50 -0500,
> Manoj Iyer wrote:
>>
>> Sorry my patch encoding was broken, below is the correction.
>>
>> =A0The following changes since commit 0c1c062266ecfeaebadadb780020a4=
22f829284f:
>> =A0 Manoj Iyer (1):
>> =A0 =A0 =A0 =A0 Enable jack sense for Thinkpad Edge 11
>>
>> =A0are available in the git repository at:
>>
>> =A0git://kernel.ubuntu.com/manjo/linux-2.6.git thinpad11
>
> The fixed patch seems missing. =A0Could you repost?

=46rom 89796b0608f0c36cbd05d0426e95386766ff20b9 Mon Sep 17 00:00:00 200=
1
=46rom: Manoj Iyer <manoj.iyer@canonical.com>
Date: Thu, 18 Nov 2010 21:24:42 +0000
Subject: [PATCH] Enable jack sense for Thinkpad Edge 11

Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conex=
ant.c
index 6361f75..b8d6554 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3108,6 +3108,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] =3D=
 {
        SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_OLPC_XO_1_=
5),
        SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400s", CXT5066_THINKPAD)=
,
        SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD=
),
+       SND_PCI_QUIRK(0x17aa, 0x21c8, "Thinkpad Edge 11", CXT5066_THINK=
PAD),
        SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (197)",
CXT5066_IDEAPAD),
        SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066_IDEAPAD)=
,
        SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKP=
AD),
--=20
1.7.0.4



>
>
> thanks,
>
> Takashi
>
>>
>> On Thu, Nov 18, 2010 at 4:35 PM, Manoj Iyer <manoj.iyer@canonical.co=
m> wrote:
>> > This patch enables audio play back from external headphones on Thi=
nkpad Edge 11.
>> >
>> > The following changes since commit 0c1c062266ecfeaebadadb780020a42=
2f829284f:
>> > =A0Manoj Iyer (1):
>> > =A0 =A0 =A0 =A0Enable jack sense for Thinkpad Edge 11
>> >
>> > are available in the git repository at:
>> >
>> > =A0git://kernel.ubuntu.com/git/manjo/linux-2.6.git thinpad11
>> >
>> > From 89796b0608f0c36cbd05d0426e95386766ff20b9 Mon Sep 17 00:00:00 =
2001
>> > From: Manoj Iyer <manoj.iyer@canonical.com>
>> > Date: Thu, 18 Nov 2010 21:24:42 +0000
>> > Subject: [PATCH] Enable jack sense for Thinkpad Edge 11
>> >
>> > Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
>> > ---
>> > =A0sound/pci/hda/patch_conexant.c | =A0 =A01 +
>> > =A01 files changed, 1 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_=
conexant.c
>> > index 6361f75..b8d6554 100644
>> > --- a/sound/pci/hda/patch_conexant.c
>> > +++ b/sound/pci/hda/patch_conexant.c
>> > @@ -3108,6 +3108,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[=
] =3D {
>> > =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT506=
6_OLPC_XO_1_5),
>> > =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400s", CXT50=
66_THINKPAD),
>> > =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT=
5066_IDEAPAD),
>> > + =A0 =A0 =A0 SND_PCI_QUIRK(0x17aa, 0x21c8, "Thinkpad Edge 11", CX=
T5066_THINKPAD),
>> > =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (19=
7)",
>> > CXT5066_IDEAPAD),
>> > =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5=
066_IDEAPAD),
>> > =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CX=
T5066_THINKPAD),
>> > --
>> > 1.7.0.4
>> >
>> > ---
>> > Manoj Iyer
>> >
>>
>>
>>
>> --
>> --manjo
>>
>



--=20
--manjo
