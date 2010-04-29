From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Thu, 29 Apr 2010 10:36:51 +1000
Message-ID: <1272501411.24542.125.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
	<1272427811.24542.59.camel@pasglop>
	<20100428120719.GE31400@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BEAE103844
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Apr 2010 02:37:16 +0200 (CEST)
In-Reply-To: <20100428120719.GE31400@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-04-28 at 13:07 +0100, Mark Brown wrote:
> > The device-tree helps keep the platform .c file simple and devoid of too
> > horrible hacks, it allows to easily pass various configuration data to
> > leaf drivers such as i2c thingies, PHY devices etc... without gross
> > hooks between these and the platform, but the platform code still has
> > the upper hand for doing ad-hoc bits and pieces (or overwriting the
> > device-tree based behaviour) if necessary.
> 
> Once again, if you can get the device tree guys to buy into this and
> stick with it that sounds good but my experience has been that this
> isn't where any of these discussions end up. 

Well, as the person who came up with the flattened device-tree format in
the first place I suppose I qualify as a "device-tree" guy here :-)

At the moment, I'd say Grant (and to some extent Jeremy Kerr) are the
guys in charge though, but yes, I agree with you, there's a tendency to
be too over-exited and to want to do "too much" with the DT and that is
counter productive. It's a good tool but it's not going to solve world
hunger and in some places an ad-hoc bit of C code is a better option :)

Now, I don't think Grant is totally off the tracks here but I must admit
I haven't taken the time to ensure I understand perfectly everybody's
position in that debate. At least I made mine clear, hope this helps :-)

Cheers,
Ben.
