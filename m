From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 1/2] ASoC: TWL4030: AIF/APLL fix in DAPM
	domain
Date: Wed, 28 Apr 2010 14:12:35 +0100
Message-ID: <20100428131235.GH31400@opensource.wolfsonmicro.com>
References: <1272459015-22789-1-git-send-email-peter.ujfalusi@nokia.com>
	<1272459015-22789-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0160F10383D
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 15:12:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1272459015-22789-2-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 28, 2010 at 03:50:14PM +0300, Peter Ujfalusi wrote:

> +	if (enable && twl4030->apll_enabled == 1)
>  		/* Enable PLL */
>  		status = twl4030_codec_enable_resource(TWL4030_CODEC_RES_APLL);
> -	else
> +	else if (!enable && twl4030->apll_enabled == 0)

This logic looks funny, especially the test for !enable in the second
case (which should always be true).  I think the intention here is to
look for "apll_enabled has done an interesting transition (0->1 or
1->0)" - it'd probably be clearer to look for that directly.

> +	/* AIF and APLL clocks for running DAIs (including loopback) */
> +	SND_SOC_DAPM_OUTPUT("AIF DAC"),
> +	SND_SOC_DAPM_INPUT("AIF ADC"),
> +	SND_SOC_DAPM_OUTPUT("APLL"),

The use of INPUT and OUTPUT widgets here looks really odd - I'd at least
except the AIF widgets to be actual AIF widgets.
