From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 40/52] oxfw: Split stream functionality to a new file and add
	a header file
Date: Wed, 29 Jan 2014 22:44:47 +0900
Message-ID: <1391003099-7109-41-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

To make it easy to work in followed commit.

And this commit remove 'fw_unit_get()/fw_unit_put()' because these
are called by helper functions in 'snd-firewire-lib'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile      |   2 +-
 sound/firewire/oxfw/oxfw.c        | 147 ++++++++------------------------------
 sound/firewire/oxfw/oxfw.h        |  56 +++++++++++++++
 sound/firewire/oxfw/oxfw_stream.c |  74 +++++++++++++++++++
 4 files changed, 159 insertions(+), 120 deletions(-)
 create mode 100644 sound/firewire/oxfw/oxfw.h
 create mode 100644 sound/firewire/oxfw/oxfw_stream.c

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 9ca49c0..510c1cb 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,2 +1,2 @@
-snd-oxfw-objs := oxfw.o
+snd-oxfw-objs := oxfw_stream.o oxfw.o
 obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 36b3e5c..93adf73 100644
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
-	struct cmp_connection connection;
-	struct amdtp_stream stream;
-	bool mute;
-	s16 volume[6];
-	s16 volume_min;
-	s16 volume_max;
-};
-
 MODULE_DESCRIPTION("Oxford OXFW970/971 driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
@@ -186,14 +148,6 @@ static int oxfw_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void oxfw_stop_stream(struct snd_oxfw *oxfw)
-{
-	if (amdtp_stream_running(&oxfw->stream)) {
-		amdtp_stream_stop(&oxfw->stream);
-		cmp_connection_break(&oxfw->connection);
-	}
-}
-
 static int oxfw_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *hw_params)
 {
@@ -201,7 +155,7 @@ static int oxfw_hw_params(struct snd_pcm_substream *substream,
 	int err;
 
 	mutex_lock(&oxfw->mutex);
-	oxfw_stop_stream(oxfw);
+	snd_oxfw_stream_stop(oxfw);
 	mutex_unlock(&oxfw->mutex);
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -209,12 +163,12 @@ static int oxfw_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto error;
 
-	amdtp_stream_set_parameters(&oxfw->stream,
+	amdtp_stream_set_parameters(&oxfw->rx_stream,
 				    params_rate(hw_params),
 				    params_channels(hw_params),
 				    0);
 
-	amdtp_stream_set_pcm_format(&oxfw->stream,
+	amdtp_stream_set_pcm_format(&oxfw->rx_stream,
 				    params_format(hw_params));
 
 	err = avc_general_set_sig_fmt(oxfw->unit, params_rate(hw_params),
@@ -240,7 +194,7 @@ static int oxfw_hw_free(struct snd_pcm_substream *substream)
 	struct snd_oxfw *oxfw = substream->private_data;
 
 	mutex_lock(&oxfw->mutex);
-	oxfw_stop_stream(oxfw);
+	snd_oxfw_stream_stop(oxfw);
 	mutex_unlock(&oxfw->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
@@ -253,33 +207,15 @@ static int oxfw_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock(&oxfw->mutex);
 
-	if (amdtp_streaming_error(&oxfw->stream))
-		oxfw_stop_stream(oxfw);
-
-	if (!amdtp_stream_running(&oxfw->stream)) {
-		err = cmp_connection_establish(&oxfw->connection,
-			amdtp_stream_get_max_payload(&oxfw->stream));
-		if (err < 0)
-			goto err_mutex;
-
-		err = amdtp_stream_start(&oxfw->stream,
-					 oxfw->connection.resources.channel,
-					 oxfw->connection.speed);
-		if (err < 0)
-			goto err_connection;
-	}
-
-	mutex_unlock(&oxfw->mutex);
-
-	amdtp_stream_pcm_prepare(&oxfw->stream);
+	snd_oxfw_stream_stop(oxfw);
 
-	return 0;
+	err = snd_oxfw_stream_start(oxfw);
+	if (err < 0)
+		goto end;
 
-err_connection:
-	cmp_connection_break(&oxfw->connection);
-err_mutex:
+	amdtp_stream_pcm_prepare(&oxfw->rx_stream);
+end:
 	mutex_unlock(&oxfw->mutex);
-
 	return err;
 }
 
@@ -298,7 +234,7 @@ static int oxfw_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	amdtp_stream_pcm_trigger(&oxfw->stream, pcm);
+	amdtp_stream_pcm_trigger(&oxfw->rx_stream, pcm);
 	return 0;
 }
 
@@ -306,7 +242,7 @@ static snd_pcm_uframes_t oxfw_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_oxfw *oxfw = substream->private_data;
 
-	return amdtp_stream_pcm_pointer(&oxfw->stream);
+	return amdtp_stream_pcm_pointer(&oxfw->rx_stream);
 }
 
 static int oxfw_create_pcm(struct snd_oxfw *oxfw)
@@ -624,9 +560,6 @@ static void oxfw_card_free(struct snd_card *card)
 {
 	struct snd_oxfw *oxfw = card->private_data;
 
-	amdtp_stream_destroy(&oxfw->stream);
-	cmp_connection_destroy(&oxfw->connection);
-	fw_unit_put(oxfw->unit);
 	mutex_destroy(&oxfw->mutex);
 }
 
@@ -642,24 +575,13 @@ static int oxfw_probe(struct fw_unit *unit,
 	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*oxfw), &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &unit->device);
 
+	card->private_free = oxfw_card_free;
 	oxfw = card->private_data;
 	oxfw->card = card;
-	mutex_init(&oxfw->mutex);
-	oxfw->unit = fw_unit_get(unit);
+	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
-
-	err = cmp_connection_init(&oxfw->connection, unit, CMP_INPUT, 0);
-	if (err < 0)
-		goto err_unit;
-
-	err = amdtp_stream_init(&oxfw->stream, unit, AMDTP_OUT_STREAM,
-				CIP_NONBLOCKING);
-	if (err < 0)
-		goto err_connection;
-
-	card->private_free = oxfw_card_free;
+	mutex_init(&oxfw->mutex);
 
 	strcpy(card->driver, oxfw->device_info->driver_name);
 	strcpy(card->shortname, oxfw->device_info->short_name);
@@ -672,28 +594,26 @@ static int oxfw_probe(struct fw_unit *unit,
 		 dev_name(&unit->device), 100 << fw_dev->max_speed);
 	strcpy(card->mixername, "OXFW970");
 
+	err = snd_oxfw_stream_init(oxfw);
+	if (err < 0)
+		goto err_card;
+
 	err = oxfw_create_pcm(oxfw);
 	if (err < 0)
-		goto error;
+		goto err_card;
 
 	err = oxfw_create_mixer(oxfw);
 	if (err < 0)
-		goto error;
+		goto err_card;
 
+	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
-		goto error;
-
+		goto err_card;
 	dev_set_drvdata(&unit->device, oxfw);
 
 	return 0;
-
-err_connection:
-	cmp_connection_destroy(&oxfw->connection);
-err_unit:
-	fw_unit_put(oxfw->unit);
-	mutex_destroy(&oxfw->mutex);
-error:
+err_card:
 	snd_card_free(card);
 	return err;
 }
@@ -703,29 +623,18 @@ static void oxfw_bus_reset(struct fw_unit *unit)
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
 	fcp_bus_reset(oxfw->unit);
-
-	if (cmp_connection_update(&oxfw->connection) < 0) {
-		amdtp_stream_pcm_abort(&oxfw->stream);
-		mutex_lock(&oxfw->mutex);
-		oxfw_stop_stream(oxfw);
-		mutex_unlock(&oxfw->mutex);
-		return;
-	}
-
-	amdtp_stream_update(&oxfw->stream);
+	snd_oxfw_stream_update(oxfw);
 }
 
 static void oxfw_remove(struct fw_unit *unit)
 {
 	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
 
-	amdtp_stream_pcm_abort(&oxfw->stream);
-	snd_card_disconnect(oxfw->card);
-
 	mutex_lock(&oxfw->mutex);
-	oxfw_stop_stream(oxfw);
+	snd_oxfw_stream_destroy(oxfw);
 	mutex_unlock(&oxfw->mutex);
 
+	snd_card_disconnect(oxfw->card);
 	snd_card_free_when_closed(oxfw->card);
 }
 
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
new file mode 100644
index 0000000..f2c5b75
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
+int snd_oxfw_stream_init(struct snd_oxfw *oxfw);
+int snd_oxfw_stream_start(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_stop(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw);
+void snd_oxfw_stream_update(struct snd_oxfw *oxfw);
diff --git a/sound/firewire/oxfw/oxfw_stream.c b/sound/firewire/oxfw/oxfw_stream.c
new file mode 100644
index 0000000..199a0ef
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw_stream.c
@@ -0,0 +1,74 @@
+/*
+ * oxfw_stream.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "oxfw.h"
+
+int snd_oxfw_stream_init(struct snd_oxfw *oxfw)
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
+	if (err < 0)
+		cmp_connection_destroy(&oxfw->in_conn);
+end:
+	return err;
+}
+
+int snd_oxfw_stream_start(struct snd_oxfw *oxfw)
+{
+	int err = 0;
+
+	if (amdtp_streaming_error(&oxfw->rx_stream))
+		snd_oxfw_stream_stop(oxfw);
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
+		snd_oxfw_stream_stop(oxfw);
+end:
+	return err;
+}
+
+void snd_oxfw_stream_stop(struct snd_oxfw *oxfw)
+{
+	if (amdtp_stream_running(&oxfw->rx_stream))
+		amdtp_stream_stop(&oxfw->rx_stream);
+
+	cmp_connection_break(&oxfw->in_conn);
+}
+
+void snd_oxfw_stream_destroy(struct snd_oxfw *oxfw)
+{
+	amdtp_stream_pcm_abort(&oxfw->rx_stream);
+	snd_oxfw_stream_stop(oxfw);
+	cmp_connection_destroy(&oxfw->in_conn);
+}
+
+void snd_oxfw_stream_update(struct snd_oxfw *oxfw)
+{
+	if (cmp_connection_update(&oxfw->in_conn) < 0) {
+		amdtp_stream_pcm_abort(&oxfw->rx_stream);
+		snd_oxfw_stream_stop(oxfw);
+	} else {
+		amdtp_stream_update(&oxfw->rx_stream);
+	}
+}
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
