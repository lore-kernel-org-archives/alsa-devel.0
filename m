From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V4 1/5] sound: asoc: Adding support for
	STA529 Audio Codec
Date: Tue, 7 Jun 2011 11:38:23 +0530
Message-ID: <4DEDC057.9070603@st.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110606115519.GC8286@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B656103870
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 08:09:36 +0200 (CEST)
In-Reply-To: <20110606115519.GC8286@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On 6/6/2011 5:25 PM, Mark Brown wrote:
> On Mon, Jun 06, 2011 at 11:27:32AM +0530, Rajeev Kumar wrote:
>> This patch adds the support for STA529 audio codec.
>> Details of the audio codec can be seen here:
>> http://www.st.com/internet/imag_video/product/159187.jsp
> 
> As I'm fairly sure I've said before please do try to use subject lines
> for your patches which are consistent with the style for the subsystem
> you're submitting against.
> 
Ok,do You mean like, 
ASoC: Add STA529 codec support

>> +struct sta529 {
>> +	unsigned int sysclk;
>> +	enum snd_soc_control_type control_type;
>> +	void *control_data;
> 
> why do you need the control_data here?  You also don't need to pass the
> control_type if the device is I2C only.
> 
Will be removed

>> +static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
>> +	SOC_ENUM("PWM Select", pwm_src_enum),
>> +	SOC_ENUM("MODE Select", mode_src_enum),
> 
> MODE especially should be configured by _dai_fmt().
> 
OK

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
> 
> This update completely ignores the check you've made above...
It should be mute_reg instead of 00

> 
>> +	/*
>> +	 * store the label for powers down audio subsystem for suspend.This is
>> +	 * used by soc core layer
>> +	 */
> 
> You want a space after the period here.
> 
OK

>> +static struct snd_soc_dai_driver sta529_dai = {
>> +	.name = "sta529-audio",
> 
> Does the chip have non-audio funtionality?
>
No, you mean name to be changed to sta529.

 
>> +	snd_soc_add_controls(codec, sta529_snd_controls,
>> +			ARRAY_SIZE(sta529_snd_controls));
>> +
>> +	snd_soc_add_controls(codec, sta529_new_snd_controls,
>> +			ARRAY_SIZE(sta529_new_snd_controls));
> 
> Like Lars-Peter said use data based init here.
>
ok
 
>> +static int sta529_resume(struct snd_soc_codec *codec)
>> +{
>> +	snd_soc_cache_sync(codec);
>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>> +	sta529_set_bias_level(codec, codec->dapm.suspend_bias_level);
> 
> The second set_bias_level() should be redundant - we'll always have been
> shut down by the core before we get to suspending.
> 
sta529_set_bias_level(codec, codec->dapm.suspend_bias_level) is not required


>> +static int __init sta529_modinit(void)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = i2c_add_driver(&sta529_i2c_driver);
>> +	if (ret != 0)
>> +		printk(KERN_ERR "Failed to reg sta529 I2C driver: %d\n", ret);
> 
> Error out if we can't load; ignoring the error only makes sense if we
> have multiple bus types and another might have succeeded.
> .
> 
Sorry I have not got the point.
Best Rgds
Rajeev
