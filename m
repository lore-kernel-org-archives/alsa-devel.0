From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Thu, 19 Sep 2013 18:49:52 +0100
Message-ID: <20130919174952.GC12758@n2100.arm.linux.org.uk>
References: <20130919105437.75e0f0a3@armhf> <20130919104028.GI21013@sirena.org.uk> <20130919193403.30ac5764@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130919193403.30ac5764@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 19, 2013 at 07:34:03PM +0200, Jean-Francois Moine wrote:
> Otherwise, for Dove, we need at least "s16_le", "s24_le" and "s32_le"
> and, perhaps, "iec958_subframe_le" and "iec958_subframe_be".

The audio block can't do IEC958 subframes in the format ALSA wants
them.  The hardware format is different.  I've sent a commit removing
these foramts from sound/soc/kirkwood with a full explanation.  Mark
seems not to have merged even that one though.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
