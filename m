From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] sound: asoc: Adding support for STA529
	Audio Codec
Date: Thu, 17 Mar 2011 15:17:43 +0000
Message-ID: <20110317151743.GH31411@opensource.wolfsonmicro.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-3-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F06F2440B
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 16:17:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1300361016-26242-3-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 17, 2011 at 04:53:36PM +0530, Rajeev Kumar wrote:

> +#define STA529_VERSION "0.1"
> +static const u8 sta529_reg[STA529_CACHEREGNUM] = {

Remove the version number, the kernel version should be good enough.
Also check the vertical spacing in your code - there should be a blank
between the above two.

> +/* reading from register cache: sta529 register value */
> +static inline unsigned int
> +sta529_read_reg_cache(struct snd_soc_codec *codec, u32 reg)

Use the generic register cache code - this looks to be a very 8 bit data
8 bit address map.

> +	val = sta529_read_reg_cache(codec, STA529_S2PCFG0);
> +	val |= mode;
> +	/*this setting will be used with actual h/w */
> +	sta529_write(codec, STA529_S2PCFG0, val);

Use snd_soc_update_bits() - this will fix the issue you currently have
where you'll never clear bits which were previously set.

> +spear_sta_set_dai_sysclk(struct snd_soc_dai *codec_dai, int clk_id,
> +		unsigned int freq, int dir)
> +{
> +	int ret = -EINVAL;
> +	struct clk *clk;
> +
> +	clk = clk_get_sys(NULL, "i2s_ref_clk");
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		goto err_clk;
> +	}
> +	if (clk_set_rate(clk, freq))
> +		goto err_put_clk;

Your CODEC driver shouldn't be requesting clocks that are part of the
CPU.  Just let the machine driver tell you what the clock rate is and
let it worry about making sure the clock is actually there.

> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	u8 mute_reg = sta529_read_reg_cache(codec, STA529_FFXCFG0) &
> +		~CODEC_MUTE_VAL;
> +
> +	if (mute)
> +		mute_reg |= CODEC_MUTE_VAL;
> +
> +	sta529_write(codec, STA529_FFXCFG0, mute_reg);

snd_soc_update_bits().

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +		sta529_write(codec, STA529_FFXCFG0, sts & POWER_STBY);
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +	case SND_SOC_BIAS_OFF:
> +		sta529_write(codec, STA529_FFXCFG0, sts | ~POWER_STBY);
> +
> +		break;

Odd indentation here too.

> +	dev_info(codec->dev, "spear Audio Codec %s", STA529_VERSION);

Remove this - if you were reading something like the chip revision from
the device announcing that would be fine.

> +	cache = codec->reg_cache;
> +	for (i = 0; i < ARRAY_SIZE(sta529_reg); i++) {
> +		data[0] = i;
> +		data[1] = cache[i];
> +		codec->hw_write(codec->control_data, data, NUM_OF_MSG);
> +	}

You should be using the chip defaults for the most part and therefore
should have no reason to write back to hardware in probe()

> +		.name = "sta529-codec",

Drop the -codec.

> +#define SPEAR_PCM_RATES		SNDRV_PCM_RATE_48000
> +#define SPEAR_PCM_FORMAT	SNDRV_PCM_FMTBIT_S16_LE

These are for your CPU not for your CODEC, even if they're the same they
should have different names.

> +#define	S2PC_VALUE		0x98
> +#define CLOCK_OUT		0x60
> +#define LEFT_J_DATA_FORMAT	0x00
> +#define I2S_DATA_FORMAT		0x02
> +#define RIGHT_J_DATA_FORMAT	0x04
> +#define RIGHT_J_DATA_FORMAT	0x04
> +#define CODEC_MUTE_VAL		0x80
> +#define NUM_OF_MSG		2
> +#define POWER_STBY		0xBF

All these should be namespaced or moved into the driver.
