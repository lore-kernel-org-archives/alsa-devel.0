From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH v2 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
Date: Sun, 4 May 2014 13:50:03 -0400
Message-ID: <20140504175003.GX28159@titan.lakedaemon.net>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
 <1399141819-23924-6-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399141819-23924-6-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 03, 2014 at 08:30:15PM +0200, Andrew Lunn wrote:
> Some platforms require that the codecs mclk is a fixed multiplication
> factor of the audio stream rate. Add a optional property to the
> binding to hold this factor and implement a hw_params() function to
> make use of it.
> 
> Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
> ---
> v1->v2:
> s/factor/fs/g
> ---
>  .../devicetree/bindings/sound/simple-card.txt      |  2 ++
>  sound/soc/generic/simple-card.c                    | 28 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)

Acked-by: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
