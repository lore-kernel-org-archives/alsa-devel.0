From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Thu, 9 Sep 2010 13:16:36 +0100
Message-ID: <20100909121636.GC25855@rakim.wolfsonmicro.main>
References: <1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<20100907155355.GE25830@sirena.org.uk>
	<alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
	<20100907185358.GA1125@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.1009080954530.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDADB2442E
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 14:16:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009080954530.10278@eeebox2.perex-int.cz>
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

On Wed, Sep 08, 2010 at 10:19:45AM +0200, Jaroslav Kysela wrote:

> I understand the motivation to create a layer for phone or similar
> embedded devices which uses usually all streams from the one
> process.

> But what about more concurrent processes? The state handling in the
> current implementation is per process, so another process just
> overwrite blindly the control values set by the first process.

You really need one single thing to own the physical audio device
configuration, even on a desktop.  On a desktop system that'd be
PulseAudio normally since applications end up talking to PulseAudio
rather than the hardware directly so only PulseAudio is actually
directly concerned with the hardware setup.  On an embedded system it'd
quite frequently be PulseAudio as well but obviously it will differ on
some systems.

> Another question is how to handle collisions.

This is the core issue which forces some central thing owning the policy
decisions on a system wide basis - something needs to take policy
decisions about what's happening.

The focus for UCM is providing a model for thinking about configurations
and the mechanics of applying them, which are the areas of the problem
which are well understood and shared by all implementations.  Mechanisms
for actually deciding on what the policy is and dealing with contention
for the hardware are very much open questions at the minute even on
desktops so keeping the solutions in that area separate to the bits that
are well understood allows flexibility in these more contentious areas.

Again, assuming that there's a substantial difference between embedded
and desktop systems isn't really reflecting the reality of actual
systems these days - they're all on a continuum and in many cases the
standardisation of hardware in desktop systems means they will be more
simple rather than less simple than embedded systems.
