From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
 ALSA SoC drivers
Date: Wed, 28 Apr 2010 10:16:30 +0100
Message-ID: <20100428091629.GA31400@opensource.wolfsonmicro.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
	<i2vfa686aa41004271931wc04b9c11l5f3ebda0acb14b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9199524487
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Apr 2010 11:16:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <i2vfa686aa41004271931wc04b9c11l5f3ebda0acb14b9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 08:31:18PM -0600, Grant Likely wrote:
> On Tue, Apr 27, 2010 at 4:29 PM, Mark Brown

> > On the other hand from a pragmatic point of view it's just much less
> > hassle to just only provide the mechanism for instantiating a machine
> > with custom code and use that for everything.

> Also true, but this approach carries with it an incremental cost that
> distributions feel the pain of.  Ultimately I think we'll find a sweet
> spot somewhere in between.

Meh, it's not really much hassle for the distributions - it's all
handled by the kernel, they don't need to explicitly do anything.

None of the machine-specific stuff has ever been a hassle getting stuff
merged, problems have always been in the drivers for the devices which
device tree isn't going to make a blind bit of difference to (other than
the usual discussions about what exactly the device tree should look
like).
