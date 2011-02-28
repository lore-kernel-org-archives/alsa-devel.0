From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Staticise non-exported symbols in
 SGTL5000
Date: Mon, 28 Feb 2011 15:08:54 +0000
Message-ID: <1298905734.3300.1.camel@odin>
References: <1298903619-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DDD5C1038C3
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 16:08:58 +0100 (CET)
Received: by wyb28 with SMTP id 28so3632886wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 07:08:58 -0800 (PST)
In-Reply-To: <1298903619-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: zhaoming.zeng@freescale.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-28 at 14:33 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/sgtl5000.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index b528f97..b7e97c0 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -124,7 +124,7 @@ static struct regulator_consumer_supply ldo_consumer[] = {
>  	REGULATOR_SUPPLY(LDO_CONSUMER_NAME, NULL),
>  };
>  
> -struct regulator_init_data ldo_init_data = {
> +static struct regulator_init_data ldo_init_data = {
>  	.constraints = {
>  		.min_uV                 = 850000,
>  		.max_uV                 = 1600000,
> @@ -946,7 +946,7 @@ static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
>  			SNDRV_PCM_FMTBIT_S24_LE |\
>  			SNDRV_PCM_FMTBIT_S32_LE)
>  
> -struct snd_soc_dai_ops sgtl5000_ops = {
> +static struct snd_soc_dai_ops sgtl5000_ops = {
>  	.hw_params = sgtl5000_pcm_hw_params,
>  	.digital_mute = sgtl5000_digital_mute,
>  	.set_fmt = sgtl5000_set_dai_fmt,
> @@ -1421,7 +1421,7 @@ static int sgtl5000_remove(struct snd_soc_codec *codec)
>  	return 0;
>  }
>  
> -struct snd_soc_codec_driver sgtl5000_driver = {
> +static struct snd_soc_codec_driver sgtl5000_driver = {
>  	.probe = sgtl5000_probe,
>  	.remove = sgtl5000_remove,
>  	.suspend = sgtl5000_suspend,

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
