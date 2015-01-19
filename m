From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/18] ALSA: wavefront: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:22 +0100
Message-ID: <1421665891-14475-10-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4811A2606F2
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 01168AD96
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/wavefront/wavefront_midi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index 7dc991682297..b8009cbcd34e 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -356,8 +356,7 @@ static void snd_wavefront_midi_output_timer(unsigned long data)
 	unsigned long flags;
 	
 	spin_lock_irqsave (&midi->virtual, flags);
-	midi->timer.expires = 1 + jiffies;
-	add_timer(&midi->timer);
+	mod_timer(&midi->timer, 1 + jiffies);
 	spin_unlock_irqrestore (&midi->virtual, flags);
 	snd_wavefront_midi_output_write(card);
 }
@@ -384,11 +383,10 @@ static void snd_wavefront_midi_output_trigger(struct snd_rawmidi_substream *subs
 	if (up) {
 		if ((midi->mode[mpu] & MPU401_MODE_OUTPUT_TRIGGER) == 0) {
 			if (!midi->istimer) {
-				init_timer(&midi->timer);
-				midi->timer.function = snd_wavefront_midi_output_timer;
-				midi->timer.data = (unsigned long) substream->rmidi->card->private_data;
-				midi->timer.expires = 1 + jiffies;
-				add_timer(&midi->timer);
+				setup_timer(&midi->timer,
+					    snd_wavefront_midi_output_timer,
+					    (unsigned long) substream->rmidi->card->private_data);
+				mod_timer(&midi->timer, 1 + jiffies);
 			}
 			midi->istimer++;
 			midi->mode[mpu] |= MPU401_MODE_OUTPUT_TRIGGER;
-- 
2.2.1
