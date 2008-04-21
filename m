From: "pHilipp Zabel" <philipp.zabel@gmail.com>
Subject: Re: [PATCH] asoc tlv320aic3x: add GPIO support
Date: Mon, 21 Apr 2008 16:38:58 +0200
Message-ID: <74d0deb30804210738y7d9c38b6m885338f7551e182c@mail.gmail.com>
References: <20080418181214.GB26197@buzzloop.caiaq.de>
	<bd7b27490804181326v311f192bi8454c9c0661427d2@mail.gmail.com>
	<20080419004103.GA29770@buzzloop.caiaq.de>
	<20080419112425.GA18877@sirena.org.uk>
	<20080419121838.GA1680@buzzloop.caiaq.de>
	<20080419145005.GA23492@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EC37243B3
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 16:39:01 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id i2so2492891mue.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 07:39:00 -0700 (PDT)
In-Reply-To: <20080419145005.GA23492@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 19, 2008 at 4:50 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Apr 19, 2008 at 02:18:38PM +0200, Daniel Mack wrote:
>  > On Sat, Apr 19, 2008 at 12:24:26PM +0100, Mark Brown wrote:
>
>
> > > The usual approach is to have multi-function pins on CODECs are
>  > > controlled by the ASoC codec driver based on configuration supplied by
>  > > the machine driver.
>
>  > I was looking for a mechanism to pass such information around but didn't
>  > manage to find any. Which way would you suggest? The approach in my
>  > patch causes as less overhead as possible at it simply reuses the asoc's
>  > widgets, I though.
>
>  The usual thing would be to have your CODEC driver provide its own API
>  which users can call directly.
>
>
>  > > Their use tends to be heavily constrained by the
>  > > board design so it usually makes more sense to let the machine driver
>  > > set things up and deal with exposing controls for any configurability
>  > > that user space can exercise.
>
>  > Ok, but why not let the codec driver expose all the functionality it can
>  > offer for setting up a certain GPIO and use this alsa control either
>  > from user space or from the asoc machine part? I think that's the most
>  > flexible way at all, no?
>
>  The CODEC driver can't safely give user space control of multi-function
>  pins in general, including GPIOs, since their usage depends very
>  strongly on how they have been connected to the system.  At best much of
>  the functionality won't be useful on a given board due to a lack of
>  appropriate connections.  At worst the consequences of misusing them can
>  include things like causing one or more chips in the system to fall
>  over, perhaps even the entire system.  For example, if you've got two
>  chips each trying to drive a signal to different voltages then it is
>  possible that one or both of them will do something like attempt to
>  consume too much power and cause supplies to collapse.
>
>  It's OK for the kernel to be able to misconfigure things and control of
>  these features is very useful so it's good to provide it.  The issue is
>  letting user space get involved unless the machine driver has said that
>  it's safe to do so.
>
>
>  > And when it comes to setting or getting a GPIO's state I see no way to
>  > access such special purpose functions of the codec driver. At least,
>  > 'struct snd_soc_codec' doesn't give me any hints how to achive that.
>
>  Like I say, export a CODEC specific API for it.  The machine driver
>  already needs to know which CODEC and SoC it is working with and how
>  they are connected in a given system in order to set up the audio
>  connections.  In some cases the API calls can be avoided - for example,
>  if there is an I2S port on multi-function pins then configuring that I2S
>  port could implicitly configure the multi-function pins to enable that
>  port.
>
>
>  > > Most of the time when GPIO lines on CODECs are used they tend to be
>  > > controlling other bits of the audio subsystem anyway (eg, power for
>  > > simple amplifiers) - most SoCs have plenty of GPIOs on-board and they're
>  > > usually much easier to work with due to being memory mapped on the CPU.
>
>  > Well, I didn't implement that just because it wasn't done yet ;) In the
>  > setup I'm working on, one GPIO is needed to control peripherals next to
>  > it in the board layout where routing constraints become part of the
>  > game. And the other one is connected to one of the processor's GPIO to
>  > catch an interrupt from the AIC3x when a headset is plugged in. Thus, we
>  > really need to support them both. Others may have different use for
>  > them, just have a look at the possible functions of those GPIOs.
>
>  Those sound like exactly the sort of audio subsystem usages that I was
>  talking about - things that have fixed functions on a given board and
>  which the machine driver should be able to know how to set up in a way
>  that makes sense for the system.
>
>  In the case of jack detect I'm actually currently working on a
>  generalisation of that since it's such a common feature.  I hope to have
>  something in the next week or two but it depends on my other work.

This is interesting, what is the generic jack detect feature supposed
to do exactly? I ask because I just export the jack detect interrupt
to userspace via input subsystem (SW_HEADPHONE_INSERT). Will it
replace this switch in functionality?

regards
Philipp
