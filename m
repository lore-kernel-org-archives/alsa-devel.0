From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] ASoC: sta32x: Move resource allocation and
 release to the corresponding callback functions
Date: Thu, 18 Aug 2011 12:14:32 +0200
Message-ID: <20110818101432.GA6648@sig21.net>
References: <1313652664.2917.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id BC1CD24659
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 12:14:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313652664.2917.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 18, 2011 at 03:31:04PM +0800, Axel Lin wrote:
> This patch includes below small fixes:
> 
> 1. Move sta32x_set_bias_level() from sta32x_i2c_remove() to sta32x_remove().
> 2. Remove a redundant regulator_bulk_free() call in sta32x_i2c_remove(),
>    as we will call regulator_bulk_free() in sta32x_remove().
> 3. Remove unneeded snd_soc_codec_set_drvdata(codec, NULL) in sta32x_i2c_remove.
>    The i2c core will set the clientdata to NULL.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> hi,
> I don't have this hardware handy. I appreciate if someone can test this patch.
> 
> Axel

Your patch looks good, but I also don't have the hardware currently.
Maybe Sven or Daniel could test?  But even though it's untested:

Acked-by: Johannes Stezenbach <js@sig21.net>

Thanks
Johannes

>  sound/soc/codecs/sta32x.c |   13 ++-----------
>  1 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
> index 3d155f5..5c7def3 100644
> --- a/sound/soc/codecs/sta32x.c
> +++ b/sound/soc/codecs/sta32x.c
> @@ -812,6 +812,7 @@ static int sta32x_remove(struct snd_soc_codec *codec)
>  {
>  	struct sta32x_priv *sta32x = snd_soc_codec_get_drvdata(codec);
>  
> +	sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
>  	regulator_bulk_disable(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
>  	regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
>  
> @@ -871,18 +872,8 @@ static __devinit int sta32x_i2c_probe(struct i2c_client *i2c,
>  static __devexit int sta32x_i2c_remove(struct i2c_client *client)
>  {
>  	struct sta32x_priv *sta32x = i2c_get_clientdata(client);
> -	struct snd_soc_codec *codec = sta32x->codec;
> -
> -	if (codec)
> -		sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
> -
> -	regulator_bulk_free(ARRAY_SIZE(sta32x->supplies), sta32x->supplies);
> -
> -	if (codec) {
> -		snd_soc_unregister_codec(&client->dev);
> -		snd_soc_codec_set_drvdata(codec, NULL);
> -	}
>  
> +	snd_soc_unregister_codec(&client->dev);
>  	kfree(sta32x);
>  	return 0;
>  }
> -- 
> 1.7.4.1
> 
> 
> 
> 
