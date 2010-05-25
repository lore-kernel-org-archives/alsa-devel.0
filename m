From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/5] cs42l51: add asoc driver
Date: Tue, 25 May 2010 15:51:52 -0700
Message-ID: <20100525225151.GA13890@opensource.wolfsonmicro.com>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.121399024@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 01C7824590
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 00:51:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100525122341.121399024@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 25, 2010 at 02:22:39PM +0200, apatard@mandriva.com wrote:

> +	/* route microphone */
> +	ret = snd_soc_write(codec, CS42L51_ADC_INPUT, 0xF0);
> +	if (ret < 0)
> +		goto error_alloc;

As I said last time this really should be visible to userspace rather
than fixed function in the driver.

> +#define DAPM_EVENT_PRE_POST_PMD	(SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD)

As I said last time this should be in soc-dapm.h rather than in the
driver.

> +	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
> +		CS42L51_POWER_CTL1, 5, 1,
> +		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
> +		CS42L51_POWER_CTL1, 6, 1,
> +		cs42l51_pdn_event, DAPM_EVENT_PRE_POST_PMD),

Your event here uses snd_soc_write() so for a stereo enable/disable
you'll do extra writes.  If you changed it to use snd_soc_update_bits()
then these would be suppressed.

> +	switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		cs42l51->func = MODE_MASTER;
> +		break;
> +	default:
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		cs42l51->func = MODE_SLAVE_AUTO;
> +		break;

Is the device really capable of automatically coping with mixed master
buses automatically, or should the default be to return an error?

> +	dev_info(&pdev->dev, "CS42L51 ALSA SoC Codec\n");

I really would prefer to remove this.

> +struct cs42l51_setup_data {
> +	int i2c_bus;
> +	unsigned short i2c_address;
> +};

This is unused and could be removed.
