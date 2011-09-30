From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: Add support for cs42l73 codec
Date: Fri, 30 Sep 2011 20:50:38 +0200
Message-ID: <4E860F7E.909@metafoo.de>
References: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-011.synserver.de (smtp-out-012.synserver.de
	[212.40.185.12]) by alsa0.perex.cz (Postfix) with SMTP id 0DD1D1037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 20:51:10 +0200 (CEST)
In-Reply-To: <1317400912-5789-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: heelrod@heelrod.ad.cirrus.com
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, vinod.koul@linux.intel.com, joe@nucleusys.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 09/30/2011 06:41 PM, Brian Austin wrote:
> This patch adds support for the Cirrus Logic CS42L73
> low power stereo codec.
> 
> This patch has cleared checkpatch.pl with no warnings or errors.
> Code changes requested were implemented.
> ASoC API changes requested were implemented.
> 
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
> ---
> [...]
> +struct  cs42l73_private {

extra space

> [...]
> +
> +static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
> +	{"HPOUTA", NULL, "HP Amp Left"},
> +	{"HPOUTB", NULL, "HP Amp Right"},
> +	{"LINEOUTA", NULL, "LO Amp Left"},
> +	{"LINEOUTB", NULL, "LO Amp Right"},
> +	{"SPKOUT", NULL, "SPK Amp"},
> +	{"EAROUT", NULL, "EAR Amp"},
> +	{"SPKLINEOUT", NULL, "SPKLO Amp"},
> +
> +	{"HP Amp Left", "DAC", "DAC Left"},
> +	{"HP Amp Right", "DAC", "DAC Right"},
> +	{"LO Amp Left", "DAC", "DAC Left"},
> +	{"LO Amp Right", "DAC", "DAC Right"},
> +	{"SPK Amp", "DAC", "DAC Left"},
> +	{"SPKLO Amp", "DAC", "DAC Right"},
> +	{"EAR Amp", "DAC", "DAC Right"},

I suppose this won't work as expected. The control element of the path will
only have an effect if the sink is a mixer or a mux.

> +
> +	{"PGA Mux Left", NULL, "LINEINA"},
> +	{"PGA Mux Right", NULL, "LINEINB"},
> +	{"PGA Mux Left", NULL, "MIC1"},
> +	{"PGA Mux Right", NULL, "MIC2"},

You probably want connect the inputs of the mux depending on its setting.

e.g. {"PGA Mux Left", "Line A", "LINEINA"},

[...]
> +
> +struct cs42l73_mclk_div cs42l73_mclk_coeffs[] = {

static

> [...]
> +
> +struct cs42l73_mclkx_div cs42l73_mclkx_coeffs[] = {

static

> [...]
> +int cs42l73_get_mclkx_coeff(int mclkx)

static

> [...]
> +int cs42l73_get_mclk_coeff(int mclk, int srate)

static


> +
> +static int cs42l73_set_mclk(struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	int mclkx_coeff;
> +	u32 mclk = 0;
> +	u8 dmmcc = 0;
> +
> +	/* MCLKX -> MCLK */
> +	mclkx_coeff = cs42l73_get_mclkx_coeff(priv->sysclk);
> +

here you use priv->sysclk ...

> +
> +static int cs42l73_set_sysclk(struct snd_soc_dai *dai,
> +			      int clk_id, unsigned int freq, int dir)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	if (clk_id != CS42L73_CLKID_MCLK1 && clk_id != CS42L73_CLKID_MCLK2) {
> +		dev_err(codec->dev, "Invalid clk_id %u\n", clk_id);
> +		return -EINVAL;
> +	}
> +
> +	if ((cs42l73_get_mclkx_coeff(freq) < 0)) {
> +		dev_err(codec->dev, "Invalid sysclk %u\n", freq);
> +		return -EINVAL;
> +	}
> +
> +	if ((cs42l73_set_mclk(dai)) < 0) {
> +		dev_err(codec->dev, "Unable to set MCLK for dai %s\n",
> +			dai->name);
> +		return -EINVAL;
> +	}
> +
> +	priv->sysclk = freq;
> +	priv->mclksel = clk_id;
> +

... but here you only set it after having called cs42l73_set_mclk. Is this
correct? Maybe pass it in as a parameter to cs42l73_set_mclk

> +	return 0;
> +}
> +
> +static int cs42l73_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	struct cs42l73_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int id = codec_dai->id;
> +	int inv, format;

unsigned int

> +	u8 spc, mmcc;
> +
>[...]
> +

> +static int cs42l73_set_bias_level(struct snd_soc_codec *codec,
> +				  enum snd_soc_bias_level level)
> +{
> +	int ret;
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		snd_soc_update_bits(codec, CS42L73_DMMCC, MCLKDIS, 0);
> +		snd_soc_update_bits(codec, CS42L73_PWRCTL1, PDN, 0);
> +		break;
> +
> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +
> +	case SND_SOC_BIAS_STANDBY:
> +		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
> +				ret = snd_soc_cache_sync(codec);

indention

> [...]
> +
> +static struct snd_soc_dai_ops cs42l73_ops = {

const

> +	.startup = cs42l73_pcm_startup,
> +	.hw_params = cs42l73_pcm_hw_params,
> +	.set_fmt = cs42l73_set_dai_fmt,
> +	.set_sysclk = cs42l73_set_sysclk,
> +	.set_tristate = cs42l73_set_tristate,
> +};
> +
> +struct snd_soc_dai_driver cs42l73_dai[] = {

static

> +	{
> +	 .name = "cs42l73-xsp",
> +	 .id = CS42L73_XSP,
> +	 .playback = {
> +		      .stream_name = "XSP Playback",
> +		      .channels_min = 1,
> +		      .channels_max = 2,
> +		      .rates = CS42L73_RATES,
> +		      .formats = CS42L73_FORMATS,},
> +
> +	 .capture = {
> +		     .stream_name = "XSP Capture",
> +		     .channels_min = 1,
> +		     .channels_max = 2,
> +		     .rates = CS42L73_RATES,
> +		     .formats = CS42L73_FORMATS,},
> +
> +	 .ops = &cs42l73_ops,
> +	 .symmetric_rates = 1,
> +	 },

Indention looks a bit odd here

> [...]
> +static int cs42l73_probe(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +	unsigned int devid = 0;
> +	struct cs42l73_private *cs42l73 = snd_soc_codec_get_drvdata(codec);
> +
> +	codec->control_data = cs42l73->control_data;
> +	codec->hw_write = (hw_write_t)i2c_master_send;

You don't need to initialize control_data and hw_write.
snd_soc_codec_set_cache_io will do this for you. This also means that you can
remove the control_data field from your driver private data struct.

> +
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, cs42l73->control_type);

If you CODEC only has a I2C interface you can use SND_SOC_I2C here directly
instead of cs42l73->control_type

> [...]
> +
> +	snd_soc_add_controls(codec, cs42l73_snd_controls,
> +			     ARRAY_SIZE(cs42l73_snd_controls));

Just put the controls in your codec driver struct instead of manually adding them.

> +
> +	return ret;
> +}
> +
> +static int cs42l73_remove(struct snd_soc_codec *codec)
> +{
> +	cs42l73_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}
> +
> +struct snd_soc_codec_driver soc_codec_dev_cs42l73 = {

static

> +	.probe = cs42l73_probe,
> +	.remove = cs42l73_remove,
> +	.suspend = cs42l73_suspend,
> +	.resume = cs42l73_resume,
> +	.set_bias_level = cs42l73_set_bias_level,
> +	.reg_cache_size = ARRAY_SIZE(cs42l73_reg),
> +	.reg_cache_default = cs42l73_reg,
> +	.reg_word_size = sizeof(u8),
> +	.dapm_widgets = cs42l73_dapm_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(cs42l73_dapm_widgets),
> +	.dapm_routes = cs42l73_audio_map,
> +	.num_dapm_routes = ARRAY_SIZE(cs42l73_audio_map),
> +};
> +
