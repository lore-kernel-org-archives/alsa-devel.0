From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: add interval timer support
Date: Tue, 09 Nov 2004 23:32:52 -0500
Message-ID: <1100061173.22666.11.camel@krustophenia.net>
References: <1095405566.19045.35.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409171052300.1774@pnote.perex-int.cz>
	 <1099511035.1617.32.camel@krustophenia.net>
	 <1099517082.1617.38.camel@krustophenia.net>  <s5hu0rzqevv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0rzqevv.wl@alsa2.suse.de>
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
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-11-09 at 15:24 +0100, Takashi Iwai wrote:
> At Wed, 03 Nov 2004 16:24:41 -0500,
> Lee Revell wrote:
> > 
> > On Wed, 2004-11-03 at 14:43 -0500, Lee Revell wrote:
> > > OK I converted this code to use the ALSA timer API.
> > 
> > Here is the patch against ALSA CVS.  I tested it with the ALSA from
> > kernel 2.6.9-rc3-mm3 because CVS does not build currently.
> 
> The patch to include/emu10k1.h is missing, too.
> Could you give it?
> 
> 

Sorry, here it is.

Index: alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.49
diff -u -r1.49 emu10k1.h
--- alsa-kernel/include/emu10k1.h	30 Oct 2004 07:44:19 -0000	1.49
+++ alsa-kernel/include/emu10k1.h	10 Nov 2004 04:32:30 -0000
@@ -31,6 +31,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/util_mem.h>
 #include <sound/pcm-indirect.h>
+#include <sound/timer.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
 
@@ -1000,6 +1001,8 @@
 	snd_pcm_substream_t *pcm_capture_mic_substream;
 	snd_pcm_substream_t *pcm_capture_efx_substream;
 
+	snd_timer_t *timer;
+
 	emu10k1_midi_t midi;
 	emu10k1_midi_t midi2; /* for audigy */
 
@@ -1019,6 +1022,7 @@
 int snd_emu10k1_pcm_efx(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_fx8010_pcm(emu10k1_t * emu, int device, snd_pcm_t ** rpcm);
 int snd_emu10k1_mixer(emu10k1_t * emu);
+int snd_emu10k1_timer(emu10k1_t * emu, int device);
 int snd_emu10k1_fx8010_new(emu10k1_t *emu, int device, snd_hwdep_t ** rhwdep);
 
 irqreturn_t snd_emu10k1_interrupt(int irq, void *dev_id, struct pt_regs *regs);




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
