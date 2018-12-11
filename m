From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v10 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date: Tue, 11 Dec 2018 12:09:59 +0200
Message-ID: <CAHp75VeLKGA0jwe9eqfSAisrQZB65Yvt3Kse1Cy7=Zkqqp02hQ@mail.gmail.com>
References: <20181211060125.28671-1-ayman.bagabas@gmail.com> <20181211060125.28671-4-ayman.bagabas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211060125.28671-4-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ayman Bagabas <ayman.bagabas@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 11, 2018 at 8:02 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> Some of Huawei laptops come with a LED in the micmute key. This patch
> enables the use of micmute LED for these devices:
> 1. Matebook X (19e5:3200), (19e5:3201)
> 2. Matebook X Pro (19e5:3204)
>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> ---
>  sound/pci/hda/patch_realtek.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 1326f32f4574..9766fd249bdf 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5776,7 +5776,9 @@ static const struct hda_fixup alc269_fixups[] = {
>                         {0x1e, 0x411111f0},
>                         {0x21, 0x04211020},
>                         { }

> -               }
> +               },

This is not related change, but we may fix it when applying.

> +               .chained = true,
> +               .chain_id = ALC255_FIXUP_MIC_MUTE_LED
>         },
>         [ALC269_FIXUP_ASUS_X101_FUNC] = {
>                 .type = HDA_FIXUP_FUNC,
> @@ -6608,6 +6610,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>         SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
>         SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
>         SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
> +       SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
> +       SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
>         SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
>         SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
>
> --
> 2.19.2
>


-- 
With Best Regards,
Andy Shevchenko
