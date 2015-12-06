From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/17] ALSA: oxfw: add scs1x layer
Date: Sun,  6 Dec 2015 13:18:18 +0900
Message-ID: <1449375505-2704-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A757D26516A
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

Stanton Controllers and Systems 1 (SCS.1) series is supported by ALSA
scs1x driver. This driver just supports MIDI functionality. On the other
hand, models in this series are based on OXFW971 and ALSA OXFW driver can
support them.

SCS.1 series has MIDI functionality to control its surface state such as
LED lighting. When operating physical knobs and faders, the models
generate MIDI messages. These MIDI messages are transferred by asynchronous
transactions. These transactions are really model-specific and ALSA OXFW
driver requires the functionality so as scs1x module implements.

This commit adds scs1x layer as a preparation to merge scs1x driver to
oxfw driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile     |  2 +-
 sound/firewire/oxfw/oxfw-scs1x.c | 26 ++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.c       |  4 ++--
 sound/firewire/oxfw/oxfw.h       |  1 +
 4 files changed, 30 insertions(+), 3 deletions(-)
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
index 0000000..34db0d0
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -0,0 +1,26 @@
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
+int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
+{
+	struct snd_rawmidi *rmidi;
+	int err;
+
+	/* Use unique name for backward compatibility to scs1x module. */
+	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 0, &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", oxfw->card->shortname);
+
+	return err;
+}
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 96fbb78..b20e496 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -216,11 +216,11 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = detect_quirks(oxfw);
+	err = name_card(oxfw);
 	if (err < 0)
 		goto error;
 
-	err = name_card(oxfw);
+	err = detect_quirks(oxfw);
 	if (err < 0)
 		goto error;
 
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 1c9844a..cbf00ee 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -134,3 +134,4 @@ int snd_oxfw_create_midi(struct snd_oxfw *oxfw);
 int snd_oxfw_create_hwdep(struct snd_oxfw *oxfw);
 
 int snd_oxfw_add_spkr(struct snd_oxfw *oxfw, bool is_lacie);
+int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw);
-- 
2.5.0
