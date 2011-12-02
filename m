From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Fri, 2 Dec 2011 15:34:02 +0000
Message-ID: <20111202153401.GX8245@opensource.wolfsonmicro.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 02, 2011 at 06:45:15PM +0900, Tomoya MORINAGA wrote:

> +#define CODEC_DEV_ADDR 0x1A
> +static struct i2c_board_info ioh_hwmon_info[] = {
> +	{I2C_BOARD_INFO("ioh_i2c-0", CODEC_DEV_ADDR + 1)},
> +	{I2C_BOARD_INFO("ioh_i2c-1", CODEC_DEV_ADDR + 2)},
> +	{I2C_BOARD_INFO("ioh_i2c-2", CODEC_DEV_ADDR + 3)},
> +	{I2C_BOARD_INFO("ioh_i2c-3", CODEC_DEV_ADDR + 4)},
> +	{I2C_BOARD_INFO("ioh_i2c-4", CODEC_DEV_ADDR + 5)},
> +	{I2C_BOARD_INFO("ioh_i2c-5", CODEC_DEV_ADDR + 0)},

This looks completely wrong.  I'd not expect to see any I2C_BOARD_INFO
usage at all in a machine driver (that should be done by whatever
enumerates the system as a whole) and I'm not clear what the intended
effect of the above is - the names look like the names of I2C
controllers...

> +static int ml7213_ioh_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +
> +	snd_soc_dapm_new_controls(dapm, ml7213_dapm_widgets,
> +				  ARRAY_SIZE(ml7213_dapm_widgets));
> +
> +	snd_soc_dapm_add_routes(dapm, ml7213_routes, ARRAY_SIZE(ml7213_routes));

Use table based init for these.

> +static int ml7213_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct i2c_client *i2c;
> +	struct i2c_adapter *adapter;
> +
> +	mutex_lock(&codec->mutex);
> +
> +	adapter = i2c_get_adapter(1);
> +	if (!adapter)
> +		return -ENODEV;
> +
> +	i2c = i2c_new_device(adapter, &ioh_hwmon_info[substream->number]);
> +	if (!i2c) {
> +		mutex_unlock(&codec->mutex);
> +		return -1;
> +	}
> +	i2c_put_adapter(adapter);
> +	mutex_unlock(&codec->mutex);

No, this is definitely wrong - we certainly shouldn't be registering new
devices whenever someone starts an audio stream.  I'm struggling to
understand what the intended effect is though.

> +	switch (params_rate(params)) {
> +	case 16000:
> +	case 32000:
> +	case 48000:
> +		clk = 12288800;
> +		break;

You may as well just set the CODEC clock rate once on init() and let the
CODEC driver worry about what it can do with the clock it's got, if the
values aren't going to change there's no need to set them every time.

> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +				SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
> +	if (ret < 0)
> +		return ret;

Use the dai_fmt field in the dai_link to set this.

> +MODULE_AUTHOR("Tomoya MORINAGA <tomoya.rohm@gmail.com>");
> +MODULE_DESCRIPTION("LAPIS Semiconductor ML7213 IOH ALSA SoC machine driver");
> +MODULE_LICENSE("GPL");

Should have MODULE_ALIAS too.
