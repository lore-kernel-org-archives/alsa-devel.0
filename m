From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA driver 1.0.2c: divide by zero oops
Date: Thu, 18 Mar 2004 09:58:17 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403180957250.1835@pnote.perex-int.cz>
References: <200403172230.i2HMUKu09754@sprite.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403172230.i2HMUKu09754@sprite.physics.adelaide.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Mar 2004, Jonathan Woithe wrote:

> I did this last night.  The following is my analysis of the problem.
> 
> With full debug selected, the only message reported by the ALSA system is
>   ALSA ../alsa-kernel/core/pcm_timer.c:70: BUG? (rate != 0) 
>   (called from d8c33a79)
> That is, the assertion "rate!=0" fails.  This confirms the reported oops
> trigger (that is, divide by zero).

Could you add exactly same initialization sequence to 
alsa-oss/test/testoss.c code? So we can debug easily the problem here.
Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
