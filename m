From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2] ALSA: oxfw: discontinue MIDI substream for
	scs1x at transaction failure
Date: Wed, 24 Feb 2016 09:26:33 +0900
Message-ID: <1456273593-6082-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1456273593-6082-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E01826145E
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 01:26:41 +0100 (CET)
In-Reply-To: <1456273593-6082-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

With a previous commit, ALSA oxfw driver retries transferring MIDI
messages at transaction failure for scs1x. On the other hand, there're
fatal transaction error. Then, no MIDI messages reach to the unit anymore.
In this case, MIDI substream should be terminated.

This commit stops MIDI transmission after the fatal error occurs.
Unfortunately, unlike ALSA PCM functionality, ALSA rawmidi core has no
feature to discontinue MIDI substream runtime in kernel side, thus this
commit just stops MIDI transmission without notifying it to userspace.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 72446ac..f897c98 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -32,6 +32,7 @@ struct fw_scs1x {
 	bool transaction_running;
 	struct fw_transaction transaction;
 	unsigned int transaction_bytes;
+	bool error;
 	struct fw_device *fw_dev;
 };
 
@@ -126,8 +127,13 @@ static void scs_write_callback(struct fw_card *card, int rcode,
 {
 	struct fw_scs1x *scs = callback_data;
 
-	if (rcode != RCODE_GENERATION)
-		scs->transaction_bytes = 0;
+	if (!rcode_is_permanent_error(rcode)) {
+		/* Don't retry for this data. */
+		if (rcode == RCODE_COMPLETE)
+			scs->transaction_bytes = 0;
+	} else {
+		scs->error = true;
+	}
 
 	scs->transaction_running = false;
 	schedule_work(&scs->work);
@@ -178,7 +184,7 @@ static void scs_output_work(struct work_struct *work)
 		return;
 
 	stream = ACCESS_ONCE(scs->output);
-	if (!stream) {
+	if (!stream || scs->error) {
 		scs->output_idle = true;
 		wake_up(&scs->idle_wait);
 		return;
@@ -317,6 +323,7 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *stream, int up)
 		scs->output_escaped = false;
 		scs->output_idle = false;
 		scs->transaction_bytes = 0;
+		scs->error = false;
 
 		ACCESS_ONCE(scs->output) = stream;
 		schedule_work(&scs->work);
-- 
2.5.0
