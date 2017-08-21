From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: usb 1-2: 1:1: cannot set freq 44100 to ep 0x81 and
	potential fix
Date: Mon, 21 Aug 2017 08:43:39 +0000
Message-ID: <1503305016.9282.5.camel@infinera.com>
References: <1503234895.16771.4.camel@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0046.outbound.protection.outlook.com [104.47.40.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7290B266A74
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 10:43:43 +0200 (CEST)
In-Reply-To: <1503234895.16771.4.camel@infinera.com>
Content-Language: en-US
Content-ID: <961B092085699E41A71EDDD74315475F@infinera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "perex@perex.cz" <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Sun, 2017-08-20 at 15:14 +0200, Joakim Tjernlund wrote:
> I have two USB headsets (Logitech Inc Logitech Stereo H650e and
> Jabra Jabra UC VOICE 550a) who both causes lots of:
> 
>     usb 1-2: 1:1: cannot set freq 44100 to ep 0x81
> 
> errors when using them for pidgin audio chats. The actual freq
> varies though.
> 
> I found that adding a small delay here:
>  diff -u sound/usb/clock.c.org  sound/usb/clock.c 
> --- sound/usb/clock.c.org	2017-08-18 14:38:05.597977669 +0200
> +++ sound/usb/clock.c	2017-08-18 14:20:14.653661513 +0200
> @@ -304,6 +304,7 @@
>  			iface, fmt->altsetting, rate, ep);
>  		return err;
>  	}
> +        msleep(1);
>  
>  	/* Don't check the sample rate for devices which we know don't
>  	 * support reading */
> 
> it seems one cannot do these settings too fast
> Ant better idea for a fix? kernel 4.9.44
> 
>  Jocke
> 
> PS.
>    When starting a chat with pidgin-sipe, I see the same sample rate
> freq setting twice, not sure where that comes from.
>  

I found snd_usb_ctl_msg_quirk() and if I add the same logic as
for Zoom R16/24:
+
+       /* Logitech H650e needs a tiny delay here, otherwise requests like
+        * get/set frequency return as failed despite actually succeeding.
+        */
+       if (chip->usb_id == USB_ID(0x046D, 0x0A46) &&
+           (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+               mdelay(1);
+
+       /* Jambra 550a needs a tiny delay here, otherwise requests like
+        * get/set frequency return as failed despite actually succeeding.
+        */
+       if (chip->usb_id == USB_ID(0x0B0E, 0x0349) &&
+           (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+               mdelay(1);

it works again. Is the above an acceptable patch ?

 Jocke
