From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 19:27:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305291925460.28435-100000@pnote.perex-int.cz>
References: <E19LPK5-0006xv-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19LPK5-0006xv-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: d <dieb13@klingt.org>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 29 May 2003, Paul Davis wrote:

> >ok, since i'm more a musician than a kernel-hacker, i don't exactly know 
> >what to do with the panic output.
> >i see EIP: 0010:[<c0280005>] and search for it in /var/log/ksymoops right?
> >there i find
> >...
> >c0106298 __up_wakeup
> >c02bfff4 csum_partial_copy_generic_Rsmp_e8aa9a96
> 
> ah. are you running on an SMP system with current ALSA CVS? if so, its
> broken within the "core" of ALSA. you will need to back up to April
> 27th to get a working SMP version. nobody has a fix for this at this
> time, despite the fact that it makes ALSA unusable on an SMP system.

Anybody is willing to turn spinlock debugging in SMP kernel? I posted 
twice the guide... Edit linux/include/linux/spinlock.h:

#define DEBUG_SPINLOCKS 0       /* 0 == no debugging, 1 == maintain lock state, 2 == full debug */

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
