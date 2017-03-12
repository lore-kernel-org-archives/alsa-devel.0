From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/10] ALSA SoC MAX98927 driver - Initial release
Date: Sun, 12 Mar 2017 09:11:02 -0500
Message-ID: <20170312141102.fxigzia2nvfuli2d@rob-hp-laptop>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
 <1488552768-14901-2-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488552768-14901-2-git-send-email-ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org, oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, yesanishhere-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jacob-EZCvousvhKUZux3j3Bed6dkegs52MxvZ@public.gmane.org, Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, nh6z-fFIq/eER6g8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 03, 2017 at 11:52:39PM +0900, Ryan Lee wrote:
> From: Ryan Lee <RyanS.Lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> 
> Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
> ---
> 
> Initial release of ALSA SoC MAX98927 driver.
> 
>  .../devicetree/bindings/sound/max98927.txt         |   32 +

In addition to what Mark said, please split bindings to a separate 
patch.

>  sound/soc/codecs/Kconfig                           |    5 +
>  sound/soc/codecs/Makefile                          |    2 +
>  sound/soc/codecs/max98927.c                        |  954 +++++++++++++++
>  sound/soc/codecs/max98927.h                        | 1253 ++++++++++++++++++++
>  5 files changed, 2246 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/sound/max98927.txt
>  mode change 100644 => 100755 sound/soc/codecs/Kconfig
>  mode change 100644 => 100755 sound/soc/codecs/Makefile
>  create mode 100755 sound/soc/codecs/max98927.c
>  create mode 100755 sound/soc/codecs/max98927.h

These files should not be executable.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
