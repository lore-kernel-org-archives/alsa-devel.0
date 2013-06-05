From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: dapm: Treat DAI widgets like AIF
	widgets for power
Date: Wed, 05 Jun 2013 14:44:12 -0600
Message-ID: <51AFA31C.3000602@wwwdotorg.org>
References: <1370457440-27867-1-git-send-email-broonie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EE502654B0
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 22:44:16 +0200 (CEST)
In-Reply-To: <1370457440-27867-1-git-send-email-broonie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@linaro.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/05/2013 12:37 PM, Mark Brown wrote:
> Even though they are virtual widgets DAI widgets still get counted for the
> DAPM context power management so we can't just use the active state to
> check if they should be powered as they may not be part of a complete path.
> 
> Instead split them into input and output widgets and do the same power
> checks as we perform on AIFs.

> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c

> @@ -3428,8 +3421,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
>  
>  	/* For each DAI widget... */
>  	list_for_each_entry(dai_w, &card->widgets, list) {
> -		if (dai_w->id != snd_soc_dapm_dai)
> +		switch (w->id) {

That should be dai_w->id not w->id.

With that fixed,
Tested-by: Stephen Warren <swarren@nvidia.com>

I tested two things:

1) General audio playback in next-20130605, for regressions. System
suspend wasn't tested since it doesn't work there on Tegra yet.

2) System suspend, in a kernel based on v3.8, with this patch replacing
my previous "ASoC: dapm: check suspend state in dapm_dai_check_power()".

Thanks!
