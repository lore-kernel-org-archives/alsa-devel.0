From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/2] soc-dapm or TWL4030: Runtime DAPM
	ordering problem
Date: Tue, 3 Aug 2010 09:39:44 +0100
Message-ID: <20100803083944.GB25306@rakim.wolfsonmicro.main>
References: <1280732895-29010-1-git-send-email-peter.ujfalusi@nokia.com>
	<201008021359.11636.peter.ujfalusi@nokia.com>
	<3C7676DA-EAAB-4C56-AD3A-2537EFEDF056@opensource.wolfsonmicro.com>
	<201008030915.37405.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB3D9103889
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 10:39:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008030915.37405.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 03, 2010 at 09:15:12AM +0300, Peter Ujfalusi wrote:

> We do have different register write sequences, which means that we could have 
> different type of pop depending on the current sequence.
> In startup (playback/capture/bypass) we most likely have pop from components 
> powering up, while during active state (and changing the routings) we might need 
> to deal with the pop coming from components turning off.

Good, this is the sort of analysis we need to make a change to DAPM
itself.  I don't think it's resonable to say that the active->active
changes are primarily concerned with powerdown pops, though - if you're
making a change where you're adding in a new source then obviously the
powerup of the path is going to be relevant.

I think there's something useful we can do with DAPM here (independantly
of anything in TWL4030), probably involving splitting up the routing
change walk to run power down first and then power up but the current
patch feels like it's going to cause at least as many problems as it
solves.

> Because of the ordering change, in runtime this causes problems, since the 
> DAPM_MUX's POST_REG comes as the last thing in the sequence.

You keep saying "ordering change" but I'm still not clear what you mean
by this?  Are you just talking about the fact that things end up
happening in different orders for the active->active transitions or do
you see some active reordering of things in the code?

> I only need one of the two patch, and my bet goes for the fix within the twl4030 
> codec driver, but I do wanted to bring up the root cause of this problem 
> (surfaced with my codec driver). 

Honestly, looking at the TWL4030 specific patch it looks like a better
idea anyway regardless of any changes to the core since it's just moving
from the use of an event to pure DAPM widgets which is generally a more
robust approach.  Events generally cause hassle if they're doing much
more than implementing multi-write sequences for turning the widget on
and off.

If you could provide a version of the patch with a standalone changelog
I think I'd ack it.
