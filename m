From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic23: add support for SPI control mode
Date: Thu, 6 Mar 2014 12:26:21 +0400
Message-ID: <CAMo8BfJit6Bgafi7Fwgwmtn36QZH6XsHucdPdeffjgJn0byDpw@mail.gmail.com>
References: <1394091862-13603-1-git-send-email-jcmvbkbc@gmail.com>
	<20140306080720.GI13126@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140306080720.GI13126@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Thu, Mar 6, 2014 at 12:07 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 06, 2014 at 11:44:22AM +0400, Max Filippov wrote:
>
>> -     select SND_SOC_TLV320AIC23 if I2C
>> +     select SND_SOC_TLV320AIC23 if SND_SOC_I2C_AND_SPI
>
> We're moving towards having drivers have separate bus drivers rather
> than in one file - take a look at how drivers like ad193x handle this.

Thanks for the pointer, but... ad193x has spi and i2c in single source
in both linus and alsa-kernel trees. Confused.

-- 
Thanks.
-- Max
