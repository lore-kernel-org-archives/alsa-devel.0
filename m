From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] imx-ssi: Use a hrtimer in FIQ mode
Date: Thu, 08 Apr 2010 16:14:29 +0100
Message-ID: <1270739669.3248.591.camel@odin>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
	<1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
	<20100408095324.GB6303@rakim.wolfsonmicro.main>
	<20100408131353.GI3688@pengutronix.de>
	<20100408140329.GB14241@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f178.google.com (mail-iw0-f178.google.com
	[209.85.223.178])
	by alsa0.perex.cz (Postfix) with ESMTP id EF73710393E
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 17:14:39 +0200 (CEST)
Received: by iwn8 with SMTP id 8so1421280iwn.16
	for <alsa-devel@alsa-project.org>; Thu, 08 Apr 2010 08:14:39 -0700 (PDT)
In-Reply-To: <20100408140329.GB14241@sirena.org.uk>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, alsa-devel@alsa-project.org, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-04-08 at 15:03 +0100, Mark Brown wrote:
> On Thu, Apr 08, 2010 at 03:13:53PM +0200, Sascha Hauer wrote:
> > On Thu, Apr 08, 2010 at 10:53:25AM +0100, Mark Brown wrote:
> 
> > > Hrm, this looks like it's going to have an issue with clock drift -
> > > we're now unconditionally advancing the timer every period, even if the
> > > data transfer hasn't pushed through a period of data.  This will cause
> > > problems on lengthy playbacks (and shorter ones if the clocks are
> > > sufficiently out of sync).
> 
> > We are calling snd_pcm_period_elapsed when at least one period is over.
> > As I see it the worst thing that could happen is that we have not
> > transfered enough data for one period in the timer callback and thus we
> > call snd_pcm_period_elapsed in the next timer callback, so about one
> > period too late, but the comment in sound/core/pcm_lib.c says:
> 
> > Even if more than one periods have elapsed since the last call, you
> > have to call this only once.
> 
> > So I think this should be save.
> 
> The risk here is fragility caused by delaying the notification.
> 
> The issue is that if the period is long enough and/or the application is
> running too close to where the hardware is then the delay of what's
> likely to be almost an entire period is likely to glitch - you can end
> up with a situation where you're essentially notifying immediately
> before the end of the next period rather than immediately after the end
> of the current period.
> 
> Consider, for example what happens if the hrtimer runs slightly faster
> than the audio clock.  Eventually you'll get:
> 
>  - The timer runs, period A has a frame or two to go still.
>  - Period A completes, period A' begins.
>  - The timer fires again - period A is notified, period A' is almost
>    complete.
> 
> In this situation the completion notifications lag the actual completion
> of the frame by almost a period (though this lag will go down over time).
> Most of the time this will still be fine and everything will work OK but
> I would expect this to cause issues with some applications, especially
> if they're trying to be latency sensitive.

I agree this will drift but I _think_ we are probably workable here for
most latency sensitive apps as long as the worst case notification delay
is 1 period, pointer() is accurate to a few frames and there is a least
> 3 or 4 period buffers available for use in our driver buffer (for each
direction). 

Currently the min periods for this driver is 2, so I would probably
change to 4 to reduce drift related glitches.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
