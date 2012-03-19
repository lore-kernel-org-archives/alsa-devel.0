From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 19 Mar 2012 09:07:16 +0100
Message-ID: <4F66E934.1060909@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
	<20120314134508.GL3133@opensource.wolfsonmicro.com>
	<4F6201C1.1040006@stericsson.com>
	<20120315152906.GN3138@opensource.wolfsonmicro.com>
	<4F633B92.7030401@stericsson.com>
	<20120317223141.GK3315@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog107.obsmtp.com (eu1sys200aog107.obsmtp.com
	[207.126.144.123])
	by alsa0.perex.cz (Postfix) with ESMTP id 90232103AE8
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 09:07:54 +0100 (CET)
In-Reply-To: <20120317223141.GK3315@opensource.wolfsonmicro.com>
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

On 03/17/2012 11:31 PM, Mark Brown wrote:
> On Fri, Mar 16, 2012 at 02:09:38PM +0100, Ola Lilja wrote:
> > On 03/15/2012 04:29 PM, Mark Brown wrote:
>
> Please fix the word wrapping in your mail client...

Well, I though I did that when I moved over to Thunderbird and set the
wordwrapping to 80 chars (no float). It would help if you told me exactly what
settings it is you want, or provide a link to a description of what settings are
required.

> > > If the hardware has no control the idiomatic thing would be to have a
> > > pin switch in the machine driver.
>
> > We need to break chains on very specific positions to be able to
> > affect only the parts intended. We also have switches (e.g. loopback)
> > that is not belonging to a specific pin but is a brigde-switch in the
> > middle of two chains, thus I don't think we can use what you suggest.
>
> But if you have a control that actually does something then surely there
> should be some interaction with the chip when it is changed?

No, we don't want the control to do anything with the chip before
playback/capture starts, but rather just indicate that a specific path is
active, and then when the stream starts the chain gets complete and the widgets
then do all interaction with the chip in the order that our HW requires. There
is no bit that we can set prior to the execution of the DAPM-chain, without
introducing clicks.

> > The only solution I've found is to use the enum_virt, but if there is
> > a possibility to have a switch_virt I would be able to use that.
>
> One of the nice things about open source code is that it's always
> possible to extend the core if required.

OK, so do you want us to make it possible to have NOPM for a
playback/capture-switch? Can you confirm that this is OK and that it is possible
to accomplish without destroying any mechanism in how it works today?

> > Yes, if it were only regulator (and clock) that was needed in our extra
> > reference-counted power-functions, it would be fine. But vibra needs to be able
> > to turn on the power of the audio-part of AB8500 (our codec) before it can use
> > the vibra-functionality. I could move our the reg/clock and assume that the
> > vibra-driver does this itself and only have the codec-power-register shared
> > between the external interface and the DAPM.
>
> As I said previously there's other drivers with the same setup which
> manage to integrate fairly easily without breaking the device model - do
> what they do with something like an MFD or just embed a trivial input
> driver in the CODEC for the vibra if it's small enough.

So, what you want is another device/driver pair where our current
acc.det.-driver adds a driver to the device we add in the ASoC-driver?
We are thinking of modifying so that we put the Android-vibra-functionality in
userspace, and then it can use vibra through the controls we provide in the
ASoC-driver.

> > (and earlier) to be in sync with mainline-kernel. However, if we get this driver
> > mainlined we can use all input to push harder for our next generation of
> > platforms. This driver is for a project that has nearly finished its execution,
> > but we would like to mainline this first before we go ahead with new drivers.
>
> Equally well, if it gets mainline without actually meeting mainline
> standards that's sending the wrong message :) 
>
> I'd suggest at least adding regulator support into the CODEC driver so
> it's managing its own power when required, there's no reason for
> anything external to be doing that.  I expect if you bring things into
> line with the device model the code will end up being a lot smaller and
> clearer and this won't be needed, it feels like a large part of why
> you're having to open code all this stuff is that other bits of the code
> stepped outside the frameworks.

Regarding the regulators, I was under the impression that everything outside the
actual codec, we could put in the machine-driver (which I think looks pretty good).
This would make a clear distinction between all codec-register-handling and
usage of those external frameworks (regulators and clocks). I have started to
move the code location of regulators/clocks into the codec-file and this results
in that the machine-driver is basically empty of functionality and the
codec-file is growing even bigger. Is this really what we want?
I'm also not sure if you have seen that we actually do control ALL regulators
and clocks via DAPM. The main power-regulator is controlled through a
DAPM-widget which is defined in the machine-driver and connected to the chains
in the codec-driver. The event in the widget will then call the
_inc/_dec-functions in the machine-driver. All other regulators (analog/digital
mic-bias) are also part of the DAPM-chains and turned on/off by the framework
just as it should.
You are right that a large part of this code is there because it is needed by
external requirements, but it does not mean that DAPM is not controlling the
regulators and clocks, just that there is another interface that can also turn
on/off the power.
