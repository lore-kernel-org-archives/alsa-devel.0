From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/18] ALSA: hdspm: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:27 +0100
Message-ID: <1421665891-14475-15-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D0472606FA
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3B865ADAB
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:36 +0000 (UTC)
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
 sound/pci/rme9652/hdspm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8109b8e5f6ef..1716323fed9c 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1957,10 +1957,8 @@ static void snd_hdspm_midi_output_timer(unsigned long data)
 	   leaving istimer wherever it was set before.
 	*/
 
-	if (hmidi->istimer) {
-		hmidi->timer.expires = 1 + jiffies;
-		add_timer(&hmidi->timer);
-	}
+	if (hmidi->istimer)
+		mod_timer(&hmidi->timer, 1 + jiffies);
 
 	spin_unlock_irqrestore (&hmidi->lock, flags);
 }
@@ -1975,11 +1973,9 @@ snd_hdspm_midi_output_trigger(struct snd_rawmidi_substream *substream, int up)
 	spin_lock_irqsave (&hmidi->lock, flags);
 	if (up) {
 		if (!hmidi->istimer) {
-			init_timer(&hmidi->timer);
-			hmidi->timer.function = snd_hdspm_midi_output_timer;
-			hmidi->timer.data = (unsigned long) hmidi;
-			hmidi->timer.expires = 1 + jiffies;
-			add_timer(&hmidi->timer);
+			setup_timer(&hmidi->timer, snd_hdspm_midi_output_timer,
+				    (unsigned long) hmidi);
+			mod_timer(&hmidi->timer, 1 + jiffies);
 			hmidi->istimer++;
 		}
 	} else {
-- 
2.2.1
