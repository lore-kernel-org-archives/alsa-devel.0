From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] emu10k1: split snd_emu10k1_trigger_voice into trigger and
 prepare functions
Date: Fri, 11 Feb 2005 18:16:40 -0500
Message-ID: <1108163800.20365.82.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This patch provides better sync between multiple voices by separating
the trigger_voice function into prepare_voice which sets up the volume
and filter parameters and trigger_voice which sets pitch target, current
and initial pitch and enables the voice interrupt.  For standard PCM
this should not make much of a difference but will be important for
minimizing phase error between voices for multichannel PCM.

This behavior was derived from the opensource.creative.com driver.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Lee

Index: alsa-cvs-default-test/alsa-kernel/pci/emu10k1/emupcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emupcm.c,v
retrieving revision 1.37
diff -u -r1.37 emupcm.c
--- alsa-cvs-default-test/alsa-kernel/pci/emu10k1/emupcm.c	10 Feb 2005 11:52:51 -0000	1.37
+++ alsa-cvs-default-test/alsa-kernel/pci/emu10k1/emupcm.c	11 Feb 2005 21:27:21 -0000
@@ -510,35 +510,50 @@
 	snd_emu10k1_ptr_write(emu, CCR_CACHEINVALIDSIZE, voice, ccis);
 }
 
-static void snd_emu10k1_playback_trigger_voice(emu10k1_t *emu, emu10k1_voice_t *evoice, int master, int extra)
+static void snd_emu10k1_playback_prepare_voice(emu10k1_t *emu, emu10k1_voice_t *evoice, int master, int extra)
 {
 	snd_pcm_substream_t *substream;
 	snd_pcm_runtime_t *runtime;
 	emu10k1_pcm_mixer_t *mix;
-	unsigned int voice, pitch, pitch_target, tmp;
 	unsigned int attn;
+	unsigned int voice, tmp;
 
 	if (evoice == NULL)	/* skip second voice for mono */
 		return;
 	substream = evoice->epcm->substream;
 	runtime = substream->runtime;
-	mix = &emu->pcm_mixer[substream->number];
 	voice = evoice->number;
-	pitch = snd_emu10k1_rate_to_pitch(runtime->rate) >> 8;
-	pitch_target = emu10k1_calc_pitch_target(runtime->rate);
+	mix = &emu->pcm_mixer[substream->number];
+
 	attn = extra ? 0 : 0x00ff;
 	tmp = runtime->channels == 2 ? (master ? 1 : 2) : 0;
 	snd_emu10k1_ptr_write(emu, IFATN, voice, attn);
 	snd_emu10k1_ptr_write(emu, VTFT, voice, (mix->attn[tmp] << 16) | 0xffff);
 	snd_emu10k1_ptr_write(emu, CVCF, voice, (mix->attn[tmp] << 16) | 0xffff);
-	snd_emu10k1_voice_clear_loop_stop(emu, voice);		
-	if (extra)
-		snd_emu10k1_voice_intr_enable(emu, voice);
 	snd_emu10k1_ptr_write(emu, DCYSUSV, voice, 0x7f7f);
+	snd_emu10k1_voice_clear_loop_stop(emu, voice);
+}	
+
+static void snd_emu10k1_playback_trigger_voice(emu10k1_t *emu, emu10k1_voice_t *evoice, int master, int extra)
+{
+	snd_pcm_substream_t *substream;
+	snd_pcm_runtime_t *runtime;
+	unsigned int voice, pitch, pitch_target, tmp;
+
+	if (evoice == NULL)	/* skip second voice for mono */
+		return;
+	substream = evoice->epcm->substream;
+	runtime = substream->runtime;
+	voice = evoice->number;
+
+	pitch = snd_emu10k1_rate_to_pitch(runtime->rate) >> 8;
+	pitch_target = emu10k1_calc_pitch_target(runtime->rate);
 	snd_emu10k1_ptr_write(emu, PTRX_PITCHTARGET, voice, pitch_target);
 	if (master)
 		snd_emu10k1_ptr_write(emu, CPF_CURRENTPITCH, voice, pitch_target);
 	snd_emu10k1_ptr_write(emu, IP, voice, pitch);
+	if (extra)
+		snd_emu10k1_voice_intr_enable(emu, voice);
 }
 
 static void snd_emu10k1_playback_stop_voice(emu10k1_t *emu, emu10k1_voice_t *evoice)
@@ -573,6 +588,9 @@
 		snd_emu10k1_playback_invalidate_cache(emu, epcm->voices[0]);
 		/* follow thru */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[0], 1, 0);
+		snd_emu10k1_playback_prepare_voice(emu, epcm->voices[1], 0, 0);
+		snd_emu10k1_playback_prepare_voice(emu, epcm->extra, 1, 1);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->voices[0], 1, 0);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->voices[1], 0, 0);
 		snd_emu10k1_playback_trigger_voice(emu, epcm->extra, 1, 1);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
