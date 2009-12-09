From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Add FSI-DA7210 sound support for
	SuperH
Date: Wed, 9 Dec 2009 11:32:05 +0000
Message-ID: <20091209113205.GI19851@opensource.wolfsonmicro.com>
References: <u3a3kx3gu.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 372D0103800
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:32:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <u3a3kx3gu.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Magnus <magnus.damm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 11:53:37AM +0900, Kuninori Morimoto wrote:

> +static int fsi_da7210_init(struct snd_soc_codec *codec)
> +{
> +	return snd_soc_dai_set_fmt(&da7210_dai,
> +				   SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +				   SND_SOC_DAIFMT_CBM_CFM);
> +
> +	/* Use this function to add machine dapm controls */
> +	return 0;
> +}

The second return statement can be removed - I suspect some compiler
versions will warn about unreachable code there.

> +#define DA7210_BUS 0
> +#define DA7210_ADR (0x34 >> 1)
> +static int da7210_add_i2c_device(void)
> +{

This should be being done by the arch code rather than here, and there's
no code to remove the device on shutdown.  This idiom has been used by
some drivers as part of a transition from the old style ASoC stuff where
the I2C device was registered in the CODEC to reduce cross tree issues
but it's best to avoid it for new code.
