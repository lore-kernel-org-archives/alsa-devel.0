From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/17] ALSA: oxfw: add MIDI playback port for
	SCS.1 models
Date: Sun,  6 Dec 2015 13:18:23 +0900
Message-ID: <1449375505-2704-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E5ECF265341
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:33 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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
index 94477a5..e755451 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -289,6 +289,45 @@ static struct snd_rawmidi_ops midi_capture_ops = {
 	.trigger = midi_capture_trigger,
 };
 
+static int midi_playback_open(struct snd_rawmidi_substream *stream)
+{
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	scs->output_status = 0;
+	scs->output_bytes = 1;
+	scs->output_escaped = false;
+
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
+	ACCESS_ONCE(scs->output) = up ? stream : NULL;
+	if (up) {
+		scs->output_idle = false;
+		tasklet_schedule(&scs->tasklet);
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
@@ -342,7 +381,7 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 		goto err_allocated;
 
 	/* Use unique name for backward compatibility to scs1x module. */
-	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 1, &rmidi);
+	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 1, 1, &rmidi);
 	if (err < 0)
 		goto err_allocated;
 	rmidi->private_data = scs;
@@ -351,9 +390,13 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
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
