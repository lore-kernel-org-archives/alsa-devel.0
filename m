From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/13] dice: Add support for MIDI
	capture/playback
Date: Sun, 18 May 2014 22:36:38 +0900
Message-ID: <1400420198-24312-14-git-send-email-o-takashi@sakamocchi.jp>
References: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id E7D8C264FFB
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 15:37:02 +0200 (CEST)
In-Reply-To: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a support for MIDI capture/playback

When MIDI substrams already start streaming and PCM substreams are going to
join at different sampling rate, streams are stopped once. Then sampling rate
is changed and streams are restarted.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig            |   1 +
 sound/firewire/dice/Makefile      |   4 +-
 sound/firewire/dice/dice.c        |   4 +
 sound/firewire/dice/dice.h        |   3 +
 sound/firewire/dice/dice_midi.c   | 173 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/dice/dice_stream.c |   2 +
 6 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/dice/dice_midi.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index a240a70..2e20041 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -16,6 +16,7 @@ config SND_DICE
 	select SND_HWDEP
 	select SND_PCM
 	select SND_FIREWIRE_LIB
+	select SND_RAWMIDI
 	help
 	  Say Y here to include support for many DACs based on the DICE
 	  chip family (DICE-II/Jr/Mini) from TC Applied Technologies.
diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index b236420..f6ea686 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,3 +1,3 @@
-snd-dice-objs := dice_transaction.o dice_stream.o dice_proc.o dice_pcm.o \
-		 dice_hwdep.o dice.o
+snd-dice-objs := dice_transaction.o dice_stream.o dice_proc.o dice_midi.o \
+		 dice_pcm.o dice_hwdep.o dice.o
 obj-m += snd-dice.o
diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
index 6e849e0..036e0a3 100644
--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -289,6 +289,10 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 
 	snd_dice_create_proc(dice);
 
+	err = snd_dice_create_midi(dice);
+	if (err < 0)
+		goto error;
+
 	err = snd_dice_stream_init_duplex(dice);
 	if (err < 0)
 		goto error;
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 8ea5cb4..dbfb988 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -32,6 +32,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/rawmidi.h>
 
 #include "../amdtp.h"
 #include "../iso-resources.h"
@@ -183,4 +184,6 @@ int snd_dice_create_hwdep(struct snd_dice *dice);
 
 void snd_dice_create_proc(struct snd_dice *dice);
 
+int snd_dice_create_midi(struct snd_dice *dice);
+
 #endif
diff --git a/sound/firewire/dice/dice_midi.c b/sound/firewire/dice/dice_midi.c
new file mode 100644
index 0000000..ffa8652
--- /dev/null
+++ b/sound/firewire/dice/dice_midi.c
@@ -0,0 +1,173 @@
+/*
+ * dice_midi.c - a part of driver for Dice based devices
+ *
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+#include "dice.h"
+
+static int capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dice *dice = substream->rmidi->private_data;
+	int err;
+
+	err = snd_dice_stream_lock_try(dice);
+	if (err < 0)
+		goto end;
+
+	atomic_inc(&dice->substreams_counter);
+	err = snd_dice_stream_start_duplex(dice, 0);
+	if (err < 0)
+		snd_dice_stream_lock_release(dice);
+end:
+	return err;
+}
+
+static int playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dice *dice = substream->rmidi->private_data;
+	int err;
+
+	err = snd_dice_stream_lock_try(dice);
+	if (err < 0)
+		goto end;
+
+	atomic_inc(&dice->substreams_counter);
+	err = snd_dice_stream_start_duplex(dice, 0);
+	if (err < 0)
+		snd_dice_stream_lock_release(dice);
+end:
+	return err;
+}
+
+static int capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dice *dice = substream->rmidi->private_data;
+
+	atomic_dec(&dice->substreams_counter);
+	snd_dice_stream_stop_duplex(dice);
+
+	snd_dice_stream_lock_release(dice);
+	return 0;
+}
+
+static int playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dice *dice = substream->rmidi->private_data;
+
+	atomic_dec(&dice->substreams_counter);
+	snd_dice_stream_stop_duplex(dice);
+
+	snd_dice_stream_lock_release(dice);
+	return 0;
+}
+
+static void capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_dice *dice = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dice->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&dice->tx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&dice->tx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&dice->lock, flags);
+}
+
+static void playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_dice *dice = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dice->lock, flags);
+
+	if (up)
+		amdtp_stream_midi_trigger(&dice->rx_stream,
+					  substrm->number, substrm);
+	else
+		amdtp_stream_midi_trigger(&dice->rx_stream,
+					  substrm->number, NULL);
+
+	spin_unlock_irqrestore(&dice->lock, flags);
+}
+
+static struct snd_rawmidi_ops capture_ops = {
+	.open		= capture_open,
+	.close		= capture_close,
+	.trigger	= capture_trigger,
+};
+
+static struct snd_rawmidi_ops playback_ops = {
+	.open		= playback_open,
+	.close		= playback_close,
+	.trigger	= playback_trigger,
+};
+
+static void set_midi_substream_names(struct snd_dice *dice,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d", dice->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_dice_create_midi(struct snd_dice *dice)
+{
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	unsigned int i, midi_in_ports, midi_out_ports;
+	int err;
+
+	midi_in_ports = midi_out_ports = 0;
+	for (i = 0; i < 3; i++) {
+		midi_in_ports = max(dice->tx_midi_ports[i], midi_in_ports);
+		midi_out_ports = max(dice->rx_midi_ports[i], midi_out_ports);
+	}
+
+	/* create midi ports */
+	err = snd_rawmidi_new(dice->card, dice->card->driver, 0,
+			      midi_out_ports, midi_in_ports,
+			      &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", dice->card->shortname);
+	rmidi->private_data = dice;
+
+	if (midi_in_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+				    &capture_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+
+		set_midi_substream_names(dice, str);
+	}
+
+	if (midi_out_ports > 0) {
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT;
+
+		snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+				    &playback_ops);
+
+		str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+
+		set_midi_substream_names(dice, str);
+	}
+
+	if ((midi_out_ports > 0) && (midi_in_ports > 0))
+		rmidi->info_flags |= SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	return 0;
+}
diff --git a/sound/firewire/dice/dice_stream.c b/sound/firewire/dice/dice_stream.c
index 033b0ac..db6cb28b 100644
--- a/sound/firewire/dice/dice_stream.c
+++ b/sound/firewire/dice/dice_stream.c
@@ -207,6 +207,8 @@ int snd_dice_stream_start_duplex(struct snd_dice *dice, unsigned int rate)
 			"fail to get sampling rate\n");
 		goto end;
 	}
+	if (rate == 0)
+		curr_rate = rate;
 	if (rate != curr_rate)
 		stop_stream(dice, slave);
 
-- 
1.8.3.2
