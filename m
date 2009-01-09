From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Add initial support of Mitac mioa701
	device SoC.
Date: Fri, 9 Jan 2009 13:54:00 +0000
Message-ID: <20090109135359.GC25751@sirena.org.uk>
References: <1231440146-6669-1-git-send-email-robert.jarzmik@free.fr>
	<1231440146-6669-2-git-send-email-robert.jarzmik@free.fr>
	<20090108203324.GB29183@sirena.org.uk> <87iqopbj7r.fsf@free.fr>
	<20090109010233.GB29867@sirena.org.uk>
	<1231507238.4934.19.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 73718103816
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 14:54:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231507238.4934.19.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 09, 2009 at 01:20:38PM +0000, Liam Girdwood wrote:
> On Fri, 2009-01-09 at 01:02 +0000, Mark Brown wrote:

> > Right now my feeling is that we probably want to do at least some
> > scenario stuff in kernel space and that what's sensible for a given

> My feeling is that kernel based scenario really should be minimal to non
> existent depending upon machine. If it has to be implemented then it
> must be consistent across all devices (probably worth creating a
> sound/core/scenario.c for others to use).

Yes, that's pretty much what I'm thinking.  The kernel should have
anything required to prevent hardware damage in it but beyond that
it's getting debatable.

It also seems useful to have some support for doing a fixed rename of
controls in machine drivers to allow things like renaming of outputs and
inputs to match the connections on the machine.

I'd probably be willing to see a small amount of additional scenario
code in kernel space for cases where it's clear that the hardware can
only run in a very small number of scenarios due to the limited features
it has, especially if it ties in with stuff that needs to be done to
prevent hardware damage.  It looks like this device may well fall into
that sort of use case.

> Imho it's far better to do most scenario in userspace due to increasing
> driver complexity and slow driver scenario development speed (remember
> the OSS driver pain involved with this). Userspace will additionally

It's also policy, which on general principle shouldn't go into the
kernel anyway.  With devices like the OpenMoko it looks out you pretty
much need to have any to any routing available to user space anyway to
cover all the use cases people have so you have to have a way of doing
scenarios in user space.

> give us a consistent API for applications and hopefully much better
> adoption (esp if merged into alsa-lib / salsa).

Or adopted by things like the FSO stack.
