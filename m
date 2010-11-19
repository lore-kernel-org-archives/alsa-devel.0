From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: Re: [PATCH] Enable jack sense for Thinkpad Edge 11
Date: Thu, 18 Nov 2010 23:20:50 -0500
Message-ID: <AANLkTinWMv0XEt1ERcNdcPiqhSfqi59jH_G2T-SBHGaN@mail.gmail.com>
References: <AANLkTin2zKWLLxsRn+T+U+NpAmbQiOTM_vrg_Z-8JZd-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTin2zKWLLxsRn+T+U+NpAmbQiOTM_vrg_Z-8JZd-@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Sorry my patch encoding was broken, below is the correction.

 The following changes since commit 0c1c062266ecfeaebadadb780020a422f82=
9284f:
  Manoj Iyer (1):
        Enable jack sense for Thinkpad Edge 11

 are available in the git repository at:

 git://kernel.ubuntu.com/manjo/linux-2.6.git thinpad11

On Thu, Nov 18, 2010 at 4:35 PM, Manoj Iyer <manoj.iyer@canonical.com> =
wrote:
> This patch enables audio play back from external headphones on Thinkp=
ad Edge 11.
>
> The following changes since commit 0c1c062266ecfeaebadadb780020a422f8=
29284f:
> =A0Manoj Iyer (1):
> =A0 =A0 =A0 =A0Enable jack sense for Thinkpad Edge 11
>
> are available in the git repository at:
>
> =A0git://kernel.ubuntu.com/git/manjo/linux-2.6.git thinpad11
>
> From 89796b0608f0c36cbd05d0426e95386766ff20b9 Mon Sep 17 00:00:00 200=
1
> From: Manoj Iyer <manoj.iyer@canonical.com>
> Date: Thu, 18 Nov 2010 21:24:42 +0000
> Subject: [PATCH] Enable jack sense for Thinkpad Edge 11
>
> Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
> ---
> =A0sound/pci/hda/patch_conexant.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_con=
exant.c
> index 6361f75..b8d6554 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -3108,6 +3108,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] =3D=
 {
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT5066_O=
LPC_XO_1_5),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400s", CXT5066_=
THINKPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT506=
6_IDEAPAD),
> + =A0 =A0 =A0 SND_PCI_QUIRK(0x17aa, 0x21c8, "Thinkpad Edge 11", CXT50=
66_THINKPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b3, "Thinkpad Edge 13 (197)"=
,
> CXT5066_IDEAPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x21b4, "Thinkpad Edge", CXT5066=
_IDEAPAD),
> =A0 =A0 =A0 =A0SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT50=
66_THINKPAD),
> --
> 1.7.0.4
>
> ---
> Manoj Iyer
>



--=20
--manjo
