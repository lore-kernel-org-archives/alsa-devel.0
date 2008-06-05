From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Add WM8990 driver
Date: Thu, 5 Jun 2008 13:15:31 +0100
Message-ID: <20080605121531.GA6266@rakim.wolfsonmicro.main>
References: <1212656047-24209-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1212656047-24209-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h4p883zs7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C966E24629
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 14:15:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4p883zs7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 05, 2008 at 01:08:08PM +0200, Takashi Iwai wrote:

> > +			/* Delay to allow output caps to discharge */
> > +			schedule_timeout_interruptible(msecs_to_jiffies(300));

> Why interruptible?  Maybe msleep() is better for such a purpose?

The general pattern is to use schedule_timeout_interruptible() in these
bias state changes since several of the transitions may be triggered as
part of stream startup and teardown and therefore probably should be
interruptible in case someone has second thoughts about starting a
playback or something.  However, in this driver there aren't any delays
outside of the initial power up and power down sequences so I'll just
change it to use msleep().

> > +	codec->num_dai = 2;
> > +	codec->reg_cache_size = sizeof(wm8990_reg);

> A wrong value assignment in this file, too.  But, ARRAY_SIZE() is also
> wrong since the max reg value is ARRAY_SIZE().  ARRAY_SIZE()+1 is the
> right value, but then it's really unclear what it means...

What's happening is that the code this was taken from has saved a word
of memory by not including the (non-cacheable) reset/id register in the
cache but tripped up a bit doing it.  I don't think the two bytes are
worth the complexity so I'll simplify.
