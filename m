From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Fw: [Bugme-new] [Bug 1708] New: alsa gus max driver destroying
 data in filesystems
Date: Sat, 20 Dec 2003 10:27:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312201021530.8959@pnote.perex-int.cz>
References: <20031219192218.072a9429.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA07775
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2003 10:31:56 +0100
In-Reply-To: <20031219192218.072a9429.akpm@osdl.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, jtorres@sia.es
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Dec 2003, Andrew Morton wrote:

> umm, we're calling schedule() from a hard IRQ.

Oops. It wasn't intented. The patch bellow should solve this problem.
Andrew, what's the best method to send you all the new ALSA code?
We have many fixes for the PCM OSS emulation code and various drivers
were updated.

Our BK repository is at http://linux-sound.bkbits.net/linux-sound.


Index: gus_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/gus_pcm.c,v
retrieving revision 1.17
diff -u -r1.17 gus_pcm.c
--- gus_pcm.c	17 Nov 2003 10:23:40 -0000	1.17
+++ gus_pcm.c	20 Dec 2003 09:28:11 -0000
@@ -334,9 +334,11 @@
 					snd_gf1_poke(gus, pos++, *buf++ ^ invert);
 			}
 		}
-		schedule_timeout(1);
-		if (signal_pending(current))
-			return -EAGAIN;
+		if (count > 0 && !in_interrupt()) {
+			schedule_timeout(1);
+			if (signal_pending(current))
+				return -EAGAIN;
+		}
 	}
 	return 0;
 }

> Date: Fri, 19 Dec 2003 14:39:34 -0800
> From: bugme-daemon@osdl.org
> To: bugme-new@lists.osdl.org
> Subject: [Bugme-new] [Bug 1708] New: alsa gus max driver destroying data in filesystems
> 
> 
> http://bugme.osdl.org/show_bug.cgi?id=1708
> 
>            Summary: alsa gus max driver destroying data in filesystems
>     Kernel Version: 2.6.0
>             Status: NEW
>           Severity: high
>              Owner: drivers_sound@kernel-bugs.osdl.org
>          Submitter: jtorres@sia.es

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
