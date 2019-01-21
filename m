From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH] ALSA: usb-audio: Add SMSL D1 to quirks for
 native DSD support
Date: Mon, 21 Jan 2019 18:33:22 +0200
Message-ID: <abc18173-4b27-e9ca-095a-4f4bfbedfd66@sonarnerd.net>
References: <CAKb=P8ugru=qaO6S29xBjdi0kXkrFmbDxVYk07cUnL=t35GG4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 999ED2667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 17:33:23 +0100 (CET)
In-Reply-To: <CAKb=P8ugru=qaO6S29xBjdi0kXkrFmbDxVYk07cUnL=t35GG4g@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Tony Das <tdas444@gmail.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 28.11.2018 22.16, Tony Das wrote:
> This patch adds quirk VID/PID IDs for the SMSL D1 in order to enable
> Native DSD support.
> 
> Signed-off-by: Tony Das <tdas444@gmail.com>
> ---
> Author: Tony Das <tdas444@gmail.com>
> Date: Tue Nov 27 22:13:30 2018 +0000
> 
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 3d0f09108c98..aeac6bb7e111 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -1515,6 +1515,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct
> snd_usb_audio *chip,
>     case USB_ID(0x27f7, 0x3002): /* W4S DAC-2v2SE */
>     case USB_ID(0x29a2, 0x0086): /* Mutec MC3+ USB */
>     case USB_ID(0x6b42, 0x0042): /* MSB Technology */
> +   case USB_ID(0x152a, 0x85de): /* SMSL D1 DAC */
>         if (fp->altsetting == 3)
>             return SNDRV_PCM_FMTBIT_DSD_U32_BE;
>         break;

These kind of device specific white-listing patches are unnecessary 
these days for VID 0x152a (Thesycon), 0x20b1 (XMOS) and 0x25ce (Mytek) 
because they are covered by the auto-detection code (below this 
whitelisting table). In fact, for some products they cause problems due 
to firmware changes that cause the DSD altsetting to change. Also there 
are vendors who use same VID:PID pair for multiple products with 
different firmware variants and different altsettings which in turn 
causes problems with these static altsetting listings.

So I would strongly advise to use the autodetection whenever possible. 
In my own kernel builds I've removed all those mentioned VIDs from the 
PID specific table, but for the already included patches I took more 
conservative approach and removed only the ones I could 100% test myself.

Sorry for the delay, I didn't notice this posting until now...


Best regards,

	 - Jussi
