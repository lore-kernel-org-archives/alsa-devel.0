From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [patch] pcm-record (was cs46xx record (Thinkpad
 A22) => deadlock)
Date: Wed, 30 Oct 2002 21:33:26 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210302132490.611-100000@pnote.perex-int.cz>
References: <s5hela7bxsk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hela7bxsk.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Oct 2002, Takashi Iwai wrote:

> At Tue, 29 Oct 2002 15:07:41 +0100,
> Wilfried Weissmann wrote:
> > 
> > [1  <text/plain; us-ascii (7bit)>]
> > I dug a little around in the code. The infinitive loop was caused by 
> > being stuck in DRAINING mode. snd_pcm_lib_read1() returns -EPIPE in this 
> > case (pcm_lib.c: 2146). Then we return to snd_pcm_oss_read3() which 
> > continues to call this function until jdoomsday (= SysRq+b). I changed 
> > the code to call snd_pcm_update_hw_ptr() before that. The patch is 
> > attached. It *seems* to fix it. You want to have a _real_ close look at 
> > that if you want to apply the patch, as it is just a shot in the dark. 
> > At least I know now that the problem is (I figured it out by inserting 
> > printk).
> 
> looks correct.  applied to cvs now.

It's wrong. I reverted the change and included new updated code for the 
OSS emulation.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
