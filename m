From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/17] ALSA: oxfw: add MIDI capture port for
	SCS.1 models
Date: Sun,  6 Dec 2015 13:18:21 +0900
Message-ID: <1449375505-2704-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id BA57F26530D
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:32 +0100 (CET)
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

This commit adds MIDI capture so that scs1x driver has.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 4060bf0..807009f 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -106,6 +106,33 @@ end:
 	fw_send_response(card, request, rcode);
 }
 
+static int midi_capture_open(struct snd_rawmidi_substream *stream)
+{
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	scs->input_escape_count = 0;
+
+	return 0;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *stream)
+{
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *stream, int up)
+{
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	ACCESS_ONCE(scs->input) = up ? stream : NULL;
+}
+
+static struct snd_rawmidi_ops midi_capture_ops = {
+	.open    = midi_capture_open,
+	.close   = midi_capture_close,
+	.trigger = midi_capture_trigger,
+};
+
 static int register_address(struct snd_oxfw *oxfw)
 {
 	struct fw_scs1x *scs = oxfw->spec;
@@ -158,7 +185,7 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 		goto err_allocated;
 
 	/* Use unique name for backward compatibility to scs1x module. */
-	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 0, &rmidi);
+	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 1, &rmidi);
 	if (err < 0)
 		goto err_allocated;
 	rmidi->private_data = scs;
@@ -167,6 +194,10 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 	snprintf(rmidi->name, sizeof(rmidi->name),
 		 "%s MIDI", oxfw->card->shortname);
 
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT;
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &midi_capture_ops);
+
 	return 0;
 err_allocated:
 	fw_core_remove_address_handler(&scs->hss_handler);
-- 
2.5.0
