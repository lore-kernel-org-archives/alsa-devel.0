From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: imx-ssi fixes
Date: Thu, 8 Apr 2010 17:51:13 +0200
Message-ID: <20100408155113.GM3688@pengutronix.de>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
	<20100408144750.GC14241@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B3FD110397D
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 17:51:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100408144750.GC14241@sirena.org.uk>
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

On Thu, Apr 08, 2010 at 03:47:50PM +0100, Mark Brown wrote:
> On Thu, Apr 08, 2010 at 11:31:23AM +0200, Sascha Hauer wrote:
> 
> > Here are some bugfix patches for the imx-ssi driver. It should also fix
> > the problems reported in FIQ mode.
> 
> Applied all three, thanks - the hrtimer stuff works an awful lot better
> than the vanilla timer stuff did.  It's a shame I hadn't noticed that
> hrtimers did manage to give better resolution on i.MX when I looked into
> this previously.
> 
> It'd be good if you could look into the timer sync issue - doing
> something like deferring the timer by a proportion of a period if
> the period hasn't elapsed ought to cover it.

I'll look into it. I'm thinking of

- busywaiting if the current period hasn't elapsed (should rarely if
  ever the case since the fiq works reliable and the timer interrupt
  introduces additional delays.
- calculate the next callback time based on the current offset.

If you haven't pushed the patches forward it would be good to delay the
hrtimer patch a bit. I managed to shoot the system down while playing
audio with a hackbench 10. This doesn't happen without the hrtimer
patch. This may be related to the problem Valentin reported.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
