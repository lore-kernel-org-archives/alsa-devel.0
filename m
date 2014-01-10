From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/13] speakers: Split stream functionality to
	a new file and add a header file
Date: Sat, 11 Jan 2014 00:29:24 +0900
Message-ID: <1389367775-21360-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 74B4926158B
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:50 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

To make it easy to work in followed commit.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/Makefile          |   2 +-
 sound/firewire/speakers/speakers.c        | 157 +++++++-----------------------
 sound/firewire/speakers/speakers.h        |  54 ++++++++++
 sound/firewire/speakers/speakers_stream.c |  72 ++++++++++++++
 4 files changed, 163 insertions(+), 122 deletions(-)
 create mode 100644 sound/firewire/speakers/speakers.h
 create mode 100644 sound/firewire/speakers/speakers_stream.c

diff --git a/sound/firewire/speakers/Makefile b/sound/firewire/speakers/Makefile
index 3db3c56a..f46ae1d 100644
--- a/sound/firewire/speakers/Makefile
+++ b/sound/firewire/speakers/Makefile
@@ -1,2 +1,2 @@
-snd-firewire-speakers-objs := speakers.o
+snd-firewire-speakers-objs := speakers_stream.o speakers.o
 obj-m += snd-firewire-speakers.o
diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index 78eaec1..47d3cc0 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -1,26 +1,11 @@
 /*
- * OXFW970-based speakers driver
+ * speakers.c - a part of OXFW970/971-based speakers driver
  *
  * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
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
+#include "speakers.h"
 
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
-struct fwspk {
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
 MODULE_DESCRIPTION("FireWire speakers driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
@@ -185,14 +147,6 @@ static int fwspk_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void fwspk_stop_stream(struct fwspk *fwspk)
-{
-	if (amdtp_stream_running(&fwspk->stream)) {
-		amdtp_stream_stop(&fwspk->stream);
-		cmp_connection_break(&fwspk->connection);
-	}
-}
-
 static int fwspk_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *hw_params)
 {
@@ -200,7 +154,7 @@ static int fwspk_hw_params(struct snd_pcm_substream *substream,
 	int err;
 
 	mutex_lock(&fwspk->mutex);
-	fwspk_stop_stream(fwspk);
+	snd_fwspk_stream_stop(fwspk);
 	mutex_unlock(&fwspk->mutex);
 
 	err = snd_pcm_lib_alloc_vmalloc_buffer(substream,
@@ -208,12 +162,12 @@ static int fwspk_hw_params(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto error;
 
-	amdtp_stream_set_parameters(&fwspk->stream,
+	amdtp_stream_set_parameters(&fwspk->rx_stream,
 				    params_rate(hw_params),
 				    params_channels(hw_params),
 				    0);
 
-	amdtp_stream_set_pcm_format(&fwspk->stream,
+	amdtp_stream_set_pcm_format(&fwspk->rx_stream,
 				    params_format(hw_params));
 
 	err = avc_general_set_sig_fmt(fwspk->unit, params_rate(hw_params),
@@ -239,7 +193,7 @@ static int fwspk_hw_free(struct snd_pcm_substream *substream)
 	struct fwspk *fwspk = substream->private_data;
 
 	mutex_lock(&fwspk->mutex);
-	fwspk_stop_stream(fwspk);
+	snd_fwspk_stream_stop(fwspk);
 	mutex_unlock(&fwspk->mutex);
 
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
@@ -252,33 +206,15 @@ static int fwspk_prepare(struct snd_pcm_substream *substream)
 
 	mutex_lock(&fwspk->mutex);
 
-	if (amdtp_streaming_error(&fwspk->stream))
-		fwspk_stop_stream(fwspk);
+	snd_fwspk_stream_stop(fwspk);
 
-	if (!amdtp_stream_running(&fwspk->stream)) {
-		err = cmp_connection_establish(&fwspk->connection,
-			amdtp_stream_get_max_payload(&fwspk->stream));
-		if (err < 0)
-			goto err_mutex;
-
-		err = amdtp_stream_start(&fwspk->stream,
-					 fwspk->connection.resources.channel,
-					 fwspk->connection.speed);
-		if (err < 0)
-			goto err_connection;
-	}
-
-	mutex_unlock(&fwspk->mutex);
-
-	amdtp_stream_pcm_prepare(&fwspk->stream);
-
-	return 0;
+	err = snd_fwspk_stream_start(fwspk);
+	if (err < 0)
+		goto end;
 
-err_connection:
-	cmp_connection_break(&fwspk->connection);
-err_mutex:
+	amdtp_stream_pcm_prepare(&fwspk->rx_stream);
+end:
 	mutex_unlock(&fwspk->mutex);
-
 	return err;
 }
 
@@ -297,7 +233,7 @@ static int fwspk_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	amdtp_stream_pcm_trigger(&fwspk->stream, pcm);
+	amdtp_stream_pcm_trigger(&fwspk->rx_stream, pcm);
 	return 0;
 }
 
@@ -305,7 +241,7 @@ static snd_pcm_uframes_t fwspk_pointer(struct snd_pcm_substream *substream)
 {
 	struct fwspk *fwspk = substream->private_data;
 
-	return amdtp_stream_pcm_pointer(&fwspk->stream);
+	return amdtp_stream_pcm_pointer(&fwspk->rx_stream);
 }
 
 static int fwspk_create_pcm(struct fwspk *fwspk)
@@ -623,9 +559,11 @@ static void fwspk_card_free(struct snd_card *card)
 {
 	struct fwspk *fwspk = card->private_data;
 
-	amdtp_stream_destroy(&fwspk->stream);
-	cmp_connection_destroy(&fwspk->connection);
-	fw_unit_put(fwspk->unit);
+	mutex_lock(&fwspk->mutex);
+	snd_fwspk_stream_destroy(fwspk);
+	mutex_unlock(&fwspk->mutex);
+
+	fw_unit_put(fwspk->unit);	/* dec reference counter */
 	mutex_destroy(&fwspk->mutex);
 }
 
@@ -641,24 +579,13 @@ static int fwspk_probe(struct fw_unit *unit,
 	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*fwspk), &card);
 	if (err < 0)
 		return err;
-	snd_card_set_dev(card, &unit->device);
 
+	card->private_free = fwspk_card_free;
 	fwspk = card->private_data;
 	fwspk->card = card;
-	mutex_init(&fwspk->mutex);
-	fwspk->unit = fw_unit_get(unit);
+	fwspk->unit = fw_unit_get(unit);	/* inc reference counter */
 	fwspk->device_info = (const struct device_info *)id->driver_data;
-
-	err = cmp_connection_init(&fwspk->connection, unit, CMP_INPUT, 0);
-	if (err < 0)
-		goto err_unit;
-
-	err = amdtp_stream_init(&fwspk->stream, unit, AMDTP_OUT_STREAM,
-				CIP_NONBLOCKING);
-	if (err < 0)
-		goto err_connection;
-
-	card->private_free = fwspk_card_free;
+	mutex_init(&fwspk->mutex);
 
 	strcpy(card->driver, fwspk->device_info->driver_name);
 	strcpy(card->shortname, fwspk->device_info->short_name);
@@ -671,28 +598,26 @@ static int fwspk_probe(struct fw_unit *unit,
 		 dev_name(&unit->device), 100 << fw_dev->max_speed);
 	strcpy(card->mixername, "OXFW970");
 
+	err = snd_fwspk_stream_init(fwspk);
+	if (err < 0)
+		goto err_card;
+
 	err = fwspk_create_pcm(fwspk);
 	if (err < 0)
-		goto error;
+		goto err_card;
 
 	err = fwspk_create_mixer(fwspk);
 	if (err < 0)
-		goto error;
+		goto err_card;
 
+	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
-		goto error;
-
+		goto err_card;
 	dev_set_drvdata(&unit->device, fwspk);
 
 	return 0;
-
-err_connection:
-	cmp_connection_destroy(&fwspk->connection);
-err_unit:
-	fw_unit_put(fwspk->unit);
-	mutex_destroy(&fwspk->mutex);
-error:
+err_card:
 	snd_card_free(card);
 	return err;
 }
@@ -701,30 +626,20 @@ static void fwspk_bus_reset(struct fw_unit *unit)
 {
 	struct fwspk *fwspk = dev_get_drvdata(&unit->device);
 
-	fcp_bus_reset(fwspk->unit);
+	mutex_lock(&fwspk->mutex);
 
-	if (cmp_connection_update(&fwspk->connection) < 0) {
-		amdtp_stream_pcm_abort(&fwspk->stream);
-		mutex_lock(&fwspk->mutex);
-		fwspk_stop_stream(fwspk);
-		mutex_unlock(&fwspk->mutex);
-		return;
-	}
+	fcp_bus_reset(fwspk->unit);
+	snd_fwspk_stream_update(fwspk);
 
-	amdtp_stream_update(&fwspk->stream);
+	mutex_unlock(&fwspk->mutex);
 }
 
 static void fwspk_remove(struct fw_unit *unit)
 {
 	struct fwspk *fwspk = dev_get_drvdata(&unit->device);
 
-	amdtp_stream_pcm_abort(&fwspk->stream);
+	snd_fwspk_stream_destroy(fwspk);
 	snd_card_disconnect(fwspk->card);
-
-	mutex_lock(&fwspk->mutex);
-	fwspk_stop_stream(fwspk);
-	mutex_unlock(&fwspk->mutex);
-
 	snd_card_free_when_closed(fwspk->card);
 }
 
diff --git a/sound/firewire/speakers/speakers.h b/sound/firewire/speakers/speakers.h
new file mode 100644
index 0000000..d322b8b
--- /dev/null
+++ b/sound/firewire/speakers/speakers.h
@@ -0,0 +1,54 @@
+/*
+ * speakers.h - a part of OXFW970/971-based speakers driver
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
+#include "../cmp.h"
+#include "../fcp.h"
+#include "../amdtp.h"
+#include "../lib.h"
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
+struct fwspk {
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
+int snd_fwspk_stream_init(struct fwspk *fwspk);
+int snd_fwspk_stream_start(struct fwspk *fwspk);
+void snd_fwspk_stream_stop(struct fwspk *fwspk);
+void snd_fwspk_stream_destroy(struct fwspk *fwspk);
+void snd_fwspk_stream_update(struct fwspk *fwspk);
diff --git a/sound/firewire/speakers/speakers_stream.c b/sound/firewire/speakers/speakers_stream.c
new file mode 100644
index 0000000..9cc0ffb
--- /dev/null
+++ b/sound/firewire/speakers/speakers_stream.c
@@ -0,0 +1,72 @@
+/*
+ * speakers_stream.c - a part of OXFW970/971-based speakers driver
+ *
+ * Copyright (c) Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "speakers.h"
+
+int snd_fwspk_stream_init(struct fwspk *fwspk)
+{
+	int err;
+
+	err = cmp_connection_init(&fwspk->in_conn, fwspk->unit,
+				  CMP_INPUT, 0);
+	if (err < 0) {
+		fw_unit_put(fwspk->unit);
+		goto end;
+	}
+
+	err = amdtp_stream_init(&fwspk->rx_stream, fwspk->unit,
+				AMDTP_OUT_STREAM, CIP_NONBLOCKING);
+	if (err < 0)
+		cmp_connection_destroy(&fwspk->in_conn);
+end:
+	return err;
+}
+
+int snd_fwspk_stream_start(struct fwspk *fwspk)
+{
+	int err = 0;
+
+	if (amdtp_stream_running(&fwspk->rx_stream))
+		goto end;
+
+	err = cmp_connection_establish(&fwspk->in_conn,
+		amdtp_stream_get_max_payload(&fwspk->rx_stream));
+	if (err < 0)
+		goto end;
+
+	err = amdtp_stream_start(&fwspk->rx_stream,
+				 fwspk->in_conn.resources.channel,
+				 fwspk->in_conn.speed);
+	if (err < 0)
+		cmp_connection_break(&fwspk->in_conn);
+end:
+	return err;
+}
+
+void snd_fwspk_stream_stop(struct fwspk *fwspk)
+{
+	if (amdtp_stream_running(&fwspk->rx_stream))
+		amdtp_stream_stop(&fwspk->rx_stream);
+
+	cmp_connection_break(&fwspk->in_conn);
+}
+
+void snd_fwspk_stream_destroy(struct fwspk *fwspk)
+{
+	amdtp_stream_pcm_abort(&fwspk->rx_stream);
+	snd_fwspk_stream_stop(fwspk);
+}
+
+void snd_fwspk_stream_update(struct fwspk *fwspk)
+{
+	if (cmp_connection_update(&fwspk->in_conn) < 0) {
+		amdtp_stream_pcm_abort(&fwspk->rx_stream);
+		snd_fwspk_stream_stop(fwspk);
+	} else {
+		amdtp_stream_update(&fwspk->rx_stream);
+	}
+}
-- 
1.8.3.2
