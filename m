From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] Detection of Audigy 2 ZS
Date: Wed, 14 Jul 2004 12:43:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089823407.2104.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Detect Augigy2 ZS (emu->model == 0x2002).
Fix typo in log message and some magic numbers. 

Index: pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.35
diff -u -r1.35 emu10k1_main.c
--- pci/emu10k1/emu10k1_main.c  29 Jun 2004 16:10:33 -0000      1.35
+++ pci/emu10k1/emu10k1_main.c  14 Jul 2004 16:42:38 -0000
@@ -119,8 +119,10 @@
        snd_emu10k1_ptr_write(emu, SOLEH, 0, 0);
 
        if (emu->audigy){
-               snd_emu10k1_ptr_write(emu, 0x5e, 0, 0xf00); /* ?? */
-               snd_emu10k1_ptr_write(emu, 0x5f, 0, 0x3); /* ?? */
+               /* set SPDIF bypass mode */
+               snd_emu10k1_ptr_write(emu, SPBYPASS, 0, SPBYPASS_FORMAT);
+               /* enable rear left + rear right AC97 slots */
+               snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_REAR_RIGHT | AC97SLOT_REAR_LEFT);
        }
 
        /* init envelope engine */
@@ -329,7 +331,7 @@
        if (emu->audigy)
                snd_emu10k1_ptr_write(emu, A_DBG, 0, A_DBG_SINGLE_STEP);
        else
-               snd_emu10k1_ptr_write(emu, DBG, 0, 0x8000);
+               snd_emu10k1_ptr_write(emu, DBG, 0, EMU10K1_DBG_SINGLE_STEP);
 
        /* disable channel interrupt */
        snd_emu10k1_ptr_write(emu, CLIEL, 0, 0);
@@ -682,12 +684,13 @@
                /* Audigy 2 EX has apparently no effective AC97 controls
                 * (for both input and output), so we skip the AC97 detections
                 */
-               snd_printdd(KERN_INFO "Audigy2 EX is detected. skpping ac97.\n");
+               snd_printdd(KERN_INFO "Audigy2 EX is detected. skipping ac97.\n");
                emu->no_ac97 = 1;
        }
 
-       if (emu->revision == 4) {
-               /*  FIXME - Audigy 2 ZS detection */
+       if (emu->revision == 4 && emu->model == 0x2002) {
+               /* Audigy 2 ZS */
+               snd_printdd(KERN_INFO "Audigy2 ZS is detected. setting 7.1 mode.\n");
                emu->spk71 = 1;
        }
 




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
