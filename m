From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 21:16:15 +0800
Message-ID: <20131217131612.GO6691@S2101-09.ap.freescale.net>
References: <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
 <20131217021610.GA7172@S2101-09.ap.freescale.net>
 <20131217113705.GP3185@sirena.org.uk>
 <20131217123946.GN6691@S2101-09.ap.freescale.net>
 <20131217124657.GW3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 40F8D261178
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 14:15:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131217124657.GW3185@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 17, 2013 at 12:46:57PM +0000, Mark Brown wrote:
> On Tue, Dec 17, 2013 at 08:39:48PM +0800, Shawn Guo wrote:
> 
> > Hmm, I do not quite follow.  The regulator core needs to know whether a
> > regulator device is present or absent, before the regulator is
> > registered, so that regulator core can decide to return -EDEFER_PROBE
> > or -ENODEV when consumer calls regulator_get_optional() to get the
> > regulator.  Are you saying platform can call
> > regulator_has_full_constraints() to help regulator core to make this
> > decision?  I do not understand how it works.
> 
> It tells the core that it now knows about all regulator mappings so it
> knows if it's not got a mapping none will ever appear.

Okay, it sounds like what we need.  But I searched all the occurrences
of have_full_constraints() in core.c, and haven't found how it
influences the regulator_map_list searching.  I'm looking at function
regulator_dev_lookup().  Can you point me the correct place of the code?

Shawn
