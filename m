From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 12/12] ASoC: rsnd: add Multi channel support
Date: Fri, 18 Dec 2015 22:18:10 -0600
Message-ID: <20151219041810.GI14936@rob-hp-laptop>
References: <87egeliyaz.wl%kuninori.morimoto.gx@renesas.com>
 <87wpsdhje9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87wpsdhje9.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 17, 2015 at 03:00:10AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> This patch adds Multi channel support on Renesas R-Car sound.
> This patch is tested on Salvator-X board, but it can't use
> Multi channel, because supported format is different between
> codec chip and R-Car.
> Thus, it was tested on board which doesn't mount codec chip,
> with oscilloscope.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/renesas,rsnd.txt     |  18 ++++

For the binding:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  sound/soc/sh/rcar/core.c                           |   6 +-
>  sound/soc/sh/rcar/gen.c                            |   3 +
>  sound/soc/sh/rcar/rsnd.h                           |  15 ++-
>  sound/soc/sh/rcar/ssi.c                            | 114 ++++++++++++++++++++-
>  sound/soc/sh/rcar/ssiu.c                           |  55 ++++++++--
>  6 files changed, 194 insertions(+), 17 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
