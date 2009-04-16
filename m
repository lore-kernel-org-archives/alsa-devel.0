From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [2.6.30-rc2][PATCH 1/2] ASoC: OMAP: Fix
 DSP_B	format in OMAP McBSP DAI driver
Date: Thu, 16 Apr 2009 14:35:20 -0700
Message-ID: <49E7A498.8060804@boundarydevices.com>
References: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>	<20090416134724.dfb3e57a.jarkko.nikula@nokia.com>	<dfeb90390904160420l3461f155u25d632d22388391e@mail.gmail.com>	<200904161427.30707.peter.ujfalusi@nokia.com>
	<dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BA77103800
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 23:35:26 +0200 (CEST)
In-Reply-To: <dfeb90390904160605m478dbf66yf78a0c012c2efc58@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <getarunks@gmail.com>
Cc: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Arun KS wrote:
> On Thu, Apr 16, 2009 at 4:57 PM, Peter Ujfalusi
> <peter.ujfalusi@nokia.com> wrote:
>> On Thursday 16 April 2009 14:20:36 ext Arun KS wrote:
>>> Hi Guys,
>>>
>>> I had done some mistake while applying the Jarkko's patch previously.
>>> Now its working fine.
>>> Sorry for the confusion caused.
>> :)
>> I have digged out an old omap1510 TRM to see what is going on...
>>
>> Still, while you have the setup, can you give my two patch a try on OMAP1 to
>> see if it is working correctly?
> 
> Your patches are working.
> I tested for DSP_A and DSP_B. Both works fine on osk5912 board.
> 
> But when I2S is used there is no audio on Right channel(left channel
> is working fine).
> Thinks something is missing on tlv320aic23 driver.
> 
> Arun
> 
>>> Arun
>>>
>>>> Jarkko
This sounds like the same problem Davinci has. From a comment in davinci-i2s.c

case SND_SOC_DAIFMT_I2S:
        /* Davinci doesn't support TRUE I2S, but some codecs will have
         * the left and right channels contiguous. This allows
         * dsp_a mode to be used with an inverted normal frame clk.
         * If your codec is master and does not have contiguous
         * channels, then you will have sound on only one channel.
         * Try using a different mode, or codec as slave.
         *
         * The TLV320AIC33 is an example of a codec where this works.
         * It has a variable bit clock frequency allowing it to have
         * valid data on every bit clock.
         *
         * The TLV320AIC23 is an example of a codec where this does not
         * work. It has a fixed bit clock frequency with progressively
         * more empty bit clock slots between channels as the sample
         * rate is lowered.
         */
Troy
