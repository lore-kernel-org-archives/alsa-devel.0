From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Sat, 14 May 2016 09:25:19 -0500
Message-ID: <20160514142519.GA18477@rob-hp-laptop>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462892797-1147-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 10, 2016 at 05:06:37PM +0200, Peter Rosin wrote:
> This is a driver for the MAX9860 Mono Audio Voice Codec.
> 
> https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
> 
> This driver does not support sidetone since the DVST register field is
> backwards with the mute near the maximum level instead of the minimum.
> 
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/max9860.txt          |  27 +

It is preferred to have the binding in a separate patch. Otherwise,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  MAINTAINERS                                        |   7 +
>  sound/soc/codecs/Kconfig                           |   6 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/max9860.c                         | 722 +++++++++++++++++++++
>  sound/soc/codecs/max9860.h                         | 162 +++++
>  6 files changed, 926 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/max9860.txt
>  create mode 100644 sound/soc/codecs/max9860.c
>  create mode 100644 sound/soc/codecs/max9860.h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
