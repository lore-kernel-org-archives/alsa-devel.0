From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix driver probe after
	reset
Date: Wed, 08 May 2013 22:12:58 +0200
Message-ID: <518AB1CA.8060805@metafoo.de>
References: <1368032653-19489-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-108.synserver.de (smtp-out-108.synserver.de
 [212.40.185.108])
 by alsa0.perex.cz (Postfix) with ESMTP id BD4CF261AB0
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 22:13:32 +0200 (CEST)
In-Reply-To: <1368032653-19489-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 05/08/2013 07:04 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> sgtl5000 codec does not have a reset line, nor a reset command in software.
> 
> After a 'reboot' command in Linux or after pressing the system's reset button
> the sgtl5000 driver fails to probe:
> 
> sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
> sgtl5000 0-000a: ASoC: failed to probe CODEC -19
> imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
> imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)
> 
> As the sgtl5000 codec did not go through a real reset, we cannot rely on the 
> reg_defaults array, since these are only valid after a clean power-on reset.
> 
> To fix this issue, use 'reg_defaults_raw' which tells the regcache driver
> to actually read the codec registers and then fill the cache.

No, that's not what it does. It will only fill the cache from the hardware,
if reg_defaults_raw is NULL and num_reg_defaults_raw is not 0.

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  sound/soc/codecs/sgtl5000.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 327b443..c59fae8 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -1470,8 +1470,8 @@ static const struct regmap_config sgtl5000_regmap = {
>  	.readable_reg = sgtl5000_readable,
>  
>  	.cache_type = REGCACHE_RBTREE,
> -	.reg_defaults = sgtl5000_reg_defaults,
> -	.num_reg_defaults = ARRAY_SIZE(sgtl5000_reg_defaults),
> +	.reg_defaults_raw = sgtl5000_reg_defaults,
> +	.num_reg_defaults_raw = ARRAY_SIZE(sgtl5000_reg_defaults),

This shouldn't even compile without generating a warning.

>  };
>  
>  static int sgtl5000_i2c_probe(struct i2c_client *client,
