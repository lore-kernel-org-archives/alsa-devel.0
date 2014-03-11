From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: cs42888: Add codec driver support
Date: Tue, 11 Mar 2014 10:41:32 -0500
Message-ID: <alpine.DEB.2.02.1403111026280.3558@heelrod>
References: <1394536791-8381-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394536791-8381-1-git-send-email-Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


On Tue, 11 Mar 2014, Nicolin Chen wrote:

> This patch adds support for the Cirrus Logic CS42888 Audio CODEC that
> has four 24-bit A/D and eight 24-bit D/A converters.
>
> [ CS42888 supports both I2C and SPI control ports. As initial patch,
>  this patch only adds the support for I2C. ]
>
> Signed-off-by: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
So WRT the CS42888, this is one device in a series of 2 devices that are 
register compatible with the only difference being that the CS42488 has 2 
extra ADC's. Same die and same DeviceID.

Would it make more sense to submit the driver with the extra ADC's to make 
it feature complete for both devices? Wouldn't be odd to have 2 drivers 
that do the same for 98% of the code.

Thoughts?
Brian

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
