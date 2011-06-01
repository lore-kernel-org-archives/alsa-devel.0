From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Staticize ak4641_dai
Date: Wed, 1 Jun 2011 17:11:31 +0100
Message-ID: <4DE664B3.1050201@ti.com>
References: <1306919524-6434-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A5379103828
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 18:11:40 +0200 (CEST)
In-Reply-To: <1306919524-6434-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 01/06/11 10:12, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/ak4641.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
> index ed96f247c..7a64e58 100644
> --- a/sound/soc/codecs/ak4641.c
> +++ b/sound/soc/codecs/ak4641.c
> @@ -457,7 +457,7 @@ static struct snd_soc_dai_ops ak4641_pcm_dai_ops = {
>  	.set_sysclk   = ak4641_set_dai_sysclk,
>  };
>  
> -struct snd_soc_dai_driver ak4641_dai[] = {
> +static struct snd_soc_dai_driver ak4641_dai[] = {
>  {
>  	.name = "ak4641-hifi",
>  	.id = 1,

Acked-by: Liam Girdwood <lrg@ti.com>
