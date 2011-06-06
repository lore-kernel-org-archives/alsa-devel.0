From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V4 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Mon, 06 Jun 2011 09:35:52 +0200
Message-ID: <4DEC8358.9000705@metafoo.de>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<4DEC7275.7010603@metafoo.de> <4DEC7CFB.60405@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 5982E243B3
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 09:37:06 +0200 (CEST)
In-Reply-To: <4DEC7CFB.60405@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 06/06/2011 09:08 AM, rajeev wrote:
> Hi Lars-Peter Clausen 
> Please find my answer inline below.
> 
> On 6/6/2011 11:53 AM, Lars-Peter Clausen wrote:
>> On 06/06/2011 07:57 AM, Rajeev Kumar wrote:
>>> This patch adds the support for STA529 audio codec.
>>> Details of the audio codec can be seen here:
>>> http://www.st.com/internet/imag_video/product/159187.jsp
>>>
>>> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>>> ---
>>>  sound/soc/codecs/Kconfig  |    5 +
>>>  sound/soc/codecs/Makefile |    2 +
>>>  sound/soc/codecs/sta529.c |  374 +++++++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 381 insertions(+), 0 deletions(-)
>>>  create mode 100644 sound/soc/codecs/sta529.c
>>>
>>> [...]
>>> +
>>> +static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
>>> +	SOC_ENUM("PWM Select", pwm_src_enum),
>>> +	SOC_ENUM("MODE Select", mode_src_enum),
>>
>> The mode should be configured by the dai_drivers set_fmt callback, and not by a
>> control.
>>
> I think giving a interface to the user is better option rather than doing it in set_fmt callback.
Why? Both the codec_dai and the cpu_dai have to agree on who is the master and
who is the slave. So letting the user select the codec mode instead of defining
it in the board driver doesn't make sense, since the setup will stop working if
the cpu dai isn't configured to match the codec dais mode.
Furthermore you don't want to switch the mode while playback is active and
generally you won't even change it at all, once it has been setup.

> [...[
>>> +
>>> +static int sta529_mute(struct snd_soc_dai *dai, int mute)
>>> +{
>>> +	struct snd_soc_codec *codec = dai->codec;
>>> +
>>> +	u8 mute_reg = snd_soc_read(codec, STA529_FFXCFG0) & ~CODEC_MUTE_VAL;
>>> +
>>> +	if (mute)
>>> +		mute_reg |= CODEC_MUTE_VAL;
>>> +
>>> +	snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, 00);
>> I guess, it should be mute_reg instead of 00
>>
> No, This is value, register is STA529_FFXCFG0

You are always clearing the mute bit, regardless of whether mute is enabled or
disabled.
snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, mute_reg); is probably what
you want to do.

>[...]
>>> +static struct snd_soc_dai_ops sta529_dai_ops = {
>> Can be const
> It can not be. Please check snd_soc_dai_ops structure in include/sound/soc-dai.h  

Yes, it can. Maybe you are using an outdated ASoC version. Check line 206 of
include/sound/soc-dai.h in Mark's for-next branch.

> [...]
>>> +
>>> +	snd_soc_add_controls(codec, sta529_snd_controls,
>>> +			ARRAY_SIZE(sta529_snd_controls));
>>> +
>>> +	snd_soc_add_controls(codec, sta529_new_snd_controls,
>>> +			ARRAY_SIZE(sta529_new_snd_controls));
>> You should use table based controls setup. i.e assign the control table to the
>> 'controls' field of your codec_driver.
>>
> You can do it in either way.
Yes, you can, but you should use the codec_driver fields unless you have good
reasoning not to.

>>> [...]
>>
>> Your driver doesn't use any DAPM. You should at least define input and output
>> pins and their routing, but I would expect that there is more that can be done,
>> like dynamicly powering unused sections of the codec down, like the DAC or ADC.
>> .
>>
> Right now since my driver has not support for DAPM, so definitions for input and output pins
> are not there.Once I will implement DAPM feature in future I will send separate patch for that. 
>  

Currently there is a bug in the ASoC core, which will cause codec drivers
without DAPM to be not powered down, even though if they are not used.
Given that it will maybe take 5 minutes or so to add basic DAPM (Input/Output
pins and ADC/DAC) it would be a good idea to add it to the inital version of
the driver.

- Lars
