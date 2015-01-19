From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/18] ALSA: hdsp: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:26 +0100
Message-ID: <1421665891-14475-14-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 964D62606FF
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3B7E0ADA4
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
 sound/pci/rme9652/hdsp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index fe66bcb21475..98a2d911ef17 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -1428,10 +1428,8 @@ static void snd_hdsp_midi_output_timer(unsigned long data)
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
@@ -1445,11 +1443,9 @@ static void snd_hdsp_midi_output_trigger(struct snd_rawmidi_substream *substream
 	spin_lock_irqsave (&hmidi->lock, flags);
 	if (up) {
 		if (!hmidi->istimer) {
-			init_timer(&hmidi->timer);
-			hmidi->timer.function = snd_hdsp_midi_output_timer;
-			hmidi->timer.data = (unsigned long) hmidi;
-			hmidi->timer.expires = 1 + jiffies;
-			add_timer(&hmidi->timer);
+			setup_timer(&hmidi->timer, snd_hdsp_midi_output_timer,
+				    (unsigned long) hmidi);
+			mod_timer(&hmidi->timer, 1 + jiffies);
 			hmidi->istimer++;
 		}
 	} else {
-- 
2.2.1
