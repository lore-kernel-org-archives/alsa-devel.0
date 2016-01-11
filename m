From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] ASoC: pcm1792a: Rename pcm1792a to pcm179x
Date: Sun, 10 Jan 2016 21:06:17 -0600
Message-ID: <20160111030617.GA21801@rob-hp-laptop>
References: <1452382685-18009-1-git-send-email-michael@amarulasolutions.com>
 <1452382685-18009-3-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452382685-18009-3-git-send-email-michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 10, 2016 at 12:38:04AM +0100, Michael Trimarchi wrote:
> pcm1792a is compatible with pcm1795 and pcm1796 so it's
> better to have them under the common name pcm179x
> 
> Signed-off-by: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/pcm1792a.txt         |  18 --
>  .../devicetree/bindings/sound/pcm179x.txt          |  18 ++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Please use -M option for git-format-patch for renames/moves. The binding 
is short enough, but the driver isn't really. 

>  sound/soc/codecs/Kconfig                           |   6 +-
>  sound/soc/codecs/Makefile                          |   4 +-
>  sound/soc/codecs/pcm1792a.c                        | 271 ---------------------
>  sound/soc/codecs/pcm1792a.h                        |  27 --
>  sound/soc/codecs/pcm179x.c                         | 271 +++++++++++++++++++++
>  sound/soc/codecs/pcm179x.h                         |  27 ++
>  8 files changed, 321 insertions(+), 321 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/pcm1792a.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm179x.txt
>  delete mode 100644 sound/soc/codecs/pcm1792a.c
>  delete mode 100644 sound/soc/codecs/pcm1792a.h
>  create mode 100644 sound/soc/codecs/pcm179x.c
>  create mode 100644 sound/soc/codecs/pcm179x.h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
