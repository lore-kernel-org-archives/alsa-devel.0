From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: snd-ioctl32 is failing on x86_64 (no crashes, just errors)
Date: Tue, 11 Jan 2005 01:15:59 +0900
Message-ID: <20050110161559.GA248292@lion.gg3.net>
References: <20050106130649.GA253131@lion.gg3.net> <s5h1xcxy0tj.wl@alsa2.suse.de> <20050108074026.GA8595@lion.gg3.net> <s5h7jmlv82j.wl@alsa2.suse.de> <20050110123342.GA243173@lion.gg3.net> <s5hwtultnc8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tiger.gg3.net (142.13.111.219.st.bbexcite.jp [219.111.13.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D56CE2AD
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 17:16:01 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5hwtultnc8.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

maillog: 10/01/2005-14:39:35(+0100): Takashi Iwai types
> At Mon, 10 Jan 2005 21:33:42 +0900, Georgi Georgiev wrote:
> > Jan 10 21:08:24 lion ioctl32(amixer:243138): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc610) on /dev/snd/controlC0
> > Jan 10 21:08:27 lion ioctl32(amixer:243139): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc600) on /dev/snd/controlC0
> > Jan 10 21:21:06 lion ioctl32(amixer:243280): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc670) on /dev/snd/controlC0
> > Jan 10 21:21:09 lion ioctl32(amixer:243281): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc670) on /dev/snd/controlC0
> > 
> > though the error message is quite different than the printk above, it
> > could still be helpful.
> 
> ... or, this can be the real problem.  It looks the struct size
> doesn't match.  Could you try the attached patch?

Except for the following small typo:

-}_ _attribute((packed));
+} __attribute((packed));

your patch worked just fine. The 32-bit amixer produces meaningful
output and RealPlayer is able to play sound on my system now.

Thanks a lot.

> Index: alsa-kernel/core/ioctl32/ioctl32.c
> ===================================================================
> RCS file: /suse/tiwai/cvs/alsa/alsa-kernel/core/ioctl32/ioctl32.c,v
> retrieving revision 1.30
> diff -u -r1.30 ioctl32.c
> --- alsa-kernel/core/ioctl32/ioctl32.c	15 Dec 2004 15:26:24 -0000	1.30
> +++ alsa-kernel/core/ioctl32/ioctl32.c	10 Jan 2005 13:36:49 -0000
> @@ -238,7 +238,7 @@
>  		struct sndrv_aes_iec958 iec958;
>          } value;
>          unsigned char reserved[128];
> -};
> +}_ _attribute__((packed));
>  
>  
>  /* hmm, it's so hard to retrieve the value type from the control id.. */

-- 
-*   Georgi Georgiev   -* BOFH Excuse #318: Your EMAIL is now being    -*
*-    chutz@gg3.net    *- delivered by the USPS.                       *-
-*  +81(90)6266-1163   -*                                              -*


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
