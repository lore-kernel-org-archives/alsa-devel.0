From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
 CS4270 codec driver
Date: Wed, 25 Nov 2009 15:01:39 +0000
Message-ID: <20091125150139.GC636@rakim.wolfsonmicro.main>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C50422438A
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 16:01:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 25, 2009 at 03:36:27PM +0100, Daniel Mack wrote:

> +	struct regulator *va_reg;

This should be three different supplies - there's separate digital and
control supplies, as well as a buffer supply.  Board designs frequently
split the analog and digital supplies.  The regulator API has bulk_
variants intended to make using multiple supplies en masse easier.

>  static int cs4270_dai_mute(struct snd_soc_dai *dai, int mute)
>  {
>  	struct snd_soc_codec *codec = dai->codec;
>  	struct cs4270_private *cs4270 = codec->private_data;
> -	int reg6;
> +	int reg6, err;
>  
>  	reg6 = snd_soc_read(codec, CS4270_MUTE);
>  
>  	if (mute)
>  		reg6 |= CS4270_MUTE_DAC_A | CS4270_MUTE_DAC_B;
>  	else {
> +		if (cs4270->va_reg)
> +			regulator_enable(cs4270->va_reg);
> +

This looks wrong - why is the power being controlled in the mute
function?  If nothing else this is going to break recording since the
CODEC will only be unmuted during playback which means power will be cut
during record.

> +#ifdef CONFIG_REGULATOR
> +	/* get the regulator if there is one read<y for us */
> +	cs4270->va_reg = regulator_get(&pdev->dev, "va");
> +
> +	if (IS_ERR(cs4270->va_reg))
> +		cs4270->va_reg = NULL;
> +#endif

This isn't needed, the regulator API stubs itself out so you can just
unconditionally use it in consumer drivers.  The same applies to the
enable/disable calls, a simple driver like this should never need to
check to see if the API is enabled (this is why you don't need to ifdef
out the calls in the mute function).
