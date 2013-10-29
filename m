From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/10] ALSA: opl3: Fix possible negative array
	index access
Date: Tue, 29 Oct 2013 17:00:24 +0100
Message-ID: <1383062433-9388-2-git-send-email-tiwai@suse.de>
References: <1383062433-9388-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CE1BC2610AA
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 9FDCAA6074
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 16:57:48 +0100 (CET)
In-Reply-To: <1383062433-9388-1-git-send-email-tiwai@suse.de>
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

Spotted by coverity CID 115196.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl3/opl3_midi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index 0c796bcbc0a3..6c6d09a51f42 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -390,6 +390,11 @@ void snd_opl3_note_on(void *p, int note, int vel, struct snd_midi_channel *chan)
 		voice = snd_opl3_oss_map[chan->number];		
 	}
 
+	if (voice < 0) {
+		spin_unlock_irqrestore(&opl3->voice_lock, flags);
+		return;
+	}
+
 	if (voice < MAX_OPL2_VOICES) {
 		/* Left register block for voices 0 .. 8 */
 		reg_side = OPL3_LEFT;
-- 
1.8.4.1
