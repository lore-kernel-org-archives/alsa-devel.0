From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 1/8] sound:asoc: Add support for STA529
 Audio Codec
Date: Fri, 23 Mar 2012 14:50:54 +0530
Message-ID: <4F6C4076.2000901@st.com>
References: <cover.1332242166.git.rajeev-dlh.kumar@st.com>
	<a5a4d4490442b863f6ef916f74f068e2303b382b.1332242166.git.rajeev-dlh.kumar@st.com>
	<20120320152547.GB3445@opensource.wolfsonmicro.com>
	<4F6BF138.8000705@st.com> <4F6C3D5C.8050509@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog113.obsmtp.com (eu1sys200aog113.obsmtp.com
	[207.126.144.135])
	by alsa0.perex.cz (Postfix) with ESMTP id BD6A9103F5E
	for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2012 10:42:05 +0100 (CET)
In-Reply-To: <4F6C3D5C.8050509@metafoo.de>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, spear-devel <spear-devel@list.st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Clausen,

On 3/23/2012 2:37 PM, Lars-Peter Clausen wrote:
>
>>>> +static const char *pwm_mode_text[] = { "binary", "headphone", "ternary",
>>>> +	"phase-shift"};
>>>> +static const char *interface_mode_text[] = { "slave", "master"};
>>>
>>> ALSA controls always use capitalisation.
>>>
>>
>> you mean to say
>> static const char *interface_mode_text[] = { "SLAVE", "MASTER"}
>>
>
> No, only the first letter upper case.
>
>>
>>>> +	sta529_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
>>>> +	mdelay(10);
>>>
>>> Absolutely no - why are you doing this?
>>>
>>
>> In probe I am putting codec in standby mode. so to come out of this
>> sta529_set_bias_level(codec, SND_SOC_BIAS_PREPARE) is called. Since
>> there are some transition time between STANDBY and ON/PREAPRE, so a
>> delay is introduced in the code.
>

Actually I was hoping for the same but not able to locate the code.
Ok, I will made the changes.

> The framework will take care of taking the CODEC out of standby mode when it
> is required, so you shouldn't need it here. Also, if the delay is required
> put it into the set_bias_level function.
>
>>
>>>> +static int sta529_mute(struct snd_soc_dai *dai, int mute)
>>>> +{
>>>> +	struct snd_soc_codec *codec = dai->codec;
>>>> +
>>>> +	u8 mute_reg = snd_soc_read(codec, STA529_FFXCFG0)&   ~CODEC_MUTE_VAL;
>>>> +
>>>> +	if (mute)
>>>> +		mute_reg |= CODEC_MUTE_VAL;
>>>> +
>>>> +	snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, 00);
>>>
>>> You're always setting the same value here...
>>>
>>
>> Oops, it should be
>> snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, mute_reg);
>
> If you use snd_soc_update_bits, you don't have to read the register first.
>

Ok

Best Regards
Rajeev

>
>
> .
>
