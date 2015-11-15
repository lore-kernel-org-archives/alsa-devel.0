From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/9] ALSA: oxfw: add scs1x layer
Date: Sun, 15 Nov 2015 18:26:01 +0900
Message-ID: <1447579565-4615-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id D5EF8261A5E
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

Stanton Controllers and Systems 1 has MIDI functionality to control its
surface state such as LED lighting. When operating physical knobs and
faders, the models generate MIDI messages. These MIDI messages are
transferred by asynchronous transactions.

The models are based on OXFW971 and ALSA OXFW driver can support them,
although ALSA scs1x module currently supports them.

This commit adds scs1x layer. As long as I investigate SCS.1m, this
model reports to transfer/receive PCM data channels/MIDI conformant
data channels in tx/rx AMDTP packet. There's a contradiction that this
model actually has no analog/digital capture port for PCM frames and no
physical MIDI ports.

I guess that SCS.1d also has the contradiction. This model has no
analog/digital ports for PCM frames and no physical MIDI ports, thus it
requires no streaming functionality.

This commit also add some modification codes to handle the contradiction,
as much as possible. Unfortunately, this module adds one PCM playback
substream for SCS.1d so as SCS.1m.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile     |  2 +-
 sound/firewire/oxfw/oxfw-scs1x.c | 30 ++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.c       | 16 ++++++++++++++++
 sound/firewire/oxfw/oxfw.h       |  1 +
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/oxfw/oxfw-scs1x.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 4e54ba9..b474da7 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
 snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-pcm.o oxfw-proc.o \
-		 oxfw-midi.o oxfw-hwdep.o oxfw-spkr.o oxfw.o
+		 oxfw-midi.o oxfw-hwdep.o oxfw-spkr.o oxfw-scs1x.o oxfw.o
 obj-$(CONFIG_SND_OXFW) += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
new file mode 100644
index 0000000..c04c76e
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -0,0 +1,30 @@
+/*
+ * oxfw-scs1x.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+static int scs1x_add(struct snd_oxfw *oxfw)
+{
+	struct snd_rawmidi *rmidi;
+	int err;
+
+	/* For backward compatibility to scs1x module, use unique name. */
+	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 0, &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", oxfw->card->shortname);
+
+	return err;
+}
+
+struct snd_oxfw_spec snd_oxfw_spec_scs1x = {
+	.add	= scs1x_add,
+};
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index ee7094b..97fb5ed 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -19,6 +19,7 @@
 #define VENDOR_BEHRINGER	0x001564
 #define VENDOR_LACIE		0x00d04b
 #define VENDOR_TASCAM		0x00022e
+#define OUI_STANTON		0x001260
 
 #define MODEL_SATELLITE		0x00200f
 
@@ -182,6 +183,21 @@ static void detect_quirks(struct snd_oxfw *oxfw)
 	 */
 	if (vendor == VENDOR_GRIFFIN || vendor == VENDOR_LACIE)
 		oxfw->spec = &snd_oxfw_spec_spkr;
+
+	/*
+	 * Stanton models supports asynchronous transactions for unique MIDI
+	 * messages.
+	 */
+	if (vendor == OUI_STANTON) {
+		/* No physical MIDI ports. */
+		oxfw->midi_input_ports = 0;
+		oxfw->midi_output_ports = 0;
+
+		/* Output stream exists but no data channels are useful. */
+		oxfw->has_output = false;
+
+		oxfw->spec = &snd_oxfw_spec_scs1x;
+	}
 }
 
 static int oxfw_probe(struct fw_unit *unit,
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 473faafbb..bf8b953 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -141,3 +141,4 @@ int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
 int snd_oxfw_create_hwdep(struct snd_oxfw *oxfw);
 
 extern struct snd_oxfw_spec snd_oxfw_spec_spkr;
+extern struct snd_oxfw_spec snd_oxfw_spec_scs1x;
-- 
2.5.0
