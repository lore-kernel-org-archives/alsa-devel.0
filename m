From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: arizona: Check clocking
	during	hw_params rather than startup
Date: Mon, 27 Jan 2014 11:25:26 +0000
Message-ID: <20140127112526.GF11589@opensource.wolfsonmicro.com>
References: <1390582753-1026-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <52E2A1F2.6070707@metafoo.de> <20140124173754.GD11727@sirena.org.uk>
 <52E607FE.8010807@metafoo.de> <20140127105508.GW11727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1087261685
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 12:32:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140127105508.GW11727@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 27, 2014 at 10:55:08AM +0000, Mark Brown wrote:
> On Mon, Jan 27, 2014 at 08:17:18AM +0100, Lars-Peter Clausen wrote:
> > On 01/24/2014 06:37 PM, Mark Brown wrote:
> 
> > > Thanks, that's about what I was going to write.  The current theory is
> > > that setting the sysclk to zero is the equivalent of a dynamic SYSCLK
> > > flag - with the extensive use of charge pumps and so on in modern
> > > devices on the fly reclocking is normally difficult to do safely so the
> > > idea is that if the machine driver is in a position to reclock it should
> > > set the clock to zero.
> 
> > It's a bit ugly though to set the clock to 0 in the startup callback of the
> > machine driver and then set it to the actual sysclk in the hw_params callback.
> 
> If something is doing this I'd expect it to set the clock to zero when
> it is idled rather than during startup() - set_bias_level() is usually a
> good place to do this, or possibly a DAPM widget supplying the clocks in
> the device if the clocks are visible in DAPM.  That's a bit nicer and
> doing it on startup runs into issues with things like bypass paths
> anyway.

Yeah I think the existing support is actually likely sufficent
looks likely this was actually an issue with the machine driver
in question, apologies for the noise.

Thanks,
Charles
