From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V4 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Mon, 6 Jun 2011 12:38:43 +0530
Message-ID: <4DEC7CFB.60405@st.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<4DEC7275.7010603@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C6B024396
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 09:09:43 +0200 (CEST)
In-Reply-To: <4DEC7275.7010603@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Lars-Peter Clausen 
Please find my answer inline below.

On 6/6/2011 11:53 AM, Lars-Peter Clausen wrote:
> On 06/06/2011 07:57 AM, Rajeev Kumar wrote:
>> This patch adds the support for STA529 audio codec.
>> Details of the audio codec can be seen here:
>> http://www.st.com/internet/imag_video/product/159187.jsp
>>
>> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>> ---
>>  sound/soc/codecs/Kconfig  |    5 +
>>  sound/soc/codecs/Makefile |    2 +
>>  sound/soc/codecs/sta529.c |  374 +++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 381 insertions(+), 0 deletions(-)
>>  create mode 100644 sound/soc/codecs/sta529.c
>>
>> [...]
>> +
>> +struct sta529 {
>> +	unsigned int sysclk;
> sysclk is unused
>> +	enum snd_soc_control_type control_type;
>> +	void *control_data;
> control_data is unused
> 
Oops, will be removed.

>> +};
>> +
>> +static const char *pwm_mode_text[] = { "binary", "headphone", "ternary",
>> +	"phase-shift"};
>> +static const char *interface_mode_text[] = { "slave", "master"};
>> +
>> +static const struct soc_enum pwm_src_enum =
>> +SOC_ENUM_SINGLE(STA529_FFXCFG1, 4, 4, pwm_mode_text);
>> +
>> +static const struct soc_enum mode_src_enum =
>> +SOC_ENUM_SINGLE(STA529_P2SCFG0, 0, 2, interface_mode_text);
>> +
>> +static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
>> +	SOC_ENUM("PWM Select", pwm_src_enum),
>> +	SOC_ENUM("MODE Select", mode_src_enum),
> 
> The mode should be configured by the dai_drivers set_fmt callback, and not by a
> control.
>
I think giving a interface to the user is better option rather than doing it in set_fmt callback.
 
>> +};
>> +
>> +static const DECLARE_TLV_DB_SCALE(out_gain_tlv, -9150, 50, 0);
>> +static const DECLARE_TLV_DB_SCALE(master_vol_tlv, -12750, 50, 0);
>> +
>> +static const struct snd_kcontrol_new sta529_snd_controls[] = {
>> +	SOC_DOUBLE_R_TLV("Digital Playback Volume", STA529_LVOL, STA529_RVOL, 0,
>> +			127, 0, out_gain_tlv),
>> +	SOC_SINGLE_TLV("Master Playback Volume", STA529_MVOL, 0, 127, 1,
>> +			master_vol_tlv),
>> +};
>> +
>> +static int sta529_hw_params(struct snd_pcm_substream *substream,
>> +		struct snd_pcm_hw_params *params,
>> +		struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_codec *codec = rtd->codec;
>> +	int pdata = 0;
>> +
>> +	switch (params_format(params)) {
>> +	case SNDRV_PCM_FORMAT_S16_LE:
>> +		pdata = 1;
>> +		break;
>> +	case SNDRV_PCM_FORMAT_S24_LE:
>> +		pdata = 2;
>> +		break;
>> +	case SNDRV_PCM_FORMAT_S32_LE:
>> +		pdata = 3;
>> +		break;
>> +	}
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +		snd_soc_update_bits(codec, STA529_S2PCFG1, 0xC0, (pdata << 6));
>> +	else
>> +		snd_soc_update_bits(codec, STA529_P2SCFG1, 0xC0, (pdata << 6));
>> +
>> +	return 0;
>> +}
>> +
>> +static int sta529_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
>> +{
>> +	struct snd_soc_codec *codec = codec_dai->codec;
>> +	u8 mode = 0;
>> +
>> +	/* interface format */
>> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> +	case SND_SOC_DAIFMT_LEFT_J:
>> +		mode = LEFT_J_DATA_FORMAT;
>> +		break;
>> +	case SND_SOC_DAIFMT_I2S:
>> +		mode = I2S_DATA_FORMAT;
>> +		break;
>> +	case SND_SOC_DAIFMT_RIGHT_J:
>> +		mode = RIGHT_J_DATA_FORMAT;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +	mode |= 0x20;
>> +	snd_soc_update_bits(codec, STA529_S2PCFG0, 0xE0, mode);
> What about the P2SCFG0 register, I would suspect, that the same data needs to
> be written to it.
>
Yes we need to update this.
 
>> +
>> +	return 0;
>> +}
>> +
>> +static int sta529_mute(struct snd_soc_dai *dai, int mute)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +
>> +	u8 mute_reg = snd_soc_read(codec, STA529_FFXCFG0) & ~CODEC_MUTE_VAL;
>> +
>> +	if (mute)
>> +		mute_reg |= CODEC_MUTE_VAL;
>> +
>> +	snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, 00);
> I guess, it should be mute_reg instead of 00
> 
No, This is value, register is STA529_FFXCFG0

>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +sta529_set_bias_level(struct snd_soc_codec *codec,
>> +		enum snd_soc_bias_level level)
>> +{
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +	case SND_SOC_BIAS_PREPARE:
>> +		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
>> +				POWER_UP);
>> +		snd_soc_update_bits(codec, STA529_MISC, 1, 0x01);
>> +		break;
>> +	case SND_SOC_BIAS_STANDBY:
>> +	case SND_SOC_BIAS_OFF:
>> +		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
>> +				POWER_STDBY);
>> +		/* Making FFX output to zero */
>> +		snd_soc_update_bits(codec, STA529_FFXCFG0, FFX_MASK,
>> +				FFX_OFF);
>> +		snd_soc_update_bits(codec, STA529_MISC, 1, 0x00);
>> +
>> +		break;
>> +	}
>> +
>> +	/*
>> +	 * store the label for powers down audio subsystem for suspend.This is
>> +	 * used by soc core layer
>> +	 */
>> +	codec->dapm.bias_level = level;
>> +	return 0;
>> +
>> +}
>> +
>> +static struct snd_soc_dai_ops sta529_dai_ops = {
> Can be const
It can not be. Please check snd_soc_dai_ops structure in include/sound/soc-dai.h  

>> +	.hw_params	=	sta529_hw_params,
>> +	.set_fmt	=	sta529_set_dai_fmt,
>> +	.digital_mute	=	sta529_mute,
>> +};
>> +
>> [..]
>> +
>> +static int sta529_probe(struct snd_soc_codec *codec)
>> +{
>> +	struct sta529 *sta529 = snd_soc_codec_get_drvdata(codec);
>> +	int ret;
>> +
>> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, sta529->control_type);
> If your codec only supports I2C, you can pass SND_SOC_I2C here directly and get
> rid of the control_type field.
> 
ok

>> +	if (ret < 0) {
>> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
>> +		return ret;
>> +	}
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +
>> +	snd_soc_add_controls(codec, sta529_snd_controls,
>> +			ARRAY_SIZE(sta529_snd_controls));
>> +
>> +	snd_soc_add_controls(codec, sta529_new_snd_controls,
>> +			ARRAY_SIZE(sta529_new_snd_controls));
> You should use table based controls setup. i.e assign the control table to the
> 'controls' field of your codec_driver.
>
You can do it in either way.

 
>> +	return 0;
>> +}
>> +
>> +/* power down chip */
>> +static int sta529_remove(struct snd_soc_codec *codec)
>> +{
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sta529_suspend(struct snd_soc_codec *codec, pm_message_t state)
>> +{
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +
>> +	return 0;
>> +}
>> +
>> +static int sta529_resume(struct snd_soc_codec *codec)
>> +{
>> +	snd_soc_cache_sync(codec);
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +	sta529_set_bias_level(codec, codec->dapm.suspend_bias_level);
>> +
>> +	return 0;
>> +}
>> +
>> +struct snd_soc_codec_driver soc_codec_dev_sta529 = {
>> +	.probe = sta529_probe,
>> +	.remove = sta529_remove,
>> +	.set_bias_level = sta529_set_bias_level,
>> +	.suspend = sta529_suspend,
>> +	.resume = sta529_resume,
>> +	.reg_cache_size = STA529_CACHEREGNUM,
>> +	.reg_word_size = sizeof(u8),
>> +	.reg_cache_default = sta529_reg,
>> +
>> +};
>> +
>> +static __devinit int sta529_i2c_probe(struct i2c_client *i2c,
>> +		const struct i2c_device_id *id)
>> +{
>> +	struct sta529 *sta529;
>> +	int ret;
>> +
>> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>> +		return -EINVAL;
>> +
>> +	sta529 = kzalloc(sizeof(struct sta529), GFP_KERNEL);
>> +	if (sta529 == NULL)
>> +		return -ENOMEM;
>> +
>> +	i2c_set_clientdata(i2c, sta529);
>> +	sta529->control_data = i2c;
>> +	sta529->control_type = SND_SOC_I2C;
>> +
>> +	ret = snd_soc_register_codec(&i2c->dev,
>> +			&soc_codec_dev_sta529, &sta529_dai, 1);
>> +	if (ret < 0)
>> +		kfree(sta529);
>> +	return ret;
>> +}
>> +
>> +static int sta529_i2c_remove(struct i2c_client *client)
> __devexit
>> +{
>> +	snd_soc_unregister_codec(&client->dev);
>> +	kfree(i2c_get_clientdata(client));
>> +	return 0;
>> +}
>> +
>> [...]
> 
> Your driver doesn't use any DAPM. You should at least define input and output
> pins and their routing, but I would expect that there is more that can be done,
> like dynamicly powering unused sections of the codec down, like the DAC or ADC.
> .
>
Right now since my driver has not support for DAPM, so definitions for input and output pins
are not there.Once I will implement DAPM feature in future I will send separate patch for that. 
 
Best Rgds
Rajeev
