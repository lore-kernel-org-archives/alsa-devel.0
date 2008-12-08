From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/8] ASoC: TWL4030: Add Analog PGA control
	switch to DAPM
Date: Mon, 8 Dec 2008 11:23:37 +0000
Message-ID: <20081208112336.GC5159@sirena.org.uk>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F71810382F
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 12:23:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2008 at 10:09:02AM +0200, Peter Ujfalusi wrote:

> +	/* Analog PGAs
> +	 * bit 0: APGA enable
> +	 * bit 1: Digital to analog path enable
> +	 */
> +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXR1_APGA",
> +			TWL4030_REG_ARXR1_APGA_CTL, 0, 0x3, 0x3, 0x0),
> +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXL1_APGA",
> +			TWL4030_REG_ARXL1_APGA_CTL, 0, 0x3, 0x3, 0x0),
> +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXR2_APGA",
> +			TWL4030_REG_ARXR2_APGA_CTL, 0, 0x3, 0x3, 0x0),
> +	SND_SOC_DAPM_REG(snd_soc_dapm_pga, "ARXL2_APGA",
> +			TWL4030_REG_ARXL2_APGA_CTL, 0, 0x3, 0x3, 0x0),
> +

The PGA should be standard SND_SOC_DAPM_PGA()s with the digital to
analogue switches used to implement mute controls for them.
