From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix VAG_POWER
	enabling/disabling order
Date: Tue, 28 May 2013 15:59:44 +0100
Message-ID: <20130528145943.GS21462@opensource.wolfsonmicro.com>
References: <1369366496-15329-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB1192610CC
 for <alsa-devel@alsa-project.org>; Tue, 28 May 2013 16:59:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1369366496-15329-1-git-send-email-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 24, 2013 at 05:34:56AM +0200, Marek Vasut wrote:

> -	case SND_SOC_DAPM_POST_PMD:
> +	case SND_SOC_DAPM_PRE_PMD:
>  		snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
>  			SGTL5000_VAG_POWERUP, 0);
> -		msleep(400);
> +		mdelay(400);
>  		break;

This looks to be both unrelated and a regression - mdelay() should be
more resource intensive than sleeping and if it's 400ms we shouldn't be
that worried about delaying slightly longer.

Please note my updated mail address which I've been using for a while
now, the Wolfson one will go bad at the end of the week.
