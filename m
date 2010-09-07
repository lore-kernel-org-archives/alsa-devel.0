From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Tue, 07 Sep 2010 21:02:35 +0100
Message-ID: <1283889755.3048.185.camel@odin>
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
	<20100907155355.GE25830@sirena.org.uk>
	<alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id EE1412435F
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 22:08:49 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2497342ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2010 13:08:49 -0700 (PDT)
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-09-07 at 20:17 +0200, Jaroslav Kysela wrote:
> On Tue, 7 Sep 2010, Mark Brown wrote:
> 
> > On Tue, Sep 07, 2010 at 04:42:57PM +0200, Jaroslav Kysela wrote:
> >
> >> control API. I think that it might be more "easy to understand" and
> >> universal to define just sequence of commands like:
> >
> >> SectionDefaults [
> >>          exec "amixer cset name='Master Playback Switch',index=2 1,1"
> >
> > ...
> >
> >> Because "amixer cset" command will be probably most used command, we can
> >> eventually move the amixer code to alsa-lib to not create so much
> >> processes and speed-up things.
> >
> >> It means that the ucm should not track card controls, but commands for
> >> transitions.
> >
> > I don't understand the motivation here - what does this buy us?
> >
> > Looking at this from the embedded perspective I really would much rather
> > see a use case manager that understands what it's doing (rather than
> > essentially just running shell script).  This allows us to do things
> > like specify target states (rather than having to have full sequences
> > for all transitions, which is one of the things it'd be good to avoid)
> > and will allow us to take advantage of any additions to the ALSA APIs
> > for things like batching operations without changes to the per machine
> > configurations.
> >
> > Having the facility to shell out in case some non-ALSA stuff needs to be
> > done might be handy but I'd expect that for things within ALSA a tool
> > like the use case manager would understand ALSA natively.
> >
> > For embedded systems, especially those like mobile phones with extensive
> > use case requirements, the usability issues mostly come from the very
> > large numbers of controls which is at best orthogonal to shelling out to
> > amixer (or whatever) commands.
> 
> My idea is to have the most used commands working with the ALSA API 
> built directly into the ucm code to not use fork/exec so much in embedded 
> environments. 

What does this really buy us over the current (direct alsa-lib API)
code ? 

Fwiw, UCM was never intended to replace any of the alsa-utils, but to
complement them in complex audio systems (like phones).

> But I can imagine that some system configurations can use 
> this API to send events to another manager which can control another 
> parts of the system like video, input devices, network devices and so on 
> according the sound setup.

UCM is purely to abstract the audio hardware for higher level
middle-ware and applications. It's really up to the system middle-ware
and daemons here to configure/control the other subsystems in line with
the system use case.

> 
> Also, the possibility to generate the alsa-lib's configuration files at 
> run-time might be a nice feature for future. 

Fwiw, UCM is _needed_ now and I really can't emphasise this strongly
enough atm. Some embedded ODMs are even now using and shipping closed
source proprietary software for audio hardware UCM.

The UCM configuration files for embedded system will likely be very
specific to the hardware and not really suited to run time generation.
However, there is nothing stopping runtime generation with the original
file format.   

> I take UCM like a way to 
> integrate all things regarding PCM streams and mixer controls together and 
> let users / system administrators / distribution makers create the 
> abstract layers depending their requirements.
> 
> It's about flexibility.

Exactly, but there is nothing stopping flexibility with the current code
base.

Liam 
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
