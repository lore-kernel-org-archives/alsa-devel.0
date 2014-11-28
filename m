From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/30] ALSA: oxfw: Split stream functionality
	to a new file and add a header file
Date: Sat, 29 Nov 2014 00:59:27 +0900
Message-ID: <1417190379-4172-19-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A582604F2
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:53 +0100 (CET)
In-Reply-To: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a help for works in followed patches.

And this commit remove 'fw_unit_get()/fw_unit_put()' because these
are called by helper functions in 'snd-firewire-lib'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile      |   2 +-
 sound/firewire/oxfw/oxfw-stream.c |  80 +++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.c        | 130 +++++++-------------------------------
 sound/firewire/oxfw/oxfw.h        |  56 ++++++++++++++++
 4 files changed, 159 insertions(+), 109 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw-stream.c
 create mode 100644 sound/firewire/oxfw/oxfw.h

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 9ca49c0..e15c4c0 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,2 @@
-snd-oxfw-objs := oxfw.o
+snd-oxfw-objs := oxfw-stream.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
new file mode 100644
index 0000000..ebd156f
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -0,0 +1,80 @@
+/*
+ * oxfw_stream.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2014 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw)
+{
+	int err;
+
+	err = cmp_connection_init(&oxfw->in_conn, oxfw->unit,
+				  CMP_INPUT, 0);
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_init(&oxfw->rx_stream, oxfw->unit,
+				AMDTP_OUT_STREAM, CIP_NONBLOCKING);
+	if (err < 0) {
+		amdtp_stream_destroy(&oxfw->rx_stream);
+		cmp_connection_destroy(&oxfw->in_conn);
+	}
+end:
+	return err;
+}
+
+static void stop_stream(struct snd_oxfw *oxfw)
+{
+	amdtp_stream_pcm_abort(&oxfw->rx_stream);
+	amdtp_stream_stop(&oxfw->rx_stream);
+	cmp_connection_break(&oxfw->in_conn);
+}
+
+int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw)
+{
+	int err = 0;
+
+	if (amdtp_streaming_error(&oxfw->rx_stream))
+		stop_stream(oxfw);
+
+	if (amdtp_stream_running(&oxfw->rx_stream))
+		goto end;
+
+	err = cmp_connection_establish(&oxfw->in_conn,
+			amdtp_stream_get_max_payload(&oxfw->rx_stream));
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_start(&oxfw->rx_stream,
+				 oxfw->in_conn.resources.channel,
+				 oxfw->in_conn.speed);
+	if (err < 0)
+		stop_stream(oxfw);
+end:
+	return err;
+}
+
+void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw)
+{
+	stop_stream(oxfw);
+}
+
+void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw)
+{
+	stop_stream(oxfw);
+
+	amdtp_stream_destroy(&oxfw->rx_stream);
+	cmp_connection_destroy(&oxfw->in_conn);
+}
+
+void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw)
+{
+	if (cmp_connection_update(&oxfw->in_conn) < 0)
+		stop_stream(oxfw);
+	else
+		amdtp_stream_update(&oxfw->rx_stream);
+}
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 55c687e..4055667 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -5,22 +5,7 @@
  * Licensed under the terms of the GNU General Public License, version 2.
  */
 
-#include <linux/device.h>
-#include <linux/firewire.h>
-#include <linux/firewire-constants.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/mutex.h>
-#include <linux/slab.h>
-#include <sound/control.h>
-#include <sound/core.h>
-#include <sound/initval.h>
-#include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include "../cmp.h"
-#include "../fcp.h"
-#include "../amdtp.h"
-#include "../lib.h"
+#include "oxfw.h"
 
 #define OXFORD_FIRMWARE_ID_ADDRESS	(CSR_REGISTER_BASE + 0x50000)
 /* 0x970?vvvv or 0x971?vvvv, where vvvv = firmware version */
@@ -35,29 +20,6 @@
 #define SPECIFIER_1394TA	0x00a02d
 #define VERSION_AVC		0x010001
 
-struct device_info {
-	const char *driver_name;
-	const char *short_name;
-	const char *long_name;
-	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
-	unsigned int mixer_channels;
-	u8 mute_fb_id;
-	u8 volume_fb_id;
-};
-
-struct snd_oxfw {
-	struct snd_card *card;
-	struct fw_unit *unit;
-	const struct device_info *device_info;
-	struct mutex mutex;
-	struct cmp_connection in_conn;
-	struct amdtp_stream rx_stream;
-	bool mute;
-	s16 volume[6];
-	s16 volume_min;
-	s16 volume_max;
-};
-
 MODULE_DESCRIPTION("Oxford Semiconductor FW970/971 driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
@@ -180,14 +142,6 @@ static int oxfw_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void oxfw_stop_stream(struct snd_oxfw *oxfw)
-{
-	if (amdtp_stream_running(&oxfw->rx_stream)) {
-		amdtp_stream_stop(&oxfw->rx_stream);
-		cmp_connection_break(&oxfw->in_conn);
-	}
-}
-
 static int oxfw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *hw_params)
 {
@@ -195,8 +149,8 @@ static int oxfw_hw_params(struct snd_pcm_substream *substream,
 	int err;
 
 	mutex_lock(&oxfw->mutex);
-	oxfw_stop_stream(oxfw);
-	mutex_unlock(&oxfw->mutex);
+
+	snd_oxfw_stream_stop_simplex(oxfw);
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
 					       params_buffer_bytes(hw_params));
@@ -223,6 +177,7 @@ static int oxfw_hw_params(struct snd_pcm_substream *substream,
 err_buffer:
 	snd_pcm_lib_free_vmalloc_buffer(substream);
 error:
+	mutex_unlock(&oxfw->mutex);
 	return err;
 }
 
@@ -231,7 +186,7 @@ static int oxfw_hw_free(struct snd_pcm_substream *substream)
 	struct snd_oxfw *oxfw = substream->private_data;
 
 	mutex_lock(&oxfw->mutex);
-	oxfw_stop_stream(oxfw);
+	snd_oxfw_stream_stop_simplex(oxfw);
 	mutex_unlock(&oxfw->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
@@ -244,33 +199,15 @@ static int oxfw_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	if (amdtp_streaming_error(&oxfw->rx_stream))
-		oxfw_stop_stream(oxfw);
-
-	if (!amdtp_stream_running(&oxfw->rx_stream)) {
-		err = cmp_connection_establish(&oxfw->in_conn,
-			amdtp_stream_get_max_payload(&oxfw->rx_stream));
-		if (err < 0)
-			goto err_mutex;
+	snd_oxfw_stream_stop_simplex(oxfw);
 
-		err = amdtp_stream_start(&oxfw->rx_stream,
-					 oxfw->in_conn.resources.channel,
-					 oxfw->in_conn.speed);
-		if (err < 0)
-			goto err_connection;
-	}
-
-	mutex_unlock(&oxfw->mutex);
+	err = snd_oxfw_stream_start_simplex(oxfw);
+	if (err < 0)
+		goto end;
 
 	amdtp_stream_pcm_prepare(&oxfw->rx_stream);
-
-	return 0;
-
-err_connection:
-	cmp_connection_break(&oxfw->in_conn);
-err_mutex:
+end:
 	mutex_unlock(&oxfw->mutex);
-
 	return err;
 }
 
@@ -615,9 +552,6 @@ static void oxfw_card_free(struct snd_card *card)
 {
 	struct snd_oxfw *oxfw = card->private_data;
 
-	amdtp_stream_destroy(&oxfw->rx_stream);
-	cmp_connection_destroy(&oxfw->in_conn);
-	fw_unit_put(oxfw->unit);
 	mutex_destroy(&oxfw->mutex);
 }
 
@@ -635,23 +569,13 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		return err;
 
+	card->private_free = oxfw_card_free;
 	oxfw = card->private_data;
 	oxfw->card = card;
 	mutex_init(&oxfw->mutex);
-	oxfw->unit = fw_unit_get(unit);
+	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 
-	err = cmp_connection_init(&oxfw->in_conn, unit, CMP_INPUT, 0);
-	if (err < 0)
-		goto err_unit;
-
-	err = amdtp_stream_init(&oxfw->rx_stream, unit, AMDTP_OUT_STREAM,
-				CIP_NONBLOCKING);
-	if (err < 0)
-		goto err_connection;
-
-	card->private_free = oxfw_card_free;
-
 	strcpy(card->driver, oxfw->device_info->driver_name);
 	strcpy(card->shortname, oxfw->device_info->short_name);
 	firmware = oxfw_read_firmware_version(unit);
@@ -671,19 +595,18 @@ static int oxfw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
-	err = snd_card_register(card);
+	err = snd_oxfw_stream_init_simplex(oxfw);
 	if (err < 0)
 		goto error;
 
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_oxfw_stream_destroy_simplex(oxfw);
+		goto error;
+	}
 	dev_set_drvdata(&unit->device, oxfw);
 
 	return 0;
-
-err_connection:
-	cmp_connection_destroy(&oxfw->in_conn);
-err_unit:
-	fw_unit_put(oxfw->unit);
-	mutex_destroy(&oxfw->mutex);
 error:
 	snd_card_free(card);
 	return err;
@@ -695,27 +618,18 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 
 	fcp_bus_reset(oxfw->unit);
 
-	if (cmp_connection_update(&oxfw->in_conn) < 0) {
-		amdtp_stream_pcm_abort(&oxfw->rx_stream);
-		mutex_lock(&oxfw->mutex);
-		oxfw_stop_stream(oxfw);
-		mutex_unlock(&oxfw->mutex);
-		return;
-	}
-
-	amdtp_stream_update(&oxfw->rx_stream);
+	mutex_lock(&oxfw->mutex);
+	snd_oxfw_stream_update_simplex(oxfw);
+	mutex_unlock(&oxfw->mutex);
 }
 
 static void oxfw_remove(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	amdtp_stream_pcm_abort(&oxfw->rx_stream);
 	snd_card_disconnect(oxfw->card);
 
-	mutex_lock(&oxfw->mutex);
-	oxfw_stop_stream(oxfw);
-	mutex_unlock(&oxfw->mutex);
+	snd_oxfw_stream_destroy_simplex(oxfw);
 
 	snd_card_free_when_closed(oxfw->card);
 }
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
new file mode 100644
index 0000000..e5836e0
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw.h
@@ -0,0 +1,56 @@
+/*
+ * oxfw.h - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include <linux/device.h>
+#include <linux/firewire.h>
+#include <linux/firewire-constants.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include "../lib.h"
+#include "../fcp.h"
+#include "../packets-buffer.h"
+#include "../iso-resources.h"
+#include "../amdtp.h"
+#include "../cmp.h"
+
+struct device_info {
+	const char *driver_name;
+	const char *short_name;
+	const char *long_name;
+	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
+	unsigned int mixer_channels;
+	u8 mute_fb_id;
+	u8 volume_fb_id;
+};
+
+struct snd_oxfw {
+	struct snd_card *card;
+	struct fw_unit *unit;
+	const struct device_info *device_info;
+	struct mutex mutex;
+	struct cmp_connection in_conn;
+	struct amdtp_stream rx_stream;
+	bool mute;
+	s16 volume[6];
+	s16 volume_min;
+	s16 volume_max;
+};
+
+int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_start_simplex(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_stop_simplex(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_destroy_simplex(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_update_simplex(struct snd_oxfw *oxfw);
-- 
2.1.0
