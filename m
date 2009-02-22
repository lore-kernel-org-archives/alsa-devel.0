From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Standard mixer control names
Date: Sun, 22 Feb 2009 12:56:28 +0000
Message-ID: <20090222125627.GA21237@sirena.org.uk>
References: <20090221233629.GA3748@tango.0pointer.de>
	<1235304012.27887.528.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CE54A1037EC
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 13:56:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1235304012.27887.528.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 22, 2009 at 12:00:12PM +0000, Liam Girdwood wrote:
> On Sun, 2009-02-22 at 00:36 +0100, Lennart Poettering wrote:

> >  Now I'd of course prefer if the drivers
> > get fixed to use a single element naming scheme only. Is there any
> > chance to get that? And which one would that be?

> This would likely be quite time consuming wrt to embedded drivers due to
> the complex audio hardware requirements of modern mobile phones. There
> are numerous hardware routes with different inputs and outputs and they
> are used in different combinations depending on use case.

I'd worry that it'd also have a negative impact on usability.  People
setting up scenarios and doing other device specific configuration
often find it difficult to relate the controls visible in ALSA to the
chip datasheet and keeping the names for the controls as close as
possible to the datasheet helps deal with that quite a bit.  If a
standard naming were layered on top by something like the scenario
manager this wouldn't be such an issue since device specific names would
still be there and controls could be remapped dynamically depending on
use case.

What would probably also help would be exposing information about the
audio paths and how they relate to controls to user space but that
doesn't look likely to happen any time soon.
