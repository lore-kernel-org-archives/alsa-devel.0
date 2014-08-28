From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs42l56: Remove unneeded
 regulator_bulk_free call in cs42l56_remove
Date: Thu, 28 Aug 2014 09:08:56 -0500
Message-ID: <alpine.DEB.2.02.1408280908150.27378@heelrod>
References: <1409219678.21395.4.camel@phoenix>
 <1409219720.21395.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 68540266440
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 16:08:23 +0200 (CEST)
In-Reply-To: <1409219720.21395.5.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


On Thu, 28 Aug 2014, Axel Lin wrote:

> The regulator_bulk_free() call is not required because current code is using
> devm_regulator_bulk_get().
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/cs42l56.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
> index c766a5a..5a2d732 100644
> --- a/sound/soc/codecs/cs42l56.c
> +++ b/sound/soc/codecs/cs42l56.c
> @@ -1175,11 +1175,8 @@ static int cs42l56_probe(struct snd_soc_codec *codec)
>  
>  static int cs42l56_remove(struct snd_soc_codec *codec)
>  {
> -	struct cs42l56_private *cs42l56 = snd_soc_codec_get_drvdata(codec);
> -
>  	cs42l56_free_beep(codec);
>  	cs42l56_set_bias_level(codec, SND_SOC_BIAS_OFF);
> -	regulator_bulk_free(ARRAY_SIZE(cs42l56->supplies), cs42l56->supplies);
>  
>  	return 0;
>  }
Thanks Axel,

For the series..

Acked-by: Brian Austin <brian.austin@cirrus.com>
