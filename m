From: Yue Wang <yuleopen@gmail.com>
Subject: Re: [PATCH] alsa/usb-audio: Generic DSD detection for Thesycon-based implementations
Date: Mon, 23 Jul 2018 01:54:49 -0700
Message-ID: <CA+C1juZXWV7EfYd9_cMB+bny=+cRp_O-2GRob3WxarJNGryXdw@mail.gmail.com>
References: <20180723085327.49134-1-yuleopen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723085327.49134-1-yuleopen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sherry Zhang <yuleopen@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jussi Laako <jussi@sonarnerd.net>, Nobutaka Okabe <nob77413@gmail.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Daniel Mack <daniel@zonque.org>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Alberto Aguirre <albaguirre@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Please ignore this commit. there's something wrong. My apologies again.
On Mon, Jul 23, 2018 at 1:53 AM Yue Wang <yuleopen@gmail.com> wrote:
>
> Thesycon provides solutions to XMOS chips, and has its own device vendor id.
>
> In this patch, we use generic method to detect DSD capability of Thesycon-based UAC2
> implementations in order to support a wide range of current and future devices.
>
> The patch will enable the SNDRV_PCM_FMTBIT_DSD_U32_BE bit for the DAC
> hence enable native DSD playback up to DSD512 format.
>
> Signed-off-by: Yue Wang <yuleopen@gmail.com>
> ---
>  sound/usb/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 02b6cc02767f..c51e2dee3075 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -1374,6 +1374,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
>                 break;
>
>         case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
> +       case USB_ID(0x152a, 0x8750): /* Topping DX7s */
>         case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
>         case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
>         case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
> --
> 2.18.0
>
