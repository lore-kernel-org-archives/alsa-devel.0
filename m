From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/3] imx-ssi: Use a hrtimer in FIQ mode
Date: Thu, 8 Apr 2010 15:13:53 +0200
Message-ID: <20100408131353.GI3688@pengutronix.de>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
	<1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
	<20100408095324.GB6303@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id ECB1E243DC
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 15:13:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100408095324.GB6303@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 10:53:25AM +0100, Mark Brown wrote:
> On Thu, Apr 08, 2010 at 11:31:26AM +0200, Sascha Hauer wrote:
> 
> > -	/* Restart the timer; if we didn't report we'll run on the next tick */
> > -	add_timer(&iprtd->timer);
> > +	hrtimer_forward_now(hrt, ns_to_ktime(iprtd->poll_time_ns));
> 
> Hrm, this looks like it's going to have an issue with clock drift -
> we're now unconditionally advancing the timer every period, even if the
> data transfer hasn't pushed through a period of data.  This will cause
> problems on lengthy playbacks (and shorter ones if the clocks are
> sufficiently out of sync).

We are calling snd_pcm_period_elapsed when at least one period is over.
As I see it the worst thing that could happen is that we have not
transfered enough data for one period in the timer callback and thus we
call snd_pcm_period_elapsed in the next timer callback, so about one
period too late, but the comment in sound/core/pcm_lib.c says:

Even if more than one periods have elapsed since the last call, you
have to call this only once.

So I think this should be save.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
