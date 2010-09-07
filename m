From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 7 Sep 2010 16:53:55 +0100
Message-ID: <20100907155355.GE25830@sirena.org.uk>
References: <1282580239-10549-1-git-send-email-lrg@slimlogic.co.uk>
	<alpine.LNX.2.00.1008231907170.10278@eeebox2.perex-int.cz>
	<1282640988.3053.43.camel@odin>
	<alpine.LNX.2.00.1008250925540.10278@eeebox2.perex-int.cz>
	<1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E1B0244E0
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 17:53:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
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

On Tue, Sep 07, 2010 at 04:42:57PM +0200, Jaroslav Kysela wrote:

> control API. I think that it might be more "easy to understand" and 
> universal to define just sequence of commands like:

> SectionDefaults [
>          exec "amixer cset name='Master Playback Switch',index=2 1,1"

...

> Because "amixer cset" command will be probably most used command, we can 
> eventually move the amixer code to alsa-lib to not create so much 
> processes and speed-up things.

> It means that the ucm should not track card controls, but commands for 
> transitions.

I don't understand the motivation here - what does this buy us?

Looking at this from the embedded perspective I really would much rather
see a use case manager that understands what it's doing (rather than
essentially just running shell script).  This allows us to do things
like specify target states (rather than having to have full sequences
for all transitions, which is one of the things it'd be good to avoid)
and will allow us to take advantage of any additions to the ALSA APIs
for things like batching operations without changes to the per machine
configurations.

Having the facility to shell out in case some non-ALSA stuff needs to be
done might be handy but I'd expect that for things within ALSA a tool
like the use case manager would understand ALSA natively.

For embedded systems, especially those like mobile phones with extensive
use case requirements, the usability issues mostly come from the very
large numbers of controls which is at best orthogonal to shelling out to
amixer (or whatever) commands.
