From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [PATCH] emu10k1: add interval timer support
Date: Fri, 24 Sep 2004 11:26:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409241526.i8OFQF6Y029838@localhost.localdomain>
References: <s5hk6uj3dko.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Fri, 24 Sep 2004 17:13:11 +0200."
             <s5hk6uj3dko.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> more to the point, perhaps, is that the very first implementation of
>> the RME Hammerfall (digi9652) driver that i did took lee's approach
>> and when we measured it, there was a very definite performance
>> hit. having to call the "elapsed" function for every mono stream added
>> measurable overhead. when we collapsed it back to a single
>> non-interleaved, 26 channel device, it was significantly more
>> efficient.
>
>It's a good point.  If you use the timer-style irq, the perfomance
>decrease would be smaller, though, because you don't (can't) get irqs
>per PCM stream.  However, the overhead must still exist.

it was the same with the digi9652 - one interrupt source per card
card, but the elapsed callback had to be made to each stream.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
