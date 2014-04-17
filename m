From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH 2/5] ARM: Kirkwood: Use DT to instansiate codec
Date: Thu, 17 Apr 2014 17:37:01 -0400
Message-ID: <20140417213701.GV28159@titan.lakedaemon.net>
References: <1397749994-24983-1-git-send-email-andrew@lunn.ch>
 <1397749994-24983-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397749994-24983-3-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Andrew,

First, thanks for following through with the kirkwood DT conversion.

I have one small request below:

On Thu, Apr 17, 2014 at 05:53:11PM +0200, Andrew Lunn wrote:
> Now that the ALC5623 codec has a DT binding, instansiate it using DT
> rather than a platform device.
> 
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
>  arch/arm/boot/dts/kirkwood-t5325.dts |  8 ++++++++
>  arch/arm/mach-mvebu/board-t5325.c    | 15 ---------------
>  2 files changed, 8 insertions(+), 15 deletions(-)

Since the audio device isn't critical to boot, can we split this patch
and the other DT patch in two?  That'll prevent branch
dependency/merge conflicts between mvebu/dt and mvebu/soc.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
