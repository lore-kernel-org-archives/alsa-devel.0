From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 7 Sep 2010 19:53:58 +0100
Message-ID: <20100907185358.GA1125@rakim.wolfsonmicro.main>
References: <1282640988.3053.43.camel@odin>
	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<20100907155355.GE25830@sirena.org.uk>
	<alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4950103876
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 20:53:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 08:17:19PM +0200, Jaroslav Kysela wrote:
> On Tue, 7 Sep 2010, Mark Brown wrote:

> >>SectionDefaults [
> >>         exec "amixer cset name='Master Playback Switch',index=2 1,1"
> >

> My idea is to have the most used commands working with the ALSA API
> built directly into the ucm code to not use fork/exec so much in
> embedded environments. But I can imagine that some system

I'm not sure how this follows on from what you're proposing above?  You
appear to be proposing the replacement of the lists of control settings
with shell commands, then later on optimising those forks busybox style
by building the relevant binaries into the library.

Currently outside of the explict sequences provided to override the
default transitions the use case manager configurations are declarative
rather than ordering based.  This lets the user specify end states and
lets the use case manager code work out the best way to accomplish those
configurations which seems like a valuable property.

> configurations can use this API to send events to another manager
> which can control another parts of the system like video, input
> devices, network devices and so on according the sound setup.

I do agree that this may be useful but I don't see that we need to
rewrite the ALSA control management bit of things for that, the
declarative style seems like a win there.  I also feel that it may make
more sense to do this externally to this library in a higher level tool
which controls both this and other things.

> Also, the possibility to generate the alsa-lib's configuration files
> at run-time might be a nice feature for future. I take UCM like a

This might be useful, though I'd expect that Pulse might be more useful
for a lot of systems.

> way to integrate all things regarding PCM streams and mixer controls
> together and let users / system administrators / distribution makers
> create the abstract layers depending their requirements.

That's my understanding of what the idea is.

> It's about flexibility.

As I said above I'm concerned that you're trying to move this into
something which is much more of a system level use case manager than an
audio specific one, and limiting the audio domain as part of that.  If
we're doing too much of that then we're into the domain of the system
level software that would be driving the UCM.
