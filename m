From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 multichannel playback design (was Re:
	[PATCH] emu10k1: add interval timer support)
Date: Sat, 25 Sep 2004 23:50:30 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096170629.1357.19.camel@krustophenia.net>
References: <200409260315.i8Q3FUMg005327@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409260315.i8Q3FUMg005327@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-09-25 at 23:15, Paul Davis wrote:
> >OK, I fixed the voice allocator to handle multichannel PCM.  Now it
> >looks like the prepare callback is being called over and over in a loop.
> 
>    [ ... ]
> 
> >I am still missing parts of the driver, like the interrupt handler.  But
> >it seems like the prepare callback should not loop this way.  Am I doing
> >something wrong?
> 

The interrupt handler fortunately was a one liner.  All I have left is
the pointer callback and it should work.

I am really amazed at how much better ALSA is than OSS now.  Most of the
code in the OSS driver is not needed in the ALSA driver because the
middle layer is so powerful.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
