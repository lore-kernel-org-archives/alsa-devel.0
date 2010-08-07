From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add SSM2604 codec driver
Date: Sat, 7 Aug 2010 13:44:16 +0100
Message-ID: <20100807124416.GB11817@opensource.wolfsonmicro.com>
References: <1281160447-10393-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F49F2445E
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 14:44:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1281160447-10393-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 07, 2010 at 01:54:07AM -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

This needs to be updated to the multi-component branch.  There's a few
other issues as well.

> +#define SSM2604_VERSION "0.1"

Drop this, just track the version through git and kernel releases.

> +static const struct soc_enum ssm2604_enum[] = {
> +	SOC_ENUM_SINGLE(SSM2604_APDIGI, 1, 4, ssm2604_deemph),
> +};

Use individual variables for enums rather than stuffing them all in an
array.  The arrays are just hard to read and error prone...

> +SOC_ENUM("Capture Source", ssm2604_enum[0]),
> +
> +SOC_ENUM("Playback De-emphasis", ssm2604_enum[1]),

...are you sure this code runs correctly?  I see only one element in the
array.  It's worth checking this in your other drivers as well.

> +	/* The DAI has shared clocks so if we already have a playback or
> +	 * capture going then constrain this substream to match it.
> +	 * TODO: the ssm2604 allows pairs of non-matching PB/REC rates
> +	 */
> +	if (ssm2604->master_substream) {

Set the symmetric_rates flag on the DAI rather than open coding this.

> +	/* deactivate */
> +	if (!codec->active)
> +		snd_soc_write(codec, SSM2604_ACTIVE, 0);

This probably wants to be managed by DAPM (possibly a supply widget for
the DAC and ADC).

> +#define SSM2604_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_32000 |\
> +		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |\
> +		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)

SNDRV_PCM_RATE_8000_96000

> +	snd_soc_write(codec, SSM2604_APANA, APANA_SELECT_DAC);

This could use a little explanation?

> +struct ssm2604_setup_data {
> +	int i2c_bus;
> +	unsigned short i2c_address;
> +};

This is definitely not needed, even with the current code.
