From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: sgtl5000: drop
 sgtl5000_set_bias_level() call from sgtl5000_remove()
Date: Thu, 12 Dec 2013 22:17:58 +0800
Message-ID: <20131212141755.GA20319@S2101-09.ap.freescale.net>
References: <1386034012-18677-1-git-send-email-shawn.guo@linaro.org>
 <20131203160354.GD27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F26F260864
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2013 15:17:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131203160354.GD27568@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 03, 2013 at 04:03:54PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2013 at 09:26:51AM +0800, Shawn Guo wrote:
> 
> > Looking at function sgtl5000_set_bias_level(), we can find it
> > essentially does the following 3 things in case of SND_SOC_BIAS_OFF.
> 
> >  1. Set regmap into cache only mode with regcache_cache_only() call
> >  2. Disable supplies by calling regulator_bulk_disable()
> >  3. Set codec->dapm.bias_level as SND_SOC_BIAS_OFF
> 
> > For 1, it's clearly incorrect and that's why we see the failure here.
> > For 2, it's unnecessary since sgtl5000_remove() already calls
> > regulator_bulk_disable() to disable supplies.  For 3, it does not make
> > any sense either, since the bias level will be initialized to
> > SND_SOC_BIAS_STANDBY in the next probe anyway.
> > 
> > Let's drop the sgtl5000_set_bias_level() call from sgtl5000_remove() to
> > fix the kernel Oops below.
> 
> It's not clear to me that this is the best fix, all this code looks
> confused.

Yea, I'm working on a series to clean up and fix sgtl5000 driver, and
this issue should be removed by the series along the way.  So please
disregard this patch.

Shawn

> Given that (as is idiomatic) the regulators are being enabled
> in set_bias_level() what's happening in _OFF makes sense, what I'd
> expect to see happen is that the duplicate disables and frees are
> deleted from the remove path and the probe remembers to remove the cache
> only setting.  Alternatively all the regulator and cache handling could
> be removed from set_bias_level().  The end result should be that either
> set_bias_level() or the probe and remove are handling this but not both.
> 
> The regulator get and remove probably ought to move out to the I2C
> level, as should much of what happens in the probe function.
