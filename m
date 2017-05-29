From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH v2 1/3] ALSA: usb-audio: fix Amanero
 Combo384 quirk on big-endian hosts
Date: Tue, 30 May 2017 02:40:09 +0300
Message-ID: <7d6e1d60-0259-8cb5-565e-0627608537a8@sonarnerd.net>
References: <20170512123439.14994-1-johan@kernel.org>
 <20170512123439.14994-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C20D26680F
 for <alsa-devel@alsa-project.org>; Tue, 30 May 2017 01:40:10 +0200 (CEST)
In-Reply-To: <20170512123439.14994-2-johan@kernel.org>
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
To: Johan Hovold <johan@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12.05.2017 15:34, Johan Hovold wrote:
> Add missing endianness conversion when using the USB device-descriptor
> bcdDevice field when applying the Amanero Combo384 (endianness!) quirk.
> 
> Fixes: 3eff682d765b ("ALSA: usb-audio: Support both DSD LE/BE Amanero firmware versions")
> Cc: Jussi Laako <jussi@sonarnerd.net>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   sound/usb/quirks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 01eff6ce6401..d7b0b0a3a2db 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -1364,7 +1364,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
>   	/* Amanero Combo384 USB interface with native DSD support */
>   	case USB_ID(0x16d0, 0x071a):
>   		if (fp->altsetting == 2) {
> -			switch (chip->dev->descriptor.bcdDevice) {
> +			switch (le16_to_cpu(chip->dev->descriptor.bcdDevice)) {
>   			case 0x199:
>   				return SNDRV_PCM_FMTBIT_DSD_U32_LE;
>   			case 0x19b:
> 


Sorry for the delay... Looks good to me, tested to work OK.


	- Jussi Laako
