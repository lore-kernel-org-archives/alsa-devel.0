From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [PATCH] emu10k1: add interval timer support
Date: Wed, 22 Sep 2004 12:17:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409221212210.166@pnote.perex-int.cz>
References: <1095405566.19045.35.camel@krustophenia.net>
 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
 <1095795402.13220.21.camel@krustophenia.net> <s5hacvizjzv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacvizjzv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Sep 2004, Takashi Iwai wrote:

> > You would then use an .asoundrc plugin that would look like a 16 channel
> > PCM device, and would consist of 16 mono channels, hw:x,x,0 through
> > hw:x,x,15.
> 
> Maybe I didn't get your point, but why not simply provide a 16-channel
> non-interleaved device?

Yes, I agree here with Takashi.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
