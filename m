From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Question about your DSP topic branch
Date: Tue, 15 Mar 2011 11:25:31 +0000
Message-ID: <20110315112531.GA17277@sirena.org.uk>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org> <1295973973.3322.347.camel@odin> <4D4202AF.1090206@codeaurora.org> <4D7F1077.9030907@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D7F1077.9030907@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-arm-msm@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmciro.com>, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 15, 2011 at 12:08:39AM -0700, Patrick Lai wrote:

> 1. If there are two front-ends routed to same backend, which front-end 
> hardware parameters should backend DAI be based on? For example, one 
> front-end is MONO and another front is stereo.

> 2. Depending on device mode/use case, I would like to configure BE to 
> different channel mode irrespective of front-end configuration(i.e 
> configuring back-end to handset mode). Where is the hook to do so under 
> ASoC DSP framework?

If you can configure the two completely separately then you can just
have a DAPM path between the two devices and don't need to link the DAI
configurations at all - WM8994 is an example of doing this, there is a
bunch of DSP and mixing in the digital section between the DAIs but
because the DSP includes sample rate conversion the DAIs can be
configured separately and we don't have to worry about propagating DSP
through.

Thinking off the top of my head if you do need to link the
configurations sometimes the first thing that springs to mind is to set
constraints so broad that they're noops - we're going to want to support
propagating constraints through as well as specific settings anyway
since some stuff has restrictions like "Route DAI 1 to DAI 2 with DAI 2
at any sample rate that's an integer division of the DAI 1 rate", though
that sort of stuff may well be a second pass.

One thing I should mention which I've been working on and which may
(depending on the design of your hardware) be a better match for you is
providing a mechanism for setting up DAI links and starting streams on
them in kernel space based on DAPM routing, with DAPM propagating over
these links automatically.  This is mostly intended for representing
things like basebands where you'll have a DAI link that's going to be
running in one of a small number of configurations (often only one)
connected to something else along the lines of:

   CODEC  <  8kHz mono  >  Baseband

so the idea is that to the user you can have a couple of pin switches
(or whatever else can be represented) in the baseband to say that the
baseband is passing audio and then DAPM will be extended to figure out
that it should start up the audio intefaces and configure their params
without needing userspace to do it just like it can if the link between
the two were analogue.

This will compliment the work Liam's doing - Liam's work ties together
the configuration within a device, this'll help with inter-device links.
