From: Randolph Chung <rchung42@gmail.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Thu, 12 Aug 2010 22:59:19 +0800
Message-ID: <AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
	<20100812125625.GA27749@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B9A7103868
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 16:59:25 +0200 (CEST)
Received: by eye27 with SMTP id 27so680791eye.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 07:59:25 -0700 (PDT)
In-Reply-To: <20100812125625.GA27749@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 12, 2010 at 8:56 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Aug 12, 2010 at 06:15:47PM +0800, Randolph Chung wrote:
>> I have a target that uses iMX27(L) + tlv320aic3x. The kernel tree is
>> HEAD of linux-arm from about a week ago.
>>
>> Simple playback and recording (using aplay and arecord) work fine.
>> However, I've run into a strange problem when both playback and
>> capture streams are opened at the same time.
>>
>> Consider the attached test program. The capture device is setup with a
>> period time of 10ms, and the program reads samples in a loop. The
>> expected result is that I get a sample every 10ms. This works fine if
>> the playback device is *not* opened (more specifically, if the
>> hw_params are not set). However if the playback device is opened (#if
>> 1 code) then I get samples every 20ms, which seems very wrong.
>>
>> I have tried using both DMA and FIQ ssi-pcm interfaces and both give
>> the same strange result. With the FIQ driver, if I instrument the
>> timer callback, the timer triggers every 10ms but there is only enough
>> data every 20ms.
>>
>> The codec is being driven with a 13MHz MCLK (output from MX27) and the
>> BCLK and WCLK come from the codec. They seem to have the correct
>> rates.
>>
>> Any ideas? Can anybody else with MX27 hardware verify if my test
>> program also fails on their target?
>
> You should check the return values of the snd_pcm_hw_params_* functions.
> At least snd_pcm_hw_params_set_channels fails because we currently only
> support two channels. I'm not sure whether we can support one channel
> mode without changes to the driver.

I will double check tomorrow, but I have another version of the code
that checks all the return values and I am quite sure the set_channels
didn't fail....

In any case why would it work if there is only a capture device open?

Also I would imagine even if there are 2 channels the code should still work....

I would appreciate some test results on another  mx27 board to verify
if it is a problem specific to my setup or generic to other mx27
targets.

thanks,
randolph
