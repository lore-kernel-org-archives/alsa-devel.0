From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 1/2] ASoC: da7218: fix fix child-node lookup
Date: Tue, 14 Nov 2017 12:02:47 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1AEB68@SW-EX-MBX01.diasemi.com>
References: <20171113111256.24140-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171113111256.24140-1-johan@kernel.org>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On 13 November 2017 11:13, Johan Hovold wrote:

> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
> 
> To make things worse, the parent codec node was also prematurely freed.
> 
> Fixes: 4d50934abd22 ("ASoC: da7218: Add da7218 codec driver")
> Cc: stable <stable@vger.kernel.org>     # 4.5
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7218.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> index b2d42ec1dcd9..56564ce90cb6 100644
> --- a/sound/soc/codecs/da7218.c
> +++ b/sound/soc/codecs/da7218.c
> @@ -2520,7 +2520,7 @@ static struct da7218_pdata *da7218_of_to_pdata(struct
> snd_soc_codec *codec)
>  	}
> 
>  	if (da7218->dev_id == DA7218_DEV_ID) {
> -		hpldet_np = of_find_node_by_name(np, "da7218_hpldet");
> +		hpldet_np = of_get_child_by_name(np, "da7218_hpldet");
>  		if (!hpldet_np)
>  			return pdata;
> 
> --
> 2.15.0
