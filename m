From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] Enable low latency EFX capture on emu10k1
Date: Wed, 14 Jul 2004 02:22:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089786178.3360.7.camel@mindpipe>
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

The following patch fixes EFX capture on the emu10k1.  The
capture_period_sizes table is in bytes, but the hardware constraint was
being set in frames.

I tested 4 channel recording with a capture period of 64 frames (64
frames x 2 bytes/sample x 4 channels = 512, the lowest power of 2
capture period allowed).

Lee

Index: alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.29
diff -u -r1.29 emupcm.c
--- alsa-kernel/pci/emu10k1/emupcm.c    1 Jul 2004 09:22:16 -0000       1.29
+++ alsa-kernel/pci/emu10k1/emupcm.c    14 Jul 2004 06:14:38 -0000
@@ -852,7 +852,7 @@
        runtime->hw = snd_emu10k1_capture;
        emu->capture_interrupt = snd_emu10k1_pcm_ac97adc_interrupt;
        emu->pcm_capture_substream = substream;
-       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
+       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_capture_period_sizes);
        snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_capture_rates);
        return 0;
 }
@@ -891,7 +891,7 @@
        runtime->hw.channels_min = 1;
        emu->capture_mic_interrupt = snd_emu10k1_pcm_ac97mic_interrupt;
        emu->pcm_capture_mic_substream = substream;
-       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
+       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_capture_period_sizes);
        return 0;
 }
 
@@ -942,7 +942,7 @@
        spin_unlock_irqrestore(&emu->reg_lock, flags);
        emu->capture_efx_interrupt = snd_emu10k1_pcm_efx_interrupt;
        emu->pcm_capture_efx_substream = substream;
-       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
+       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, &hw_constraints_capture_period_sizes);
        return 0;
 }
 




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
