From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 7 Sep 2010 23:43:45 +0100
Message-ID: <20100907224345.GB21003@opensource.wolfsonmicro.com>
References: <alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<20100907155355.GE25830@sirena.org.uk>
	<alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
	<1283889755.3048.185.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6B3024458
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 00:43:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1283889755.3048.185.camel@odin>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 09:02:35PM +0100, Liam Girdwood wrote:
> On Tue, 2010-09-07 at 20:17 +0200, Jaroslav Kysela wrote:

> > Also, the possibility to generate the alsa-lib's configuration files at 
> > run-time might be a nice feature for future. 

> Fwiw, UCM is _needed_ now and I really can't emphasise this strongly
> enough atm. Some embedded ODMs are even now using and shipping closed
> source proprietary software for audio hardware UCM.

Now you mention this I feel remiss for not pointing it out before.  I'm
also working with many system manufacturers including smartphone vendors
(they're the people who are *really* suffering here) and a lot of them
have a use case problem to some degree.  There's two key issues I see
people having problems with:

 - Coming up with an abstraction for an audio use case which can be used
   to think about the possbilities for configuring ALSA and implementing
   the mechanics of it.  UCM pretty much deals with this.

 - Generating and maintaining use cases.  UCM provides a good start on
   this in itself - simply having the suggested way of thinking about
   things is a win, never mind the tools - and having the standard
   format is pretty much a requirement for doing any more tools work.

A procedural approach is a common solution but it makes both problems
harder, especially the second one since it means that every time you
think about a use case you must think about the mechanics of moving into
and out of it rather than just thinking about the configuration you want
to achieve.

> The UCM configuration files for embedded system will likely be very
> specific to the hardware and not really suited to run time generation.
> However, there is nothing stopping runtime generation with the original
> file format.   

For an example of the sort of system complexity one is dealing with in
the smartphone use case the WM8994 is an example of the sort of feature
set you can see in the audio CODEC alone:

   http://www.wolfsonmicro.com/products/WM8994

Trying to autogenerate the configuration for a system like this is
likely at best give a first pass result since the actual configurations
end up depending on not only your current use case but also the other
use cases you might want to use in the future.
