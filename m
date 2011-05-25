From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: Fix comment in cs4270 codec
	driver
Date: Wed, 25 May 2011 19:12:55 +0800
Message-ID: <20110525111254.GA10797@opensource.wolfsonmicro.com>
References: <1306309992-3624-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0410A10380F
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 13:13:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306309992-3624-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, timur@freescale.com
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, May 25, 2011 at 09:53:12AM +0200, Daniel Mack wrote:
> The comment does not reflect reality anymore since the multi-component
> monster patch landed. Things are matched by names now, and not by
> exporting and referencing a struct. Fix it to avoid confusion.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>

CCing in Timur for his review.

> ---
>  sound/soc/codecs/cs4270.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
> index 0206a17..6cc8678 100644
> --- a/sound/soc/codecs/cs4270.c
> +++ b/sound/soc/codecs/cs4270.c
> @@ -636,10 +636,7 @@ static int cs4270_soc_resume(struct snd_soc_codec *codec)
>  #endif /* CONFIG_PM */
>  
>  /*
> - * ASoC codec device structure
> - *
> - * Assign this variable to the codec_dev field of the machine driver's
> - * snd_soc_device structure.
> + * ASoC codec driver structure
>   */
>  static const struct snd_soc_codec_driver soc_codec_device_cs4270 = {
>  	.probe =		cs4270_probe,
> -- 
> 1.7.5.1
> 
