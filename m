From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] ASoC: core: Clean up DAPM before the card
	debugfs
Date: Fri, 19 Aug 2016 19:04:52 +0100
Message-ID: <20160819180452.GW1041@n2100.armlinux.org.uk>
References: <1471545449-29516-1-git-send-email-broonie@kernel.org>
 <20160818232642.GF1041@n2100.armlinux.org.uk>
 <20160819175003.GE22076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
 by alsa0.perex.cz (Postfix) with ESMTP id B069D266605
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 20:05:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160819175003.GE22076@sirena.org.uk>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 19, 2016 at 06:50:03PM +0100, Mark Brown wrote:
> On Fri, Aug 19, 2016 at 12:26:42AM +0100, Russell King - ARM Linux wrote:
> > I suspect that isn't the full story though, because of the regmap
> > complaint (which I've not even looked at yet.)
> 
> Missed that one?

I think it was something like the following, but I don't remember
off hand without re-running the build that caused it and booting it
again.

twl6040 0-004b: Unable to sync registers 0xc-0xd. -121

I got that while trying my hibernate test (which fails due to no swap)
but it shouldn't cause any other errors:

CPU1: shutdown
PM: Creating hibernation image:
PM: Need to copy 12497 pages
PM: Normal pages needed: 9337 + 1024, available pages: 54137
PM: Hibernation image created (12497 pages copied)
Enabling non-boot CPUs ...
CPU1 is up
PM: noirq thaw of devices complete after 8.209 msecs
PM: early thaw of devices complete after 5.065 msecs
PM: thaw of devices complete after 15.563 msecs
twl6040 0-004b: Unable to sync registers 0xc-0xd. -121
PM: writing image.
PM: Cannot find swap device, try swapon -a.
PM: Cannot get swap writer
PM: Basic memory bitmaps freed
Restarting tasks ... done.

That's probably not regmap's fault, but something else.  I guess TIers
need to dig into that one.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
