From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 19 Mar 2012 15:54:19 +0100
Message-ID: <4F67489B.3050709@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
	<20120314134508.GL3133@opensource.wolfsonmicro.com>
	<4F6201C1.1040006@stericsson.com>
	<20120315152906.GN3138@opensource.wolfsonmicro.com>
	<4F633B92.7030401@stericsson.com>
	<20120317223141.GK3315@opensource.wolfsonmicro.com>
	<4F66E934.1060909@stericsson.com>
	<20120319120956.GA3130@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
	[207.126.144.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 59E2B103AE6
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 15:54:29 +0100 (CET)
In-Reply-To: <20120319120956.GA3130@opensource.wolfsonmicro.com>
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

On 03/19/2012 01:09 PM, Mark Brown wrote:

> On Mon, Mar 19, 2012 at 09:07:16AM +0100, Ola Lilja wrote:
>> On 03/17/2012 11:31 PM, Mark Brown wrote:
> 
>> > > We need to break chains on very specific positions to be able to
>> > > affect only the parts intended. We also have switches (e.g. loopback)
>> > > that is not belonging to a specific pin but is a brigde-switch in the
>> > > middle of two chains, thus I don't think we can use what you suggest.
> 
>> > But if you have a control that actually does something then surely there
>> > should be some interaction with the chip when it is changed?
> 
>> No, we don't want the control to do anything with the chip before
>> playback/capture starts, but rather just indicate that a specific path
>> is active, and then when the stream starts the chain gets complete and
>> the widgets then do all interaction with the chip in the order that
>> our HW requires. There is no bit that we can set prior to the
>> execution of the DAPM-chain, without introducing clicks.
> 
> In the case of things that go external pins then I'd really expect the
> existing solution with pin switches to work, in other cases something
> else may be needed but we need to understand what you're trying to do.
> The issues with internal paths may need something but please be more
> concrete about what the actual register controls are and why you're
> doing such unusual things.  The fact that you're using isolated switches
> and there's no mixers involved is really surprisng.


I'll try to give some more details with two scenarios below.

Scenario 1:

We have a routing situation that could be rendered something like this:

                            D----->Speaker
                            |
I2S (playback)------>A----->B----->C----->Headset

In this case, let's say that the bit at B needs to be set in HW before C is set
to avoid pop/click noises.
If we just use a normal playback-switch that is associated with the bit at C,
then this switch would directly set the C bit before the stream is active and
then later when the stream is activated, the other widgets are enabled thus B
would be set (i.e. after C was set which is not the desired order).
Our solution to handle this is to introduce a virtual switch (in the form of an
enum_virt) between B and Headset.
Please note that moving the playback-switch to B would not work since that would
affect the Speaker-path enabling/disabling this as well which of course is not
desired to be controlled in this particular use-case.


Scenario 2:

We have a switch with purpose of forwarding sound from LineIn to be mixed with
HeadSet-audio coming from the I2S. However, we also (in parallell) have the
possibility to record the data coming from LineIn independently of the HeadSet
routing.

The routing situation could be rendered something like this:

I2S (playback)------>A----->B----->C----->Headset
                            ^
                            |
         LineIn----->D------E----->F----->I2S (capture)

As you can see neither of the endpoints "belongs" to the bypass-path (E->B) and
therefore I can't see how it should be possible to use a simple pin switch here
as it would always affect other paths.

> 
>> > One of the nice things about open source code is that it's always
>> > possible to extend the core if required.
> 
>> OK, so do you want us to make it possible to have NOPM for a
>> playback/capture-switch? Can you confirm that this is OK and that it
>> is possible to accomplish without destroying any mechanism in how it
>> works today?
> 
> I'm saying that if you're doing things within your driver that go trough
> contortions or break the userspace interfaces because the frameworks
> didn't support things then you should be fixing the frameworks rather
> than doing whatever in the driver.  This sort of thing seems to be at
> the root of several of the problems I'm seeing here, it's similar to all
> the stuff you're doing with regulators.
> 
>> So, what you want is another device/driver pair where our current
>> acc.det.-driver adds a driver to the device we add in the ASoC-driver?
> 
> I can't parse what you're saying here, sorry.


OK, I was trying to understand what you meant with these comments:
"breaking the device model" and "just embed a trivial input
driver in the CODEC for the vibra if it's small enough."
Could you explain this abit more?

> 
>> We are thinking of modifying so that we put the Android-vibra-functionality in
>> userspace, and then it can use vibra through the controls we provide in the
>> ASoC-driver.
> 
> That'd obviously remove any kernel level problems.
> 
>> Regarding the regulators, I was under the impression that everything
>> outside the actual codec, we could put in the machine-driver (which I
>> think looks pretty good).  This would make a clear distinction between
>> all codec-register-handling and usage of those external frameworks
>> (regulators and clocks). I have started to move the code location of
> 
> No.  That's exactly the sort of stuff we don't want to see.  The fact
> that the device needs power to operate isn't something that's specific
> to a particular board, it's a property of the silicon.


I agree that the fact that it needs power is not specific to the board, but we
could have different regulators feeding the codec-chip. The regulators could be
located outside the codec-chip and putting the codec in another board when the
codec-driver requests a specific regulator not present in the new board would
fail. Then we would need to have something like get_regulator("5 volts") to make
it generic between boards having regulators with different names providing the
same voltage.
I'm not into how the regulators work and as the trend is to have the regulator
stuff inside the codec-driver, I'll move it there.
Also, see the last comment below for more info on our regulator-usage.

> 
>> regulators/clocks into the codec-file and this results
>> in that the machine-driver is basically empty of functionality and the
>> codec-file is growing even bigger. Is this really what we want?
> 
> Yes, of course!  You need to get away from the idea that the only board
> your device will ever be used on is the reference board, things that are
> generic to the device should be supported by the device driver for the
> device.  If there's a device driver for the part we shouldn't be in the
> situation where any new system using the device needs to replicate basic
> functionality needed to get the device working.
> 
>> I'm also not sure if you have seen that we actually do control ALL regulators
>> and clocks via DAPM. The main power-regulator is controlled through a
> 
> I've not suggested that.  Look at how other drivers manage their power.


I have looked alot at other drivers, but in many cases I've found that our
situation looks pretty different and often more complex.
See the last comment below for more info on our regulator-usage.

> 
>> You are right that a large part of this code is there because it is needed by
>> external requirements, but it does not mean that DAPM is not controlling the
>> regulators and clocks, just that there is another interface that can also turn
>> on/off the power.
> 
> I'm not seeing any code in the driver which manages the regulators...


This is all our regulator-widgets, currently located in the machine-driver and
connected to chains located in the codec-driver:

	/* Power AB8500 audio-block when AD/DA is active */
	{"DAC", NULL, "AUDIO Regulator"},
	{"ADC", NULL, "AUDIO Regulator"},

	/* Power configured regulator when an analog mic is enabled */
	{"MIC1A Input", NULL, "AMIC1A Regulator"},
	{"MIC1B Input", NULL, "AMIC1B Regulator"},
	{"MIC2 Input", NULL, "AMIC2 Regulator"},

	/* Power DMIC-regulator when any digital mic is enabled */
	{"DMic 1", NULL, "DMIC Regulator"},
	{"DMic 2", NULL, "DMIC Regulator"},
	{"DMic 3", NULL, "DMIC Regulator"},
	{"DMic 4", NULL, "DMIC Regulator"},
	{"DMic 5", NULL, "DMIC Regulator"},
	{"DMic 6", NULL, "DMIC Regulator"},

The regulators are SND_SOC_DAPM_SUPPLY and connected to appropriate widgets
in the codec-driver, e.g.

 "ADC Input" ------------> "DAC"
                             ^
                             |
                      "AUDIO Regulator"

So whenever a stream is active this would lead to the event dapm_audioreg_event
which will call the power_control_inc(w->codec), turning on the regulator, clock
and power-up-register.
This also means that the extra machine-driver interface for acc.det and vibra
can also call the power_control_inc/power_control_dec.

Another example is the mic-regulators, e.g.

"MIC1A Input" --------> "Mic 1A or 1B Select Capture Route" -----> .....
       ^
       |
"AMIC1A Regulator"

Activating a switch completing the Mic1a-path to an output would lead to the
execution of the event in "AMIC1A Regulator": dapm_amic1areg_event. This leads
to regulator_enable, enabling the regulator associated with the Mic1a.

So all paths in the codec-driver leads to an event in the machine-driver
enabling/disabling the regulator.
