From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Fix dai usage in pcm_new()
	platform handlers
Date: Wed, 22 Jun 2011 19:10:23 +0100
Message-ID: <20110622181023.GA18574@opensource.wolfsonmicro.com>
References: <1308765929-14482-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53E5F2482D
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 20:10:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308765929-14482-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 08:05:29PM +0200, Daniel Mack wrote:
> Commit 552d1ef ("ASoC: core - Optimise and refactor pcm_new() to pass
> only rtd") refactored the ASoC internal core to only pass a pointer
> to a runtime as argument to individual pcm_new() functions. However, the
> new code that was added to the handlers to get access to the dai now
> uses rtd->cpu_dai, while before this patch, rtd->codec_dai was used.

Which is a problem because...

> diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
> index f81d4c3..d1140c1 100644
> --- a/sound/soc/atmel/atmel-pcm.c
> +++ b/sound/soc/atmel/atmel-pcm.c
> @@ -367,7 +367,7 @@ static u64 atmel_pcm_dmamask = 0xffffffff;
>  static int atmel_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_card *card = rtd->card->snd_card;
> -	struct snd_soc_dai *dai = rtd->cpu_dai;
> +	struct snd_soc_dai *dai = rtd->codec_dai;
>  	struct snd_pcm *pcm = rtd->pcm;
>  	int ret = 0;
>  

The original code doesn't look obviously wrong while if the CPU driver
is peering at the CODEC driver that smells very bad.  What's the actual
problem here?
