From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: seq_midi_emul: small array underflow
Date: Tue, 3 Mar 2015 12:38:29 +0300
Message-ID: <20150303093829.GA7685@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In snd_opl3_calc_pitch() then the limit is:

	if (pitchbend > 0x1FFF)
		pitchbend = 0x1FFF;

But it can underflow meaning that segment can be as low as
SHORT_MIN / 0x1000 and we can read 6 elements before the start of the
opl3_note_table[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/include/sound/seq_midi_emul.h b/include/sound/seq_midi_emul.h
index 8139d8c..c02b840 100644
--- a/include/sound/seq_midi_emul.h
+++ b/include/sound/seq_midi_emul.h
@@ -44,7 +44,7 @@ struct snd_midi_channel {
 	unsigned char midi_aftertouch;	/* Aftertouch (key pressure) */
 	unsigned char midi_pressure;	/* Channel pressure */
 	unsigned char midi_program;	/* Instrument number */
-	short midi_pitchbend;		/* Pitch bend amount */
+	unsigned short midi_pitchbend;	/* Pitch bend amount */
 
 	unsigned char control[128];	/* Current value of all controls */
 	unsigned char note[128];	/* Current status for all notes */
