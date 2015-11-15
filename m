From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 8/9] ALSA: oxfw: optimize MIDI operations to
	model-specific framework
Date: Sun, 15 Nov 2015 18:26:04 +0900
Message-ID: <1447579565-4615-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id DA2E4261A68
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:26:11 +0100 (CET)
In-Reply-To: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
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

In scs1x module, MIDI substream caches are released at .remove callback of
unit driver on IEEE 1394 bus, while oxfw model-specific framework allows
it in ALSA card free callback. MIDI close operations should be changed.

This commit applies a small optimization for MIDI operations.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 89ba8f6..47d346c 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -303,11 +303,20 @@ static int midi_playback_open(struct snd_rawmidi_substream *stream)
 	scs->output_bytes = 1;
 	scs->output_escaped = false;
 
+	ACCESS_ONCE(scs->output) = stream;
+
 	return 0;
 }
 
 static int midi_playback_close(struct snd_rawmidi_substream *stream)
 {
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	ACCESS_ONCE(scs->output) = NULL;
+
+	wait_event(scs->idle_wait, scs->output_idle);
+	tasklet_kill(&scs->tasklet);
+
 	return 0;
 }
 
@@ -315,7 +324,6 @@ static void midi_playback_trigger(struct snd_rawmidi_substream *stream, int up)
 {
 	struct fw_scs1x *scs = stream->rmidi->private_data;
 
-	ACCESS_ONCE(scs->output) = up ? stream : NULL;
 	if (up) {
 		scs->output_idle = false;
 		tasklet_schedule(&scs->tasklet);
@@ -394,13 +402,6 @@ static void scs1x_remove(struct snd_oxfw *oxfw)
 {
 	struct fw_scs1x *scs = oxfw->spec->private_data;
 
-	ACCESS_ONCE(scs->output) = NULL;
-	ACCESS_ONCE(scs->input) = NULL;
-
-	wait_event(scs->idle_wait, scs->output_idle);
-
-	tasklet_kill(&scs->tasklet);
-
 	fw_core_remove_address_handler(&scs->hss_handler);
 }
 
-- 
2.5.0
