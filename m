From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: tlv320aic23: add support for SPI
 control mode
Date: Thu, 6 Mar 2014 12:38:04 +0400
Message-ID: <CAMo8BfKMz1d9zpbrb=JUMvjs4bE=ah1DfvM8f0KG5=uJuNJKxw@mail.gmail.com>
References: <1394091862-13603-1-git-send-email-jcmvbkbc@gmail.com>
	<20140306080720.GI13126@sirena.org.uk>
	<CAMo8BfJit6Bgafi7Fwgwmtn36QZH6XsHucdPdeffjgJn0byDpw@mail.gmail.com>
	<531832F5.4030000@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <531832F5.4030000@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 6, 2014 at 12:33 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/06/2014 09:26 AM, Max Filippov wrote:
>>
>> Hi Mark,
>>
>> On Thu, Mar 6, 2014 at 12:07 PM, Mark Brown <broonie@kernel.org> wrote:
>>>
>>> On Thu, Mar 06, 2014 at 11:44:22AM +0400, Max Filippov wrote:
>>>
>>>> -     select SND_SOC_TLV320AIC23 if I2C
>>>> +     select SND_SOC_TLV320AIC23 if SND_SOC_I2C_AND_SPI
>>>
>>>
>>> We're moving towards having drivers have separate bus drivers rather
>>> than in one file - take a look at how drivers like ad193x handle this.
>>
>>
>> Thanks for the pointer, but... ad193x has spi and i2c in single source
>> in both linus and alsa-kernel trees. Confused.
>>
>
> It's in the ASoC tree:
> http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/sound/soc/codecs/?h=for-next&id=6c3d713e6d32706999689e379a9098afb4cd8a2c

Thank you Lars-Peter. I'll do the same split for aic23.

-- 
Thanks.
-- Max
