From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Fri, 16 Mar 2012 14:09:38 +0100
Message-ID: <4F633B92.7030401@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
	<20120314134508.GL3133@opensource.wolfsonmicro.com>
	<4F6201C1.1040006@stericsson.com>
	<20120315152906.GN3138@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id C8DDB103C6A
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 14:10:15 +0100 (CET)
In-Reply-To: <20120315152906.GN3138@opensource.wolfsonmicro.com>
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

On 03/15/2012 04:29 PM, Mark Brown wrote:
> On Thu, Mar 15, 2012 at 03:50:41PM +0100, Ola Lilja wrote:
> > On 03/14/2012 02:45 PM, Mark Brown wrote:
> > > On Wed, Mar 14, 2012 at 02:27:13PM +0100, Ola LILJA2 wrote:
>
> Please include blank lines between paragraphs in your mail for
> legibility.
>
> > > This is completely orthogonal to how the controls are displayed to
> > > userspace, it's an implementation detail of your driver.  Though if your
> > > routing control doesn't actually touch the device one has to wonder what
> > > it actually does...
>
> > I never found a way to have the playback-switch not touching any bits
> > in the HW, so we used muxes instead. But if you say that is possible I
> > will look into it again.
>
> If the hardware has no control the idiomatic thing would be to have a
> pin switch in the machine driver.

We need to break chains on very specific positions to be able to affect only the
parts intended. We also have switches (e.g. loopback) that is not belonging to a
specific pin but is a brigde-switch in the middle of two chains, thus I don't
think we can use what you suggest.
The only solution I've found is to use the enum_virt, but if there is a
possibility to have a switch_virt I would be able to use that.
 
> > >> Most of the mutes need to be apart of the DAPM-chain to actually prevent
> > >> click-n-pops. So it cannot be used by the user as a normal ALSA-control.
> > >> Muting can be done by setting certain gains to -inf.
>
> > > This explanation doesn't correspond to what you've actually written -
> > > the code above will result in a user visible control.
>
> > That is why I said "most of", since this one was going to be converted to a
> > virtual type (SND_SOC_ENUM_VIRT). And then we could use the bit
> > REG_MUTECONF_MUTEAR in the DAPM-chain without having a userspace control setting
> > it before the chain is getting executed.
>
> > Also, the reason for not just changing control-types directly is because our
> > customers are affected by these kind of changes so we need to do those changes
> > at times where we can minimize the damge, have time to handle the effects and
> > when customers actually accept that we do it (we try to diverge as little as
> > possible from our main-branch).
>
> This sounds like a very good reason to go for mainline early.

Yes, but it doesn't solve our current problems.
(see first comment above regarding the enum_virt-stuff)

> > >> Hmm.. ok... the power_control is needed for reasons explained before
> > >> (vibra-driver and Accessory-detection-magic), but I guess I have to
> > >> remove these features for now and I can then remove this export.
> > > You've not mentioned accessory detection before...  there's certainly
> > > no obvious excuse for doing the power management for accessory detection
> > > outside of DAPM, we've got a bunch of drivers in mainline already which
> > > manage to do this quite successfully, but since you've not explained
> > > what the issue you think you see is it's hard to comment.
>
> > Accessory detection is just another external user not able to go through the
> > user-space interface and due to the fact that the algorithms need to detect
> > several different headset-types by turning on/off regulators and sampling the
> > voltage on the input in specific sequences, we found no convenient way to do
> > this since DAPM was controlling the regulators. We then introduced the _inc and
> > _dec for the power of the audio-part (ab8500_audio_power_control), so that DAPM
> > one-sided would not turn of the chip if, for example, vibra is on or accessory
> > detection is detecting.
>
> > We could remove both vibra and acc.det from the driver and put the
>
> Remember that the regulator API is reference counting, multiple things
> can control the same regulator without you having to layer another layer
> of reference counting and whatever else your code is doing on top of it.
> This is pretty essential for the regulator API, after all it's entirely
> normal for one regulator to supply many devices.

Yes, if it were only regulator (and clock) that was needed in our extra
reference-counted power-functions, it would be fine. But vibra needs to be able
to turn on the power of the audio-part of AB8500 (our codec) before it can use
the vibra-functionality. I could move our the reg/clock and assume that the
vibra-driver does this itself and only have the codec-power-register shared
between the external interface and the DAPM.

> Remember also that anything that goes into mainline is expected to have
> been peer reviewed and might get used as a reference by others.  Things
> like this that aren't working with the kernel frameworks but instead
> layer on top of them really don't fit well with that.
>
> > regulator-control inside the codec-driver, but we would drift even further from
> > what we actually use internally at ST-Ericsson and what our customers use.
>
> Given the drivers you originally posted I expect you're already a
> substantial distance away from your internal code anyway...  Perhaps you
> can use these issues internally as an example of the problems out of
> tree development that ends up with substantial non-framework code.

I will try (again) to foward the opinion that we should make greater efforts
(and earlier) to be in sync with mainline-kernel. However, if we get this driver
mainlined we can use all input to push harder for our next generation of
platforms. This driver is for a project that has nearly finished its execution,
but we would like to mainline this first before we go ahead with new drivers.
