From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v15 5/5] ASoC: rockchip: Add DP dai-links to the
 rk3399-gru machine driver
Date: Mon, 19 Sep 2016 16:37:27 -0500
Message-ID: <20160919213727.GA22901@rob-hp-laptop>
References: <1473473748-22331-1-git-send-email-zyw@rock-chips.com>
 <1473473748-22331-6-git-send-email-zyw@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473473748-22331-6-git-send-email-zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, wulf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cychiang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, hychao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 09, 2016 at 07:15:48PM -0700, Chris Zhong wrote:
> This patch adds DP audio output support to the rk3399-gru machine
> driver.
> 
> Signed-off-by: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v15: None
> Changes in v14: None
> Changes in v13: None
> Changes in v12: None
> Changes in v11: None
> Changes in v10: None
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - change spdif to i2s2
> 
> Changes in v2:
> - correct the commit message
> 
> Changes in v1: None
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt   | 11 +--
>  sound/soc/rockchip/rk3399_gru_sound.c              | 93 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> index f19b6c8..83af540 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> @@ -1,15 +1,16 @@
> -ROCKCHIP with MAX98357A/RT5514/DA7219 codecs on GRU boards
> +ROCKCHIP with MAX98357A/RT5514/DA7219 codecs and DP via spdif on GRU boards
>  
>  Required properties:
>  - compatible: "rockchip,rk3399-gru-sound"
> -- rockchip,cpu: The phandle of the Rockchip I2S controller that's
> +- rockchip,cpu: The phandle of the Rockchip I2S controller controller that's

Huh?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
