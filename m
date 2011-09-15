From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 00:49:15 +0100
Message-ID: <20110915234914.GG3218@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
	<20110915102430.GD7988@opensource.wolfsonmicro.com>
	<4E7214ED.9050703@freescale.com>
	<20110915223821.GA3218@opensource.wolfsonmicro.com>
	<4E728509.9060705@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5AEB6103861
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 01:49:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E728509.9060705@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 11:06:53PM +0000, Tabi Timur-B04825 wrote:
> Mark Brown wrote:

> > This isn't what happens at all.  The constraints set in the DAIs
> > generally just list all the sample rates the device can possibly
> > support, there's no dynamic information injected into the subsystem
> > about what's supported.  This is because in many systems the various
> > clock rates are dynamically controlled and so the clocks are adjusted to
> > reflect the sample rates the application layer wants.

> IMHO, these two sentences contradict each other.

The first one says that the rates announced by the driver are the
superset of all rates the device can ever support, the second says that
this is done because the system can change the clock rate after we're
done announcing what sample rates we support.

> > As a result we
> > never actually bother specifying the supported rates for the current
> > clock at all, we just try to make the best of what we're given when it
> > comes to configuring which is a rather different thing.

> But why would you do that?  That just creates an artificial limitation on 
> the list of supported sample rates.  If you include a set_sysclk() 
> function in the codec driver, then you should always specify 
> SNDRV_PCM_RATE_CONTINUOUS in snd_soc_dai_driver.rates.  To me, the two go 
> hand-in-hand.

Devices, especially ones with lots of digital in them, often support a
series of specific sample rates rather than a continuous range of sample
rates.  While you can of course configure them with other setups this
will run them out of spec which may cause issues from poor performance
up to serious audio issues or misdriving of outputs (eg, class D speaker
drivers or things using charge pumps).  Most of the time things will be
OK but in general it seems better to try to stay within spec.

Fairly simple devices like the WM8776 which don't contain much digital
are commonly supported over a continuous range of sample rates so
_CONTINUOUS is suitable for them.
