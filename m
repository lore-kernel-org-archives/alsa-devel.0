From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 14:53:30 -0600
Message-ID: <AANLkTim_Q=oTfHS33R2hf6B3gC1Dj2fpiCAjfa7kJFw7@mail.gmail.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
	<20110121164329.GB6200@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 405D02433E
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 21:53:33 +0100 (CET)
Received: by iwb12 with SMTP id 12so2289391iwb.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 12:53:30 -0800 (PST)
In-Reply-To: <20110121164329.GB6200@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

>> I am fine with a system-specific configuration file for each use case,
>> but if I have to change the defines in alsa-lib it's a bit of a pain.
>> It'll imply branches and specific packages just for a stupid include
>> file.
>
> If the define isn't there you should just be able to use a string - no
> need to update the header file unless the thing being added is
> sufficiently general that it seems like a good idea.

I think I am missing something here.
First I believe there's only one application (PulseAudio or resource
management of some sort) that will talk to UCM. Player applications
shouldn't know anything about UCM, right? You would end-up making
conflicting decisions.
Next, if everyone can add #defines and craft new strings to represent
verbs, this central application/module will either ask for use cases
that are not supported everywhere, or limit itself to 'common' use
cases. Or do we expect to rewrite this on each and every platform?
Wouldn't it make sense to avoid branches and proliferation by limiting
the definition of use cases and instead only allow for changes in
configuration files?
