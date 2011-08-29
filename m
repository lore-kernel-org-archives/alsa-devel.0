From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] sound: usb: mixer: increase control
	transfer timeout
Date: Mon, 29 Aug 2011 13:58:31 +0200
Message-ID: <4E5B7EE7.6070103@ladisch.de>
References: <1314616226-15942-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de
	[80.67.31.94]) by alsa0.perex.cz (Postfix) with ESMTP id 35FDE244C9
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 13:58:27 +0200 (CEST)
In-Reply-To: <1314616226-15942-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felipe Balbi <balbi@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Felipe Balbi wrote:
> 100ms might not be enough for slower devices. Increasing
> timeout to 1000ms doesn't seem like overkill.
> 
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -296,7 +296,7 @@ static int get_ctl_value_v1(struct usb_mixer_elem_info *cval, int request, int v
>  		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
>  				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
>  				    validx, snd_usb_ctrl_intf(chip) | (cval->id << 8),
> -				    buf, val_len, 100) >= val_len) {
> +				    buf, val_len, 1000) >= val_len) {

If the timeout for reading values needs to be increased, writing (in
snd_usb_mixer_set_ctl_value) probably needs some attention too.


Regards,
Clemens
