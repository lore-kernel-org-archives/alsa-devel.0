From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add interval timer support
Date: Wed, 03 Nov 2004 18:08:57 -0500
Message-ID: <1099523338.1617.41.camel@krustophenia.net>
References: <1095405566.19045.35.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
	 <1099511035.1617.32.camel@krustophenia.net>
	 <1099517082.1617.38.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1099517082.1617.38.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-11-03 at 16:24 -0500, Lee Revell wrote:
> On Wed, 2004-11-03 at 14:43 -0500, Lee Revell wrote:
> > OK I converted this code to use the ALSA timer API.
> 

I left this out:

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

and the patch is missing a chunk:

--- alsa-orig/alsa-kernel/pci/emu10k1/Makefile	2003-02-09 13:41:56.000000000 -0500
+++ alsa/alsa-kernel/pci/emu10k1/Makefile	2004-11-03 18:07:53.000000000 -0500
@@ -5,7 +5,7 @@
 
 snd-emu10k1-objs := emu10k1.o emu10k1_main.o \
 		    irq.o memory.o voice.o emumpu401.o emupcm.o io.o \
-		    emuproc.o emumixer.o emufx.o
+		    emuproc.o emumixer.o emufx.o timer.o
 snd-emu10k1-synth-objs := emu10k1_synth.o emu10k1_callback.o emu10k1_patch.o
 
 #





-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
