From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6] ASoC: pcm179x: Add support for pcm1795 and pcm1796
Date: Fri, 18 Mar 2016 15:08:58 -0500
Message-ID: <20160318200858.GA31755@rob-hp-laptop>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-4-git-send-email-michael@amarulasolutions.com>
 <20160110120045.GW6588@sirena.org.uk>
 <20160110173812.GA16304@panicking>
 <20160205172451.GA30542@panicking>
 <20160222031944.GT18327@sirena.org.uk>
 <20160311225937.GA27257@panicking>
 <20160311230930.GB27257@panicking>
 <20160311232856.GC27257@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160311232856.GC27257@panicking>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jacob Siverskog <jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, adamo.a60-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 12, 2016 at 12:29:00AM +0100, Michael Trimarchi wrote:
> ASoC: pcm179x: Add support for pcm1795 and pcm1796
> 
> Signed-off-by: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> Tested-by: Angelo Adamo <adamo.a60-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes v5 -> v6
> 	- Add device tree documentation
> 
> Changes v4 -> v5
> 	- remove dead code
> 
> Changes v3 -> v4:
> 	- clean up compatible list
> 	- use enum type instead of pointer of int
> 
> Changes v2 -> v3:
> 	- rebase after i2c support
> 
> Changes v1 -> v2:
> 	- Use switch for support new variants
> 	- sort the compatible list
> 
>  .../devicetree/bindings/sound/pcm179x.txt          |  2 +

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  sound/soc/codecs/pcm179x-i2c.c                     |  6 --
>  sound/soc/codecs/pcm179x-spi.c                     |  6 --
>  sound/soc/codecs/pcm179x.c                         | 65 ++++++++++++++++++++--
>  sound/soc/codecs/pcm179x.h                         |  9 ++-
>  5 files changed, 70 insertions(+), 18 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
