From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ASoC: atmel-classd: sync regcache when
	resuming
Date: Mon, 15 May 2017 11:46:23 +0200
Message-ID: <20170515094623.sumkphak4g3cuj3j@piout.net>
References: <20170515083617.16742-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id F1707266587
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:46:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170515083617.16742-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: thomas.petazzoni@free-electrons.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 15/05/2017 at 10:36:17 +0200, Quentin Schulz wrote:
> The PM functions used in this driver are the ones defined in
> sounc/soc/soc-core.c.
> 
> When suspending (using snd_soc_suspend), the regcache is marked dirty
> but is never synced on resume.
> 
> Sync regcache on resume of Atmel ClassD device.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  sound/soc/atmel/atmel-classd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
> index 7ae46c2647d4..b7ef8c59b49a 100644
> --- a/sound/soc/atmel/atmel-classd.c
> +++ b/sound/soc/atmel/atmel-classd.c
> @@ -301,6 +301,14 @@ static int atmel_classd_codec_probe(struct snd_soc_codec *codec)
>  	return 0;
>  }
>  
> +static int atmel_classd_codec_resume(struct snd_soc_codec *codec)
> +{
> +	struct snd_soc_card *card = snd_soc_codec_get_drvdata(codec);
> +	struct atmel_classd *dd = snd_soc_card_get_drvdata(card);
> +
> +	return regcache_sync(dd->regmap);
> +}
> +
>  static struct regmap *atmel_classd_codec_get_remap(struct device *dev)
>  {
>  	return dev_get_regmap(dev, NULL);
> @@ -308,6 +316,7 @@ static struct regmap *atmel_classd_codec_get_remap(struct device *dev)
>  
>  static struct snd_soc_codec_driver soc_codec_dev_classd = {
>  	.probe		= atmel_classd_codec_probe,
> +	.resume		= atmel_classd_codec_resume,
>  	.get_regmap	= atmel_classd_codec_get_remap,
>  	.component_driver = {
>  		.controls		= atmel_classd_snd_controls,
> -- 
> 2.11.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
