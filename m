From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: emu10k1 multichannel playback design (was Re: [PATCH] emu10k1: add interval timer support)
Date: Sat, 25 Sep 2004 23:15:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409260315.i8Q3FUMg005327@localhost.localdomain>
References: <1096167105.1357.5.camel@krustophenia.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 25 Sep 2004 22:51:46 EDT."
             <1096167105.1357.5.camel@krustophenia.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>OK, I fixed the voice allocator to handle multichannel PCM.  Now it
>looks like the prepare callback is being called over and over in a loop.

   [ ... ]

>I am still missing parts of the driver, like the interrupt handler.  But
>it seems like the prepare callback should not loop this way.  Am I doing
>something wrong?

i would finish the driver before getting too deeply into this. the
interrupt handler is sorta-kinda important :)

jack has other ways of detecting timeouts, for example, and it may be
really calling the prepare callback many times.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
