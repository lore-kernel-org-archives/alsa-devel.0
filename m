From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
	STA529 Audio Codec
Date: Wed, 20 Apr 2011 09:54:47 +0530
Message-ID: <4DAE600F.4010405@st.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110411145621.GA26769@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 041A824457
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 06:29:19 +0200 (CEST)
In-Reply-To: <20110411145621.GA26769@opensource.wolfsonmicro.com>
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
 please find my answer below.

On 4/11/2011 8:26 PM, Mark Brown wrote:
> On Mon, Apr 11, 2011 at 11:00:00AM +0530, Rajeev Kumar wrote:
> 
>> +static const char *op_mode_text[] = { "slave", "master"};
> 
> What is op_mode?  This sounds like it should be configured by
> set_dai_fmt()...
> 
OK, I will change the name.

>> +static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
>> +	SOC_ENUM("pwm select", pwm_src_enum),
>> +	SOC_ENUM("mode select", mode_src_enum),
>> +};
> 
> ALSA control names are idiomatically things like "PWM Select" with
> capitalisation.
>
Using PWM Select
 
>> +	/*store the label for powers down audio subsystem for suspend.This is
>> +	 ** used by soc core layer*/
>> +	codec->bias_level = level;
> 
> The formatting of this comment isn't terribly idiomatic.
> 
OK

>> +static int sta529_probe(struct snd_soc_codec *codec)
>> +{
>> +	struct sta529 *sta529 = snd_soc_codec_get_drvdata(codec);
>> +	int ret;
>> +
>> +	codec->hw_write = (hw_write_t)i2c_master_send;
>> +	codec->hw_read = NULL;
>> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, sta529->control_type);
>> +	if (ret < 0) {
>> +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
>> +		return ret;
>> +	}
> 
> You shouldn't need to be assigning the I/O functions if you set the
> control type.  If the device only supports I2C that can just be hard
> coded.
>
explained below.
 
>> +static int sta529_resume(struct snd_soc_codec *codec)
>> +{
>> +	int i;
>> +	u8 data[2];
>> +	u8 *cache = codec->reg_cache;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(sta529_reg); i++) {
>> +		data[0] = i;
>> +		data[1] = cache[i];
>> +		codec->hw_write(codec->control_data, data, 2);
>> +	}
> 
> It looks like you can use the standard cache sync implementation here?
> snd_soc_cache_sync().
> .
> 
This patch set has been compiled and tested for Linux-kernel-version 2.6.38-rc4,
since SPEAr patches for this linux version are already under review in Russel King's
ARM branch.This version does not have snd_soc_cache_sync() function. 

We plan to start porting the SPEAr patches on latest kernel after the earlier SPEAr patches
are ACKED. After the same, I will circulate the next SPEAr ASoC patch set containing changes
specific to this new kernel version.

Best Rgds
Rajeev
