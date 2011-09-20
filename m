From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: ssm2602: Do not dereference
	codec->control_data
Date: Tue, 20 Sep 2011 12:20:34 +0100
Message-ID: <1316517634.8314.3.camel@odin>
References: <1316499598-31539-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69])
	by alsa0.perex.cz (Postfix) with ESMTP id DC86C1039B0
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 13:20:44 +0200 (CEST)
Received: by wyh15 with SMTP id 15so529421wyh.13
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 04:20:42 -0700 (PDT)
In-Reply-To: <1316499598-31539-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-20 at 08:19 +0200, Lars-Peter Clausen wrote:
> The driver assumes that control_data points to the drivers i2c_client struct,
> but this is no longer the case since the ASoC core has switched to regmap.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/codecs/ssm2602.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
> index 84f4ad5..cceb002 100644
> --- a/sound/soc/codecs/ssm2602.c
> +++ b/sound/soc/codecs/ssm2602.c
> @@ -294,7 +294,6 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_codec *codec = rtd->codec;
>  	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
> -	struct i2c_client *i2c = codec->control_data;
>  	struct snd_pcm_runtime *master_runtime;
>  
>  	/* The DAI has shared clocks so if we already have a playback or
> @@ -303,7 +302,7 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
>  	 */
>  	if (ssm2602->master_substream) {
>  		master_runtime = ssm2602->master_substream->runtime;
> -		dev_dbg(&i2c->dev, "Constraining to %d bits at %dHz\n",
> +		dev_dbg(codec->dev, "Constraining to %d bits at %dHz\n",
>  			master_runtime->sample_bits,
>  			master_runtime->rate);
>  

Acked-by: Liam Girdwood <lrg@ti.com>
