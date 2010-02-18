From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Thu, 18 Feb 2010 13:10:27 +0000
Message-ID: <20100218131027.GF3542@rakim.wolfsonmicro.main>
References: <20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
	<20100218093459.GB3315@rakim.wolfsonmicro.main>
	<1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
	<20100218095249.GE3315@rakim.wolfsonmicro.main>
	<1b68c6791002180232p6cd86811sc78699ac87236015@mail.gmail.com>
	<20100218105750.GB3542@rakim.wolfsonmicro.main>
	<1b68c6791002180359k65381c09t143d37ec5eef1cf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5A41D1038FC
	for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2010 14:10:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002180359k65381c09t143d37ec5eef1cf8@mail.gmail.com>
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

On Thu, Feb 18, 2010 at 08:59:38PM +0900, jassi brar wrote:
> On Thu, Feb 18, 2010 at 7:57 PM, Mark Brown

> > =A0Like I
> > said in reply to Joonyoung it's not immediately clear to me that the
> > startup and shutdown calls should be suppressed since I'd expect that at
> > least some drivers are going to want to know about multiple uses (for
> > example, returning -EBUSY if someone tries to have too many things
> > active at once).

> IMO codecs should simply do as directed by the ASOC.

Right, but that doesn't mean that the device drivers can't do anything
useful here - in terms of restrictions they can't do anything the
hardware can't implmenent.  Another example here is that startup
function can set constraints based on the configuration of other running
links if the hardware has any limitations in that regard (some will,
some won't, and the limitations may not even be anything to do with
audio in some designs).

> The multi-instance logic has better be at one place(soc-core.c) rather th=
an
> in each codec's driver.
> For that reason I modified soc-core.c rather than my device's codec
> and cpu driver.

I'm not saying don't put anything in the core, I'm saying the change you
have implemented goes too far by completely removing the notification to
drivers.  It's not going to be possible for the core to anticipate every
possible thing that a driver might need, and unless a requirement is
common between a number of drivers it's not going to be a benefit to put
it into the core.

> > In general for a vendor BSP I'd strongly recommend against any changes
> > in the core that don't get submitted to mainline - it's more of a
> > maintinance burden and makes it harder for people to take the drivers
> > and use them with other kernel versions if they don't notice the change.

> As explained above, I thought I had a reason to do so.

If you're carrying changes that are already upstream that's fine, it's
carrying changes that are not upstream that causes problems - if the
change has gone upstream then when you rebase or merge with the upstream
version things will work themselves out.  It's changes that haven't gone
upstream that cause trouble, both in terms of maintaining them and for
users trying to do things like merge drivers from several different
sources.

Obviously there are cases where changes in generic code are a good idea,
and I'd encourage you to make such changes, all I'm saying is that I
recommend against shipping them in a vendor BSP without making sure that
they're going to be OK upstream (and ideally are actually upstream).
