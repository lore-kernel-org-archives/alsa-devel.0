From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] OPL4 fixes
Date: Mon, 16 Jun 2003 09:04:45 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306160903150.27784-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- cache more registers
- when initializing a voice, set the direct level bit to prevent
  interpolating from the previous level


Index: alsa-kernel/drivers/opl4/opl4_local.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl4/opl4_local.h,v
retrieving revision 1.1
diff -u -r1.1 opl4_local.h
--- alsa-kernel/drivers/opl4/opl4_local.h	23 May 2003 11:15:12 -0000	1.1
+++ alsa-kernel/drivers/opl4/opl4_local.h	16 Jun 2003 06:57:37 -0000
@@ -163,8 +163,10 @@
 	int note;
 	int velocity;
 	const opl4_sound_t *sound;
+	u8 level_direct;
 	u8 reg_f_number;
 	u8 reg_misc;
+	u8 reg_lfo_vibrato;
 } opl4_voice_t;

 struct opl4 {
Index: alsa-kernel/drivers/opl4/opl4_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/opl4/opl4_synth.c,v
retrieving revision 1.2
diff -u -r1.2 opl4_synth.c
--- alsa-kernel/drivers/opl4/opl4_synth.c	23 May 2003 16:01:52 -0000	1.2
+++ alsa-kernel/drivers/opl4/opl4_synth.c	16 Jun 2003 06:57:37 -0000
@@ -267,11 +267,6 @@
 	  2,  2,  2,  1,  1,  0,  0,  0
 };

-static void snd_opl4_write_mask(opl4_t *opl4, u8 reg, u8 mask, u8 value)
-{
-	snd_opl4_write(opl4, reg, ((snd_opl4_read(opl4, reg)) & ~mask) | (value & mask));
-}
-
 /*
  * Initializes all voices.
  */
@@ -302,7 +297,8 @@
 	int i;

 	for (i = 0; i < OPL4_MAX_VOICES; i++)
-		snd_opl4_write_mask(opl4, OPL4_REG_MISC + i, OPL4_KEY_ON_BIT, 0);
+		snd_opl4_write(opl4, OPL4_REG_MISC + i,
+			       opl4->voices[i].reg_misc & ~OPL4_KEY_ON_BIT);
 }

 /*
@@ -378,7 +374,9 @@
 		att = 0;
 	else if (att > 0x7e)
 		att = 0x7e;
-	snd_opl4_write(opl4, OPL4_REG_LEVEL + voice->number, att << 1);
+	snd_opl4_write(opl4, OPL4_REG_LEVEL + voice->number,
+		       (att << 1) | voice->level_direct);
+	voice->level_direct = 0;
 }

 static void snd_opl4_update_pan(opl4_t *opl4, opl4_voice_t *voice)
@@ -405,8 +403,10 @@
 	depth = (7 - voice->sound->vibrato)
 		* (voice->chan->control[MIDI_CTL_VIBRATO_DEPTH] & 0x7f);
 	depth = (depth >> 7) + voice->sound->vibrato;
-	snd_opl4_write_mask(opl4, OPL4_REG_LFO_VIBRATO + voice->number,
-			    OPL4_VIBRATO_DEPTH_MASK, depth);
+	voice->reg_lfo_vibrato &= ~OPL4_VIBRATO_DEPTH_MASK;
+	voice->reg_lfo_vibrato |= depth & OPL4_VIBRATO_DEPTH_MASK;
+	snd_opl4_write(opl4, OPL4_REG_LFO_VIBRATO + voice->number,
+		       voice->reg_lfo_vibrato);
 }

 static void snd_opl4_update_pitch(opl4_t *opl4, opl4_voice_t *voice)
@@ -441,8 +441,6 @@

 static void snd_opl4_update_tone_parameters(opl4_t *opl4, opl4_voice_t *voice)
 {
-	snd_opl4_write(opl4, OPL4_REG_LFO_VIBRATO + voice->number,
-		       voice->sound->reg_lfo_vibrato);
 	snd_opl4_write(opl4, OPL4_REG_ATTACK_DECAY1 + voice->number,
 		       voice->sound->reg_attack_decay1);
 	snd_opl4_write(opl4, OPL4_REG_LEVEL_DECAY2 + voice->number,
@@ -521,6 +519,7 @@
 		voice[i]->reg_misc = OPL4_LFO_RESET_BIT;
 		snd_opl4_update_pan(opl4, voice[i]);
 		snd_opl4_update_pitch(opl4, voice[i]);
+		voice[i]->level_direct = OPL4_LEVEL_DIRECT_BIT;
 		snd_opl4_update_volume(opl4, voice[i]);
 	}

@@ -530,6 +529,7 @@
 	/* set remaining parameters */
 	for (i = 0; i < voices; i++) {
 		snd_opl4_update_tone_parameters(opl4, voice[i]);
+		voice[i]->reg_lfo_vibrato = voice[i]->sound->reg_lfo_vibrato;
 		snd_opl4_update_vibrato_depth(opl4, voice[i]);
 	}





-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
