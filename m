From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v2 1/1] ASoC: TWL4030: Add support Voice DAI
Date: Mon, 20 Apr 2009 14:15:27 +0300
Message-ID: <200904201415.27956.peter.ujfalusi@nokia.com>
References: <49EC4CAF.5090106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EEE3243D0
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 13:15:47 +0200 (CEST)
In-Reply-To: <49EC4CAF.5090106@samsung.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "bhmin@samsung.com" <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Monday 20 April 2009 13:21:35 ext Joonyoung Shim wrote:
> Add Voice DAI to support the PCM voice interface of the twl4030 codec.
>

This does look good.

>
> +	/* clock inversion */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_IB_NF:
> +		format &= ~(TWL4030_VIF_FORMAT);
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		format |= TWL4030_VIF_FORMAT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

I think here it would be better to use:
switch (fmt & (SND_SOC_DAIFMT_FORMAT_MASK |
			 SND_SOC_DAIFMT_INV_MASK)) {
case (SND_SOC_DAIFMT_DSP_A|SND_SOC_DAIFMT_IB_NF):
	format &= ~(TWL4030_VIF_FORMAT);
	break;
case (SND_SOC_DAIFMT_DSP_A|SND_SOC_DAIFMT_NB_IF):
	format |= TWL4030_VIF_FORMAT;
	break;
default:
	return -EINVAL;
}

or:
if ((fm & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_DSP_A)
	/* Only DSP_A mode is supported for the Voice interface */
	return -EINVAL;

Just rule out any misconfiguration attempt and also act like an interface 
documentation on what format is supported in Voice mode

But even without this, I think this patch looks OK,

---
Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
