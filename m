From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/8] sound:asoc: Add support for STA529
	Audio Codec
Date: Fri, 23 Mar 2012 09:12:48 +0530
Message-ID: <4F6BF138.8000705@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
	<20120320152547.GB3445@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
	[207.126.144.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CC44B2415A
	for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2012 04:43:59 +0100 (CET)
In-Reply-To: <20120320152547.GB3445@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, spear-devel <spear-devel@list.st.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark

On 3/20/2012 8:55 PM, Mark Brown wrote:
> On Tue, Mar 20, 2012 at 05:03:45PM +0530, Rajeev Kumar wrote:
>> This patch adds the support for STA529 audio codec.
>> Details of the audio codec can be seen here:
>> http://www.st.com/internet/imag_video/product/159187.jsp
>
> Please use subject lines appropriate for the subsystem.  If your commits
> look visually different to all the other commits in the log that's not a
> good sign.
>

Ok


>> +config SND_SOC_STA529
>> +	tristate
>> +	depends on I2C
>> +
>

Agreed

> Drop the dependency, none of the other CODECs have this for a reason...
>
>> +#include<linux/platform_device.h>
>
> If you need this something went wrong...
>

Oops


>> +static const u8 sta529_reg[STA529_CACHEREGNUM] = {
>
> Use regmap for register I/O.
>

OK

>> +struct sta529 {
>> +	unsigned int sysclk;
>> +	enum snd_soc_control_type control_type;
>> +	void *control_data;
>
> Your device only supports I2C, no need for the infrastructure for other
> buses (though this will go away with regmap).
>

Agreed,

>> +static const char *pwm_mode_text[] = { "binary", "headphone", "ternary",
>> +	"phase-shift"};
>> +static const char *interface_mode_text[] = { "slave", "master"};
>
> ALSA controls always use capitalisation.
>

you mean to say
static const char *interface_mode_text[] = { "SLAVE", "MASTER"}


>> +	case SND_SOC_BIAS_PREPARE:
>> +		snd_soc_update_bits(codec, STA529_FFXCFG0, POWER_CNTLMSAK,
>> +				POWER_UP);
>> +		snd_soc_update_bits(codec, STA529_MISC, 1, 0x01);
>
> One of these has magic numbers and the other doesn't, and the magic
> numbers are a little confusing as the mask is written in decimal but the
> binary in hex.
>

OK I will take mask for this.


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
>
> Return an error on unsupported sample sizes.
>

In default , it is returning an error.

>> +	default:
>> +		printk(KERN_WARNING, "bad rate\n");
>> +		return -EINVAL;
>> +	}
>
> dev_warn() - always use the dev_ prints where possible.
>

Agreed,

>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
>> +	mdelay(10);
>
> Absolutely no - why are you doing this?
>

In probe I am putting codec in standby mode. so to come out of this 
sta529_set_bias_level(codec, SND_SOC_BIAS_PREPARE) is called. Since 
there are some transition time between STANDBY and ON/PREAPRE, so a 
delay is introduced in the code.

>> +static int sta529_mute(struct snd_soc_dai *dai, int mute)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +
>> +	u8 mute_reg = snd_soc_read(codec, STA529_FFXCFG0)&  ~CODEC_MUTE_VAL;
>> +
>> +	if (mute)
>> +		mute_reg |= CODEC_MUTE_VAL;
>> +
>> +	snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, 00);
>
> You're always setting the same value here...
>

Oops, it should be
snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, mute_reg);


>> +	snd_soc_add_controls(codec, sta529_snd_controls,
>> +			ARRAY_SIZE(sta529_snd_controls));
>> +
>> +	snd_soc_add_controls(codec, sta529_new_snd_controls,
>> +			ARRAY_SIZE(sta529_new_snd_controls));
>
> Use the initialisers in the card struct.
>
ok


>> +	sta529 = kzalloc(sizeof(struct sta529), GFP_KERNEL);
>> +	if (sta529 == NULL)
>> +		return -ENOMEM;
>
> devm_kzalloc().

OK

Best Regards
Rajeev

>
>> +static int __init sta529_modinit(void)
>
> module_i2c_driver().
