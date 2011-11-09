From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: [PATCH] snd_usb_audio: add Logitech HD Webcam c510
 to quirk-384
Date: Wed, 09 Nov 2011 11:41:37 +0100
Message-ID: <4EBA58E1.7030705@fisher-privat.net>
References: <1320835164-3540-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id AAF70103A08
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 11:41:40 +0100 (CET)
In-Reply-To: <1320835164-3540-1-git-send-email-bug-track@fisher-privat.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi, can you pleas add this patch on top of your quirk fix.

Thank you.

Am 09.11.2011 11:39, schrieb Alexey Fisher:
> Logitech HD Webcam c510 provide wrong mixer resolution.
> Add it to "res = 384" quirk.
>
> Signed-off-by: Alexey Fisher<bug-track@fisher-privat.net>
> ---
>   sound/usb/mixer.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index c5444e0..ab23869 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -799,6 +799,7 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
>
>   	case USB_ID(0x046d, 0x0808):
>   	case USB_ID(0x046d, 0x0809):
> +	case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
>   	case USB_ID(0x046d, 0x0991):
>   	/* Most audio usb devices lie about volume resolution.
>   	 * Most Logitech webcams have res = 384.
