From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/15] ALSA: firewire-lib: add data block
	processing layer for AM824 format
Date: Sat, 19 Sep 2015 11:21:55 +0900
Message-ID: <1442629322-15457-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 13ED02604F8
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:14 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit adds data block processing layer for AM824 format. The new
layer initializes streaming layer with its value for fmt field.

Currently, most implementation of data block processing still remains
streaming layer. In later commits, these codes will be moved to the layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Makefile                     |  2 +-
 sound/firewire/amdtp-am824.c                | 26 ++++++++++++++++++++++++++
 sound/firewire/amdtp-am824.h                |  8 ++++++++
 sound/firewire/amdtp-stream.c               |  7 ++++---
 sound/firewire/amdtp-stream.h               |  3 ++-
 sound/firewire/bebob/bebob.h                |  2 +-
 sound/firewire/bebob/bebob_stream.c         |  8 ++++----
 sound/firewire/dice/dice-stream.c           |  2 +-
 sound/firewire/dice/dice.h                  |  2 +-
 sound/firewire/fireworks/fireworks.h        |  2 +-
 sound/firewire/fireworks/fireworks_stream.c |  2 +-
 sound/firewire/oxfw/oxfw-stream.c           |  2 +-
 sound/firewire/oxfw/oxfw.h                  |  2 +-
 13 files changed, 52 insertions(+), 16 deletions(-)
 create mode 100644 sound/firewire/amdtp-am824.c
 create mode 100644 sound/firewire/amdtp-am824.h

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 102e342..6a8a713 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,5 +1,5 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
-			 fcp.o cmp.o amdtp-stream.o
+			 fcp.o cmp.o amdtp-stream.o amdtp-am824.o
 snd-oxfw-objs := oxfw.o
 snd-isight-objs := isight.o
 snd-scs1x-objs := scs1x.o
diff --git a/sound/firewire/amdtp-am824.c b/sound/firewire/amdtp-am824.c
new file mode 100644
index 0000000..da4b643
--- /dev/null
+++ b/sound/firewire/amdtp-am824.c
@@ -0,0 +1,26 @@
+/*
+ * AM824 format in Audio and Music Data Transmission Protocol (IEC 61883-6)
+ *
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "amdtp-am824.h"
+
+#define CIP_FMT_AM		0x10
+
+/**
+ * amdtp_am824_init - initialize an AMDTP stream structure to handle AM824
+ *		      data block
+ * @s: the AMDTP stream to initialize
+ * @unit: the target of the stream
+ * @dir: the direction of stream
+ * @flags: the packet transmission method to use
+ */
+int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
+		     enum amdtp_stream_direction dir, enum cip_flags flags)
+{
+	return amdtp_stream_init(s, unit, dir, flags, CIP_FMT_AM);
+}
+EXPORT_SYMBOL_GPL(amdtp_am824_init);
diff --git a/sound/firewire/amdtp-am824.h b/sound/firewire/amdtp-am824.h
new file mode 100644
index 0000000..ed96ac5
--- /dev/null
+++ b/sound/firewire/amdtp-am824.h
@@ -0,0 +1,8 @@
+#ifndef SOUND_FIREWIRE_AMDTP_AM824_H_INCLUDED
+#define SOUND_FIREWIRE_AMDTP_AM824_H_INCLUDED
+
+#include "amdtp-stream.h"
+
+int amdtp_am824_init(struct amdtp_stream *s, struct fw_unit *unit,
+		     enum amdtp_stream_direction dir, enum cip_flags flags);
+#endif
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f1418b7..62f98e1 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -11,7 +11,6 @@
 #include <linux/firewire.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
@@ -78,9 +77,11 @@ static void pcm_period_tasklet(unsigned long data);
  * @unit: the target of the stream
  * @dir: the direction of stream
  * @flags: the packet transmission method to use
+ * @fmt: the value of fmt field in CIP header
  */
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-		      enum amdtp_stream_direction dir, enum cip_flags flags)
+		      enum amdtp_stream_direction dir, enum cip_flags flags,
+		      unsigned int fmt)
 {
 	s->unit = unit;
 	s->direction = dir;
@@ -94,7 +95,7 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->callbacked = false;
 	s->sync_slave = NULL;
 
-	s->fmt = CIP_FMT_AM;
+	s->fmt = fmt;
 
 	return 0;
 }
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 883bb1a..5f96aff 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
+#include <linux/sched.h>
 #include <sound/asound.h>
 #include "packets-buffer.h"
 
@@ -174,7 +175,7 @@ struct amdtp_stream {
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 		      enum amdtp_stream_direction dir,
-		      enum cip_flags flags);
+		      enum cip_flags flags, unsigned int fmt);
 void amdtp_stream_destroy(struct amdtp_stream *s);
 
 int amdtp_stream_set_parameters(struct amdtp_stream *s,
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 72a1c5e..d3c9d8d 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -31,7 +31,7 @@
 #include "../fcp.h"
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../cmp.h"
 
 /* basic register addresses on DM1000/DM1100/DM1500 */
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 920a3b8..34bc3a4 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -537,8 +537,8 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_init(&bebob->tx_stream, bebob->unit,
-				AMDTP_IN_STREAM, CIP_BLOCKING);
+	err = amdtp_am824_init(&bebob->tx_stream, bebob->unit,
+			       AMDTP_IN_STREAM, CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(&bebob->tx_stream);
 		destroy_both_connections(bebob);
@@ -566,8 +566,8 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 	if (bebob->maudio_special_quirk)
 		bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC;
 
-	err = amdtp_stream_init(&bebob->rx_stream, bebob->unit,
-				AMDTP_OUT_STREAM, CIP_BLOCKING);
+	err = amdtp_am824_init(&bebob->rx_stream, bebob->unit,
+			       AMDTP_OUT_STREAM, CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(&bebob->tx_stream);
 		amdtp_stream_destroy(&bebob->rx_stream);
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index e4c6c20..917860e 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -305,7 +305,7 @@ static int init_stream(struct snd_dice *dice, struct amdtp_stream *stream)
 		goto end;
 	resources->channels_mask = 0x00000000ffffffffuLL;
 
-	err = amdtp_stream_init(stream, dice->unit, dir, CIP_BLOCKING);
+	err = amdtp_am824_init(stream, dice->unit, dir, CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(stream);
 		fw_iso_resources_destroy(resources);
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index 29578c1..101550ac 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -34,7 +34,7 @@
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
 
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../iso-resources.h"
 #include "../lib.h"
 #include "dice-interface.h"
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index d54f171..c7cb7de 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -29,7 +29,7 @@
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../cmp.h"
 #include "../lib.h"
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 85a72e6..8cac5b9 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -31,7 +31,7 @@ init_stream(struct snd_efw *efw, struct amdtp_stream *stream)
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_init(stream, efw->unit, s_dir, CIP_BLOCKING);
+	err = amdtp_am824_init(stream, efw->unit, s_dir, CIP_BLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(stream);
 		cmp_connection_destroy(conn);
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index 318f78e..8368341 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -228,7 +228,7 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
 	if (err < 0)
 		goto end;
 
-	err = amdtp_stream_init(stream, oxfw->unit, s_dir, CIP_NONBLOCKING);
+	err = amdtp_am824_init(stream, oxfw->unit, s_dir, CIP_NONBLOCKING);
 	if (err < 0) {
 		amdtp_stream_destroy(stream);
 		cmp_connection_destroy(conn);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 2c3d20b..2441459 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -28,7 +28,7 @@
 #include "../fcp.h"
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp-stream.h"
+#include "../amdtp-am824.h"
 #include "../cmp.h"
 
 struct device_info {
-- 
2.1.4
