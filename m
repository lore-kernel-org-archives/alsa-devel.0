From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 10/12] ASoC: dw-hdmi-audio: add codec driver for dw
 hdmi audio
Date: Sat, 31 Jan 2015 11:39:52 +0000
Message-ID: <20150131113952.GB26493@n2100.arm.linux.org.uk>
References: <1422617031-25098-1-git-send-email-ykk@rock-chips.com>
 <1422618071-27178-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422618071-27178-1-git-send-email-ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dbehr-ph2c+iIn4itg9hUCZPvPmw@public.gmane.org, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, march
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 30, 2015 at 06:41:11AM -0500, Yakir Yang wrote:
> codec driver creat an standard alsa device, than config audio
> and report jack status through some callback interfaces that
> dw_hdmi driver support.
> 
> Signed-off-by: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> Changes in v2:
> - Update dw_hdmi audio control interfaces, and adjust jack report process

As you are aware, this can't work with iMX6 SoCs.  We need to come up with
some way to deal with the different IP cores in a sane way.

The "codec" part of this IP is different between the two implementations;
your ASoC codec driver is not useful on the iMX6 SoC implementation.

We need to find a way to allow these two implementations to co-exist
sanely.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
