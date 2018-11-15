From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Thu, 15 Nov 2018 13:25:28 +0200
Message-ID: <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
References: <ed34c70f-8d10-992e-1cf3-3a5f038c3664@gmail.com>
 <dccda0dc-bde7-7790-e4cc-2737871b14ea@linux.intel.com>
 <11a5bb5b-f8ad-d9cc-29df-8efeccb6228d@gmail.com>
 <20181114220640.GB2089@sirena.org.uk>
 <c0546298-960e-df17-273f-fa0734050aac@gmail.com>
 <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 5303D2678F2
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 12:25:31 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id v18-v6so20798920wrt.8
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 03:25:31 -0800 (PST)
In-Reply-To: <20181115003313.GH2089@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 11/15/18 2:33 AM, Mark Brown wrote:
> On Thu, Nov 15, 2018 at 01:55:06AM +0200, Dimitris Papavasiliou wrote:
>> On 11/15/2018 01:02 AM, Mark Brown wrote:
>>> I've no idea what you're proposing, sorry.
> 
>> I mentioned it in the message you replied to initially, so you
>> can consult that for more details if you want, but I'll give a
>> summary below:
> 
> That was rather a long mail and I got a bit lost about what the proposal
> was.

I understand completely and I apologize for that.  I try to keep the
length down as much as possible, but the situation is a bit
complicated (at least with my current familiarity of the ASOC layer).
Please don't interpret what I said as a complaint; I merely wanted to
point out that more details were available, should you require them.

> Given that there's no substantial delays in the power up/down paths of
> the driver you probably want to set idle_bias_off and possibly also
> configuring ignore_pmdown_time to force immediate poweroff.  That should
> get the device powered down rapidly, though bouncing the power on and
> off all the time isn't great.  If you do need ignore_pmdown_time then
> it's probably better to add a higher level interface that allows the
> machine driver to cancel all power down timers.

Although I think I've mentioned it in previous messages, you may have
missed it: What I'm trying to do, is fix the driver for a commercial
DAC board (the HifiBerry DAC+ Pro) which was designed for the
Raspberry Pi.  It uses the pcm512x CODEC driver (by specifying
.codec_dai_name = "pcm512x-hifi" in the dai_link struct) and simply
supplies a separate machine driver and a rudimentary clock driver, to
handle the necessary clock switching.

(If it would help, you can see the relevant code here:

https://github.com/raspberrypi/linux/blob/rpi-4.19.y/sound/soc/bcm/hifiberry_dacplus.c

Clock switching takes place in snd_rpi_hifiberry_dacplus_select_clk
which is eventually called from snd_rpi_hifiberry_dacplus_hw_params.)

Unless I misunderstand, I can't change the CODEC driver's settings
(such as ignore_pmdown_time) from the machine driver.  Even if I
could, I'm not entirely sure it would consistently fix the problem.
For instance, if the auto-mute is set to 21ms, the DAC output is muted
automatically by the chip after 21ms of no input and the pop still
manages to get through before that on occasion.

It also seems like a roundabout solution, that depends on proper
sequencing, i.e. it is assumed that the device is always biased
off before the hw_params callback of the machine driver is
called, something which might change in the future and cause a
regression.

All that's really necessary, is calling

snd_soc_component_update_bits(component, PCM512x_POWER, PCM512x_RQSY, 
PCM512x_RQSY);

before the clock switch and

snd_soc_component_update_bits(component, PCM512x_POWER, PCM512x_RQSY, 0);

afterwards.  Isn't there some way to lock the component/CODEC's
regmap, so as to perform an operation involving more than one
register change atomically? Something like
snd_soc_component_lock/unlock_regmap sounds like it might be
generally useful, to synchronize access to a chip's registers
across CODE/machine/etc. drivers.
