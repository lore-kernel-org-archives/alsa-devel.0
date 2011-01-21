From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 23:37:05 +0000
Message-ID: <1295653025.3348.697.camel@odin>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
	<20110121164329.GB6200@opensource.wolfsonmicro.com>
	<AANLkTim_Q=oTfHS33R2hf6B3gC1Dj2fpiCAjfa7kJFw7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 8BD5224439
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 00:37:10 +0100 (CET)
Received: by wyi11 with SMTP id 11so2364851wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 15:37:08 -0800 (PST)
In-Reply-To: <AANLkTim_Q=oTfHS33R2hf6B3gC1Dj2fpiCAjfa7kJFw7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-21 at 14:53 -0600, pl bossart wrote:
> >> I am fine with a system-specific configuration file for each use case,
> >> but if I have to change the defines in alsa-lib it's a bit of a pain.
> >> It'll imply branches and specific packages just for a stupid include
> >> file.
> >
> > If the define isn't there you should just be able to use a string - no
> > need to update the header file unless the thing being added is
> > sufficiently general that it seems like a good idea.
> 
> I think I am missing something here.
> First I believe there's only one application (PulseAudio or resource
> management of some sort) that will talk to UCM. Player applications
> shouldn't know anything about UCM, right? You would end-up making
> conflicting decisions.

Yes, it's intended only Pulseaudio (or similar) will directly control
the use case.

> Next, if everyone can add #defines and craft new strings to represent
> verbs, this central application/module will either ask for use cases
> that are not supported everywhere, or limit itself to 'common' use
> cases. Or do we expect to rewrite this on each and every platform?
> Wouldn't it make sense to avoid branches and proliferation by limiting
> the definition of use cases and instead only allow for changes in
> configuration files?

The intention is to add all the reasonable use case types to the ucm
header. We should still support bespoke use cases, but we should aim to
include as many popular use cases as possible in ucm. I was only
thinking of phone related use cases when devising the original verbs.

Please do send a patch for any additional verbs you can think off :)

Thanks

Liam

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
