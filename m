From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 8/8] ALSA: firewire-tascam: support drain
	callback for MIDI playback substream
Date: Fri, 14 Apr 2017 16:46:32 +0900
Message-ID: <20170414074632.13453-9-o-takashi@sakamocchi.jp>
References: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id AD73726717B
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 09:46:39 +0200 (CEST)
In-Reply-To: <20170414074632.13453-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, dev@andree.sk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA driver for TASCAM FireWire series transfers MIDI messages in system
workqueue. In current design of the driver, applications should wait for
sequence of transmission when they close ALSA rawmidi character devices.
However, when considering design of rawmidi interface, it's preferable
to wait in drain ioctl.

This commit adds support for the drain ioctl to wait for the end of
the transmission.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/tascam/tascam-midi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/tascam/tascam-midi.c b/sound/firewire/tascam/tascam-midi.c
index 760f72a..4a741570 100644
--- a/sound/firewire/tascam/tascam-midi.c
+++ b/sound/firewire/tascam/tascam-midi.c
@@ -31,11 +31,14 @@ static int midi_capture_close(struct snd_rawmidi_substream *substream)
 
 static int midi_playback_close(struct snd_rawmidi_substream *substream)
 {
+	return 0;
+}
+
+static void midi_playback_drain(struct snd_rawmidi_substream *substream)
+{
 	struct snd_tscm *tscm = substream->rmidi->private_data;
 
 	snd_fw_async_midi_port_finish(&tscm->out_ports[substream->number]);
-
-	return 0;
 }
 
 static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
@@ -77,6 +80,7 @@ int snd_tscm_create_midi_devices(struct snd_tscm *tscm)
 	static const struct snd_rawmidi_ops playback_ops = {
 		.open		= midi_playback_open,
 		.close		= midi_playback_close,
+		.drain		= midi_playback_drain,
 		.trigger	= midi_playback_trigger,
 	};
 	struct snd_rawmidi *rmidi;
-- 
2.9.3
