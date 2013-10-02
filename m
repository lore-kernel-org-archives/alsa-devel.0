From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] sound: usb: add support for wireless USB devices
Date: Wed, 02 Oct 2013 15:30:34 +0200
Message-ID: <524C1FFA.8080704@gmail.com>
References: <1380655935-1366-1-git-send-email-thomas.pugliese@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380655935-1366-1-git-send-email-thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 01.10.2013 21:32, Thomas Pugliese wrote:
> This patch updates snd_usb_audio_create also support devices whose 
> speed == USB_SPEED_WIRELESS.

Interesting. What device are you testing this with?


Daniel


> 
> Signed-off-by: Thomas Pugliese <thomas.pugliese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/usb/card.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 64952e2..ef76aa0 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -349,6 +349,7 @@ static int snd_usb_audio_create(struct usb_device *dev, int idx,
>  	case USB_SPEED_LOW:
>  	case USB_SPEED_FULL:
>  	case USB_SPEED_HIGH:
> +	case USB_SPEED_WIRELESS:
>  	case USB_SPEED_SUPER:
>  		break;
>  	default:
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
