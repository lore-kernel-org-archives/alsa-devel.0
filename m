From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/2] ASoC: wm8940: Convert to direct regmap
	API usage
Date: Sun, 17 Nov 2013 18:27:43 +0000
Message-ID: <52890A9F.6020702@cam.ac.uk>
References: <1383931413-8943-1-git-send-email-broonie@kernel.org>
 <1383931413-8943-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-32.csi.cam.ac.uk (ppsw-32.csi.cam.ac.uk [131.111.8.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 084B826168B
 for <alsa-devel@alsa-project.org>; Sun, 17 Nov 2013 18:26:40 +0100 (CET)
In-Reply-To: <1383931413-8943-2-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/08/13 17:23, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> This helps move us towards being able to remove the ASoC level I/O code.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
Again, looks fine to me but can't test.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  sound/soc/codecs/wm8940.c | 193 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 121 insertions(+), 72 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> index 4858b5c..b404c26 100644
> --- a/sound/soc/codecs/wm8940.c
> +++ b/sound/soc/codecs/wm8940.c
> @@ -28,7 +28,7 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/i2c.h>
> -#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
> @@ -41,78 +41,116 @@
>  
>  struct wm8940_priv {
>  	unsigned int sysclk;
> -	enum snd_soc_control_type control_type;
> +	struct regmap *regmap;
>  };
>  
> -static int wm8940_volatile_register(struct snd_soc_codec *codec,
> -				    unsigned int reg)
> +static bool wm8940_volatile_register(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case WM8940_SOFTRESET:
> -		return 1;
> +		return true;
>  	default:
> -		return 0;
> +		return false;
> +	}
> +}
> +
> +static bool wm8940_readable_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case WM8940_SOFTRESET:
> +	case WM8940_POWER1:
> +	case WM8940_POWER2:
> +	case WM8940_POWER3:
> +	case WM8940_IFACE:
> +	case WM8940_COMPANDINGCTL:
> +	case WM8940_CLOCK:
> +	case WM8940_ADDCNTRL:
> +	case WM8940_GPIO:
> +	case WM8940_CTLINT:
> +	case WM8940_DAC:
> +	case WM8940_DACVOL:
> +	case WM8940_ADC:
> +	case WM8940_ADCVOL:
> +	case WM8940_NOTCH1:
> +	case WM8940_NOTCH2:
> +	case WM8940_NOTCH3:
> +	case WM8940_NOTCH4:
> +	case WM8940_NOTCH5:
> +	case WM8940_NOTCH6:
> +	case WM8940_NOTCH7:
> +	case WM8940_NOTCH8:
> +	case WM8940_DACLIM1:
> +	case WM8940_DACLIM2:
> +	case WM8940_ALC1:
> +	case WM8940_ALC2:
> +	case WM8940_ALC3:
> +	case WM8940_NOISEGATE:
> +	case WM8940_PLLN:
> +	case WM8940_PLLK1:
> +	case WM8940_PLLK2:
> +	case WM8940_PLLK3:
> +	case WM8940_ALC4:
> +	case WM8940_INPUTCTL:
> +	case WM8940_PGAGAIN:
> +	case WM8940_ADCBOOST:
> +	case WM8940_OUTPUTCTL:
> +	case WM8940_SPKMIX:
> +	case WM8940_SPKVOL:
> +	case WM8940_MONOMIX:
> +		return true;
> +	default:
> +		return false;
>  	}
>  }
>  
> -static u16 wm8940_reg_defaults[] = {
> -	0x8940, /* Soft Reset */
> -	0x0000, /* Power 1 */
> -	0x0000, /* Power 2 */
> -	0x0000, /* Power 3 */
> -	0x0010, /* Interface Control */
> -	0x0000, /* Companding Control */
> -	0x0140, /* Clock Control */
> -	0x0000, /* Additional Controls */
> -	0x0000, /* GPIO Control */
> -	0x0002, /* Auto Increment Control */
> -	0x0000, /* DAC Control */
> -	0x00FF, /* DAC Volume */
> -	0,
> -	0,
> -	0x0100, /* ADC Control */
> -	0x00FF, /* ADC Volume */
> -	0x0000, /* Notch Filter 1 Control 1 */
> -	0x0000, /* Notch Filter 1 Control 2 */
> -	0x0000, /* Notch Filter 2 Control 1 */
> -	0x0000, /* Notch Filter 2 Control 2 */
> -	0x0000, /* Notch Filter 3 Control 1 */
> -	0x0000, /* Notch Filter 3 Control 2 */
> -	0x0000, /* Notch Filter 4 Control 1 */
> -	0x0000, /* Notch Filter 4 Control 2 */
> -	0x0032, /* DAC Limit Control 1 */
> -	0x0000, /* DAC Limit Control 2 */
> -	0,
> -	0,
> -	0,
> -	0,
> -	0,
> -	0,
> -	0x0038, /* ALC Control 1 */
> -	0x000B, /* ALC Control 2 */
> -	0x0032, /* ALC Control 3 */
> -	0x0000, /* Noise Gate */
> -	0x0041, /* PLLN */
> -	0x000C, /* PLLK1 */
> -	0x0093, /* PLLK2 */
> -	0x00E9, /* PLLK3 */
> -	0,
> -	0,
> -	0x0030, /* ALC Control 4 */
> -	0,
> -	0x0002, /* Input Control */
> -	0x0050, /* PGA Gain */
> -	0,
> -	0x0002, /* ADC Boost Control */
> -	0,
> -	0x0002, /* Output Control */
> -	0x0000, /* Speaker Mixer Control */
> -	0,
> -	0,
> -	0,
> -	0x0079, /* Speaker Volume */
> -	0,
> -	0x0000, /* Mono Mixer Control */
> +static const struct reg_default wm8940_reg_defaults[] = {
> +	{  0x1, 0x0000 }, /* Power 1 */
> +	{  0x2, 0x0000 }, /* Power 2 */
> +	{  0x3, 0x0000 }, /* Power 3 */
> +	{  0x4, 0x0010 }, /* Interface Control */
> +	{  0x5, 0x0000 }, /* Companding Control */
> +	{  0x6, 0x0140 }, /* Clock Control */
> +	{  0x7, 0x0000 }, /* Additional Controls */
> +	{  0x8, 0x0000 }, /* GPIO Control */
> +	{  0x9, 0x0002 }, /* Auto Increment Control */
> +	{  0xa, 0x0000 }, /* DAC Control */
> +	{  0xb, 0x00FF }, /* DAC Volume */
> +
> +	{  0xe, 0x0100 }, /* ADC Control */
> +	{  0xf, 0x00FF }, /* ADC Volume */
> +	{ 0x10, 0x0000 }, /* Notch Filter 1 Control 1 */
> +	{ 0x11, 0x0000 }, /* Notch Filter 1 Control 2 */
> +	{ 0x12, 0x0000 }, /* Notch Filter 2 Control 1 */
> +	{ 0x13, 0x0000 }, /* Notch Filter 2 Control 2 */
> +	{ 0x14, 0x0000 }, /* Notch Filter 3 Control 1 */
> +	{ 0x15, 0x0000 }, /* Notch Filter 3 Control 2 */
> +	{ 0x16, 0x0000 }, /* Notch Filter 4 Control 1 */
> +	{ 0x17, 0x0000 }, /* Notch Filter 4 Control 2 */
> +	{ 0x18, 0x0032 }, /* DAC Limit Control 1 */
> +	{ 0x19, 0x0000 }, /* DAC Limit Control 2 */
> +
> +	{ 0x20, 0x0038 }, /* ALC Control 1 */
> +	{ 0x21, 0x000B }, /* ALC Control 2 */
> +	{ 0x22, 0x0032 }, /* ALC Control 3 */
> +	{ 0x23, 0x0000 }, /* Noise Gate */
> +	{ 0x24, 0x0041 }, /* PLLN */
> +	{ 0x25, 0x000C }, /* PLLK1 */
> +	{ 0x26, 0x0093 }, /* PLLK2 */
> +	{ 0x27, 0x00E9 }, /* PLLK3 */
> +
> +	{ 0x2a, 0x0030 }, /* ALC Control 4 */
> +
> +	{ 0x2c, 0x0002 }, /* Input Control */
> +	{ 0x2d, 0x0050 }, /* PGA Gain */
> +
> +	{ 0x2f, 0x0002 }, /* ADC Boost Control */
> +
> +	{ 0x31, 0x0002 }, /* Output Control */
> +	{ 0x32, 0x0000 }, /* Speaker Mixer Control */
> +
> +	{ 0x36, 0x0079 }, /* Speaker Volume */
> +
> +	{ 0x38, 0x0000 }, /* Mono Mixer Control */
>  };
>  
>  static const char *wm8940_companding[] = { "Off", "NC", "u-law", "A-law" };
> @@ -431,6 +469,7 @@ static int wm8940_mute(struct snd_soc_dai *dai, int mute)
>  static int wm8940_set_bias_level(struct snd_soc_codec *codec,
>  				 enum snd_soc_bias_level level)
>  {
> +	struct wm8940_priv *wm8940 = snd_soc_codec_get_drvdata(codec);
>  	u16 val;
>  	u16 pwr_reg = snd_soc_read(codec, WM8940_POWER1) & 0x1F0;
>  	int ret = 0;
> @@ -454,7 +493,7 @@ static int wm8940_set_bias_level(struct snd_soc_codec *codec,
>  		break;
>  	case SND_SOC_BIAS_STANDBY:
>  		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
> -			ret = snd_soc_cache_sync(codec);
> +			ret = regcache_sync(wm8940->regmap);
>  			if (ret < 0) {
>  				dev_err(codec->dev, "Failed to sync cache: %d\n", ret);
>  				return ret;
> @@ -669,12 +708,11 @@ static int wm8940_resume(struct snd_soc_codec *codec)
>  
>  static int wm8940_probe(struct snd_soc_codec *codec)
>  {
> -	struct wm8940_priv *wm8940 = snd_soc_codec_get_drvdata(codec);
>  	struct wm8940_setup_data *pdata = codec->dev->platform_data;
>  	int ret;
>  	u16 reg;
>  
> -	ret = snd_soc_codec_set_cache_io(codec, 8, 16, wm8940->control_type);
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
>  	if (ret < 0) {
>  		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
>  		return ret;
> @@ -722,10 +760,18 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8940 = {
>  	.num_dapm_widgets = ARRAY_SIZE(wm8940_dapm_widgets),
>  	.dapm_routes =  wm8940_dapm_routes,
>  	.num_dapm_routes = ARRAY_SIZE(wm8940_dapm_routes),
> -	.reg_cache_size = ARRAY_SIZE(wm8940_reg_defaults),
> -	.reg_word_size = sizeof(u16),
> -	.reg_cache_default = wm8940_reg_defaults,
> -	.volatile_register = wm8940_volatile_register,
> +};
> +
> +static const struct regmap_config wm8940_regmap = {
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +
> +	.max_register = WM8940_MONOMIX,
> +	.reg_defaults = wm8940_reg_defaults,
> +	.num_reg_defaults = ARRAY_SIZE(wm8940_reg_defaults),
> +
> +	.readable_reg = wm8940_readable_register,
> +	.volatile_reg = wm8940_volatile_register,
>  };
>  
>  static int wm8940_i2c_probe(struct i2c_client *i2c,
> @@ -739,8 +785,11 @@ static int wm8940_i2c_probe(struct i2c_client *i2c,
>  	if (wm8940 == NULL)
>  		return -ENOMEM;
>  
> +	wm8940->regmap = devm_regmap_init_i2c(i2c, &wm8940_regmap);
> +	if (IS_ERR(wm8940->regmap))
> +		return PTR_ERR(wm8940->regmap);
> +
>  	i2c_set_clientdata(i2c, wm8940);
> -	wm8940->control_type = SND_SOC_I2C;
>  
>  	ret = snd_soc_register_codec(&i2c->dev,
>  			&soc_codec_dev_wm8940, &wm8940_dai, 1);
> 
