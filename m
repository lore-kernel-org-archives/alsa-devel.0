From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: ak4104: Remove superfluous
 codec->control_data initialization
Date: Tue, 04 Mar 2014 12:48:19 +0100
Message-ID: <5315BD83.2090504@gmail.com>
References: <1393921177-24294-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FDEB265765
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 12:48:23 +0100 (CET)
Received: by mail-we0-f170.google.com with SMTP id w61so4766454wes.29
 for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2014 03:48:22 -0800 (PST)
In-Reply-To: <1393921177-24294-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/04/2014 09:19 AM, Lars-Peter Clausen wrote:
> The driver uses automatic IO setup, which will also initialize the control_data
> field of the CODEC, no need to do it manually.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Daniel Mack <daniel@zonque.org>


Thanks!
Daniel


> ---
>  sound/soc/codecs/ak4104.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
> index b4819dc..10adf25 100644
> --- a/sound/soc/codecs/ak4104.c
> +++ b/sound/soc/codecs/ak4104.c
> @@ -174,8 +174,6 @@ static int ak4104_probe(struct snd_soc_codec *codec)
>  	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
>  	int ret;
>  
> -	codec->control_data = ak4104->regmap;
> -
>  	/* set power-up and non-reset bits */
>  	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
>  				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN,
> 
