From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Fri, 27 Apr 2012 12:59:06 +0200
Message-ID: <4F9A7BFA.7000507@stericsson.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423190508.GX8318@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C6582436A
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 12:59:09 +0200 (CEST)
In-Reply-To: <20120423190508.GX8318@opensource.wolfsonmicro.com>
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

On 04/23/2012 09:05 PM, Mark Brown wrote:

> On Fri, Apr 20, 2012 at 11:33:29AM +0200, Ola Lilja wrote:
> 
>> +snd-soc-ux500-mach-objs := u8500.o ux500_ab8500.o
>> +obj-$(CONFIG_SND_SOC_UX500_AB8500) += snd-soc-ux500-mach.o
> 
> This split into multiple files *really* doesn't seem like it adds
> anything but complexity, the small amount of reuse just doesn't seem
> worth it.


We will add more codecs to be matched up the same machine-driver and I found it
useful to have this split. It just separates the callbacks related to each codec
added in the dai-link-struct. I would like to keep this division if that is OK.

> 
>> +	/* Setup codec depending on driver-mode */
>> +	driver_mode = (channels == 8) ?
>> +		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;
>> +	dev_dbg(dev, "%s: Driver-mode: %s.\n", __func__,
>> +		(driver_mode == DRIVERMODE_NORMAL) ? "NORMAL" : "CODEC_ONLY");
>> +
>> +	ab8500_audio_set_bit_delay(codec_dai, 1);
> 
> What's this configuring?  I didn't notice it on the CODEC driver as the
> function wasn't exported IIRC.


The bit delay is the number of bit-clocks from the framesync to the first data-bit.
For the AB8500-chip it is set by the bit AB8500_DIGIFCONF2_IF0DEL.
I would have put this in the set_dai_fmt but I have not found a bit that is
controlling this.

> 
>> +	} else {
>> +		ab8500_audio_set_word_length(codec_dai, 20);
> 
> This should be done by using the TDM slot API - the slot length is one
> of the parameters.
> 
>> +	status = snd_soc_add_codec_controls(codec, ux500_ab8500_ctrls,
>> +			ARRAY_SIZE(ux500_ab8500_ctrls));
> 
> Do this from the driver.


OK.

> 
>> +	status = snd_soc_dapm_enable_pin(&codec->dapm, "Headset Left");
>> +	status |= snd_soc_dapm_enable_pin(&codec->dapm, "Headset Right");
> 
> No need to do this, everything defaults on.


Ah, then I have to put back all the disables instead, which I removed before
sending the patch =)
