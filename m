From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5] ARM: dts: pbab01: move i2c pins and frequency
 configuration into pfla02
Date: Thu, 11 Sep 2014 10:47:18 +0200
Message-ID: <1410425238.4011.18.camel@paszta.hi.pengutronix.de>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
	 <1410356809-26179-2-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410356809-26179-2-git-send-email-d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, den 10.09.2014, 16:46 +0300 schrieb Dmitry Lavnikevich:
> Since pins and frequency are specific to module (pfla02), not base board
> (pbab02), it is better to be initialized in corresponding dts file.
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>

I have seen boards use the GPIO_3/6 pads instead of EIM_D17/D18 for
I2C3, but the EIM_D17/D18 are indeed documented as "I2C1" pins at the
pfla02 connector level.

regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
