From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/8] ALSA: oxfw: add MIDI playback port for
	SCS.1 models
Date: Tue, 22 Dec 2015 09:15:44 +0900
Message-ID: <1450743346-14071-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1450743346-14071-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 84EF4261543
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 01:15:56 +0100 (CET)
In-Reply-To: <1450743346-14071-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds MIDI playback ports so that scs1x driver has.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 47 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 84eacdb..bb53eb3 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -290,6 +290,45 @@ static struct snd_rawmidi_ops midi_capture_ops = {
 	.trigger = midi_capture_trigger,
 };
 
+static int midi_playback_open(struct snd_rawmidi_substream *stream)
+{
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *stream)
+{
+	return 0;
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *stream, int up)
+{
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	if (up) {
+		scs->output_status = 0;
+		scs->output_bytes = 1;
+		scs->output_escaped = false;
+		scs->output_idle = false;
+
+		ACCESS_ONCE(scs->output) = stream;
+		tasklet_schedule(&scs->tasklet);
+	} else {
+		ACCESS_ONCE(scs->output) = NULL;
+	}
+}
+static void midi_playback_drain(struct snd_rawmidi_substream *stream)
+{
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	wait_event(scs->idle_wait, scs->output_idle);
+}
+
+static struct snd_rawmidi_ops midi_playback_ops = {
+	.open    = midi_playback_open,
+	.close   = midi_playback_close,
+	.trigger = midi_playback_trigger,
+	.drain   = midi_playback_drain,
+};
 static int register_address(struct snd_oxfw *oxfw)
 {
 	struct fw_scs1x *scs = oxfw->spec;
@@ -339,7 +378,7 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 		goto err_allocated;
 
 	/* Use unique name for backward compatibility to scs1x module. */
-	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 1, &rmidi);
+	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 1, 1, &rmidi);
 	if (err < 0)
 		goto err_allocated;
 	rmidi->private_data = scs;
@@ -348,9 +387,13 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 	snprintf(rmidi->name, sizeof(rmidi->name),
 		 "%s MIDI", oxfw->card->shortname);
 
-	rmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT;
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT |
+			    SNDRV_RAWMIDI_INFO_OUTPUT |
+			    SNDRV_RAWMIDI_INFO_DUPLEX;
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
 			    &midi_capture_ops);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &midi_playback_ops);
 
 	tasklet_init(&scs->tasklet, scs_output_tasklet, (unsigned long)scs);
 	init_waitqueue_head(&scs->idle_wait);
-- 
2.5.0
