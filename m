From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: UCM questions
Date: Sun, 23 Jan 2011 14:49:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101231440220.6272@eeebox2.perex-int.cz>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<AANLkTinxwo_GErQroF4S-_z3G0UyT2sD4nBVbXVJz122@mail.gmail.com>
	<20110121164329.GB6200@opensource.wolfsonmicro.com>
	<AANLkTim_Q=oTfHS33R2hf6B3gC1Dj2fpiCAjfa7kJFw7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 11B4424430
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 14:49:05 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, 21 Jan 2011, pl bossart wrote:

>>> I am fine with a system-specific configuration file for each use case,
>>> but if I have to change the defines in alsa-lib it's a bit of a pain.
>>> It'll imply branches and specific packages just for a stupid include
>>> file.
>>
>> If the define isn't there you should just be able to use a string - no
>> need to update the header file unless the thing being added is
>> sufficiently general that it seems like a good idea.
>
> I think I am missing something here.
> First I believe there's only one application (PulseAudio or resource
> management of some sort) that will talk to UCM. Player applications
> shouldn't know anything about UCM, right?

Because UCM (as another level on top of standard devices) nicely handles 
the mixer/pcm issues (volume control, signal routing, signal parameters), 
I would assue that this layer might be used everywhere.

> You would end-up making conflicting decisions.

This is something which should be improved in the future UCM code updates. 
The UCM code should return an error and reduce returned UCM lists if 
another application uses some conflicting resources.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
