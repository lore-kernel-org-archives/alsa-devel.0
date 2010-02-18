From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 10:57:50 +0000
Message-ID: <20100218105750.GB3542@rakim.wolfsonmicro.main>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
	<20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
	<20100218093459.GB3315@rakim.wolfsonmicro.main>
	<1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
	<20100218095249.GE3315@rakim.wolfsonmicro.main>
	<1b68c6791002180232p6cd86811sc78699ac87236015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA74D103904
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 11:57:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002180232p6cd86811sc78699ac87236015@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2010 at 07:32:22PM +0900, jassi brar wrote:
> On Thu, Feb 18, 2010 at 6:52 PM, Mark Brown

> > Where is the code you are talking about here? =A0This sounds like driver
> > code...

> Ahh... it's all messed up by that samsung.git link that Joonyoung Shim sh=
ared.
> I assumed you had a look at that. The code just a quick workaround, so
> I didn't put it up here
> http://git.kernel.org/?p=3Dlinux/kernel/git/kki_ap/linux-2.6-samsung.git;=
a=3Dcommitdiff;h=3De5858948bb2c534251b65a850caf197ae880ce1f

His link was to the entire tree rather than a particular bit of code, a
bit of a needle in the haystack thing going on there (especially since
you have actually modified the core and for looking at stuff like that
I'd generally drill down into the platform directory before looking at
logs or code).

The bits of that patch that make active a reference counter look good at
first glance, could you please pull them out and submit them?  Like I
said in reply to Joonyoung it's not immediately clear to me that the
startup and shutdown calls should be suppressed since I'd expect that at
least some drivers are going to want to know about multiple uses (for
example, returning -EBUSY if someone tries to have too many things
active at once).

In general for a vendor BSP I'd strongly recommend against any changes
in the core that don't get submitted to mainline - it's more of a
maintinance burden and makes it harder for people to take the drivers
and use them with other kernel versions if they don't notice the change.
Obviously the ideal is to merge the drivers as well, but changes in the
core are more risky to carry out of mainline than drivers.
