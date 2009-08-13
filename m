From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: TWL4030: Fix for capture
	mixer	strings
Date: Thu, 13 Aug 2009 14:59:58 +0100
Message-ID: <20090813135957.GB31504@sirena.org.uk>
References: <1250168374-24280-1-git-send-email-peter.ujfalusi@nokia.com>
	<1250168374-24280-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EC80E1038B5
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 15:59:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250168374-24280-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 13, 2009 at 03:59:33PM +0300, Peter Ujfalusi wrote:

>  static const struct snd_kcontrol_new twl4030_dapm_analoglmic_controls[] = {
> -	SOC_DAPM_SINGLE("Main mic", TWL4030_REG_ANAMICL, 0, 1, 0),
> -	SOC_DAPM_SINGLE("Headset mic", TWL4030_REG_ANAMICL, 1, 1, 0),
> -	SOC_DAPM_SINGLE("AUXL", TWL4030_REG_ANAMICL, 2, 1, 0),
> -	SOC_DAPM_SINGLE("Carkit mic", TWL4030_REG_ANAMICL, 3, 1, 0),
> +	SOC_DAPM_SINGLE("Main mic Capture Route",
> +			TWL4030_REG_ANAMICL, 0, 1, 0),
> +	SOC_DAPM_SINGLE("Headset mic Capture Route",
> +			TWL4030_REG_ANAMICL, 1, 1, 0),
> +	SOC_DAPM_SINGLE("AUXL Capture Route",
> +			TWL4030_REG_ANAMICL, 2, 1, 0),
> +	SOC_DAPM_SINGLE("Carkit mic Capture Route",
> +			TWL4030_REG_ANAMICL, 3, 1, 0),

These should really be "foo Switch" - a switch is an on/off control.  If
there's a volume control associated with the path then alsamixer will
show the pair as a combined volume/mute control if they have the same
name but with Volume and Switch as the last word.

I'd also spell "mic" "Mic".
