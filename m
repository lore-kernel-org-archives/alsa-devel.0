From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH][TRIVIAL] remove extra space
Date: Fri, 3 Apr 2009 11:49:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904031148500.10082@wotan.suse.de>
References: <49D5BCE6.9070901@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 26A1D1037F3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 11:49:50 +0200 (CEST)
In-Reply-To: <49D5BCE6.9070901@einfochips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Viral Mehta <viral.mehta@einfochips.com>
Cc: alsa-devel@alsa-project.org, trivial@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 3 Apr 2009, Viral Mehta wrote:

> 
> Just for the sake of readability, removing extra space
> 
> Signed-off-by: Viral Mehta <viral.mehta@einfochips.com>
> --- 
> --- a/sound/usb/usbmixer.c        2009-03-24 04:42:14.000000000 +0530
> +++ b/sound/usb/usbmixer.c    2009-04-03 12:49:49.000000000 +0530
> @@ -394,7 +394,7 @@ static int set_ctl_value(struct usb_mixe
>        value_set = convert_bytes_value(cval, value_set);
>        buf[0] = value_set & 0xff;
>        buf[1] = (value_set >> 8) & 0xff;
> -       while (timeout -- > 0)
> +       while (timeout-- > 0)
>                if (snd_usb_ctl_msg(cval->mixer->chip->dev,
>                                    usb_sndctrlpipe(cval->mixer->chip->dev, 0),
>                                    request,

Applied to trivial tree, thanks.

-- 
Jiri Kosina
SUSE Labs
