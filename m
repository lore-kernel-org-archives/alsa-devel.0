From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Mon, 30 Apr 2012 10:26:30 +0200
Message-ID: <4F9E4CB6.7090606@stericsson.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
	<4F9A7BFA.7000507@stericsson.com>
	<20120427111523.GE18260@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
	[207.126.144.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8C582437A
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 10:26:38 +0200 (CEST)
In-Reply-To: <20120427111523.GE18260@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 04/27/2012 01:15 PM, Mark Brown wrote:

> On Fri, Apr 27, 2012 at 12:59:06PM +0200, Ola Lilja wrote:
> 
>> We will add more codecs to be matched up the same machine-driver and I found it
>> useful to have this split. It just separates the callbacks related to each codec
>> added in the dai-link-struct. I would like to keep this division if that is OK.
> 
> No, I really don't see any value at all in it.  The machine drivers
> aren't actually sharing anything visible and the effect of what you're
> doing is to make the selection of machine a compile time one instead of
> a runtime one.


No, that is a misunderstanding. We are just dividing the machine-driver file
into one main-file and then calling functions from other ones. It is not
affecting the framework in any way. We just want to divide the code in a way we
find useful. One file calling functions from another one. I don't see how that
can be a problem.

> 
>> >> +	/* Setup codec depending on driver-mode */
>> >> +	driver_mode = (channels == 8) ?
>> >> +		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;
>> >> +	dev_dbg(dev, "%s: Driver-mode: %s.\n", __func__,
>> >> +		(driver_mode == DRIVERMODE_NORMAL) ? "NORMAL" : "CODEC_ONLY");
>> >> +
>> >> +	ab8500_audio_set_bit_delay(codec_dai, 1);
> 
>> > What's this configuring?  I didn't notice it on the CODEC driver as the
>> > function wasn't exported IIRC.
> 
>> The bit delay is the number of bit-clocks from the framesync to the first data-bit.
>> For the AB8500-chip it is set by the bit AB8500_DIGIFCONF2_IF0DEL.
>> I would have put this in the set_dai_fmt but I have not found a bit that is
>> controlling this.
> 
> But what are you actually tying to do with this?  It sounds rather like
> you're selecting between DSP A and B modes...


Yes, I've moved this into the DSP A/B selection for the platform-DAI. I will do
the same for the codec-DAI.
