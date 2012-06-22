From: Adam Thomson <Adam.Thomson@diasemi.com>
Subject: Re: [PATCH] ASoC: da732x: Staticise non-exported
	symbol soc_codec_dev_da732x
Date: Fri, 22 Jun 2012 14:26:29 +0100
Message-ID: <201206221327.q5MDRTqX009972@sw-eng-lt-apt-vm1>
References: <1340361378-12192-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.diasemi.com (mailrelay1.diasemi.com [82.210.246.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 74FA110405A
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2012 15:29:48 +0200 (CEST)
In-Reply-To: <1340361378-12192-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Michal Hajduk <Michal.Hajduk@diasemi.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 22, 2012 at 11:36AM, Mark Brown wrote:

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/da732x.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
> index 04af369..01be2a3 100644
> --- a/sound/soc/codecs/da732x.c
> +++ b/sound/soc/codecs/da732x.c
> @@ -1543,7 +1543,7 @@ static int da732x_remove(struct snd_soc_codec *codec)
>  	return 0;
>  }
> 
> -struct snd_soc_codec_driver soc_codec_dev_da732x = {
> +static struct snd_soc_codec_driver soc_codec_dev_da732x = {
>  	.probe			= da732x_probe,
>  	.remove			= da732x_remove,
>  	.set_bias_level		= da732x_set_bias_level,
> --
> 1.7.10

Looks fine.

Acked-by: Adam Thomson <Adam.Thomson@diasemi.com>
