From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: sb: Minor optimization / fix of timer
	usage in sb8_midi.c
Date: Wed, 25 Oct 2017 10:05:16 +0200
Message-ID: <20171025080516.6290-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 98277266DE1
 for <alsa-devel@alsa-project.org>; Wed, 25 Oct 2017 10:05:20 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 83625AC58
 for <alsa-devel@alsa-project.org>; Wed, 25 Oct 2017 08:05:19 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently the SB8 MIDI code sets up the timer object at each time
before scheduling it at trigger callback, but basically this is
superfluous once after set up.  Also, the code misses the
del_timer_sync() call that may leave a race condition for
use-after-free.

This patch addresses these issues, moving timer_setup() to
snd_sb8dsp_midi(), and adding the del_timer_sync() call at
snd_sb8dsp_midi_output_trigger() to make sure.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/sb/sb8_midi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/sb8_midi.c b/sound/isa/sb/sb8_midi.c
index 05ba2c6b1a8c..4affdcb78f72 100644
--- a/sound/isa/sb/sb8_midi.c
+++ b/sound/isa/sb/sb8_midi.c
@@ -138,6 +138,7 @@ static int snd_sb8dsp_midi_output_close(struct snd_rawmidi_substream *substream)
 	struct snd_sb *chip;
 
 	chip = substream->rmidi->private_data;
+	del_timer_sync(&chip->midi_timer);
 	spin_lock_irqsave(&chip->open_lock, flags);
 	chip->open &= ~(SB_OPEN_MIDI_OUTPUT | SB_OPEN_MIDI_OUTPUT_TRIGGER);
 	chip->midi_substream_output = NULL;
@@ -230,8 +231,6 @@ static void snd_sb8dsp_midi_output_trigger(struct snd_rawmidi_substream *substre
 	spin_lock_irqsave(&chip->open_lock, flags);
 	if (up) {
 		if (!(chip->open & SB_OPEN_MIDI_OUTPUT_TRIGGER)) {
-			timer_setup(&chip->midi_timer,
-				    snd_sb8dsp_midi_output_timer, 0);
 			mod_timer(&chip->midi_timer, 1 + jiffies);
 			chip->open |= SB_OPEN_MIDI_OUTPUT_TRIGGER;
 		}
@@ -274,6 +273,7 @@ int snd_sb8dsp_midi(struct snd_sb *chip, int device)
 	if (chip->hardware >= SB_HW_20)
 		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = chip;
+	timer_setup(&chip->midi_timer, snd_sb8dsp_midi_output_timer, 0);
 	chip->rmidi = rmidi;
 	return 0;
 }
-- 
2.14.2
