From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: usx2y: Move UAPI definition into
	include/uapi/sound/usb_stream.h
Date: Wed, 28 Jan 2015 17:37:46 +0100
Message-ID: <1422463066-18969-5-git-send-email-tiwai@suse.de>
References: <1422463066-18969-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0759261B35
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:37:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1F377AB9B
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 16:37:48 +0000 (UTC)
In-Reply-To: <1422463066-18969-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The user-space API definition for usb_stream stuff should be moved
to include/uapi/sound to be exposed publicly.

While we're at it, add the missing ifdef guard for double inclusion,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/uapi/sound/usb_stream.h | 76 +++++++++++++++++++++++++++++++++++++++
 sound/usb/usx2y/usb_stream.h    | 78 +++--------------------------------------
 2 files changed, 80 insertions(+), 74 deletions(-)
 create mode 100644 include/uapi/sound/usb_stream.h

diff --git a/include/uapi/sound/usb_stream.h b/include/uapi/sound/usb_stream.h
new file mode 100644
index 000000000000..cfe8fba00714
--- /dev/null
+++ b/include/uapi/sound/usb_stream.h
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2007, 2008 Karsten Wiese <fzu@wemgehoertderstaat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _UAPI__SOUND_USB_STREAM_H
+#define _UAPI__SOUND_USB_STREAM_H
+
+#define USB_STREAM_INTERFACE_VERSION 2
+
+#define SNDRV_USB_STREAM_IOCTL_SET_PARAMS \
+	_IOW('H', 0x90, struct usb_stream_config)
+
+struct usb_stream_packet {
+	unsigned offset;
+	unsigned length;
+};
+
+
+struct usb_stream_config {
+	unsigned version;
+	unsigned sample_rate;
+	unsigned period_frames;
+	unsigned frame_size;
+};
+
+struct usb_stream {
+	struct usb_stream_config cfg;
+	unsigned read_size;
+	unsigned write_size;
+
+	int period_size;
+
+	unsigned state;
+
+	int idle_insize;
+	int idle_outsize;
+	int sync_packet;
+	unsigned insize_done;
+	unsigned periods_done;
+	unsigned periods_polled;
+
+	struct usb_stream_packet outpacket[2];
+	unsigned		 inpackets;
+	unsigned		 inpacket_head;
+	unsigned		 inpacket_split;
+	unsigned		 inpacket_split_at;
+	unsigned		 next_inpacket_split;
+	unsigned		 next_inpacket_split_at;
+	struct usb_stream_packet inpacket[0];
+};
+
+enum usb_stream_state {
+	usb_stream_invalid,
+	usb_stream_stopped,
+	usb_stream_sync0,
+	usb_stream_sync1,
+	usb_stream_ready,
+	usb_stream_running,
+	usb_stream_xrun,
+};
+
+#endif /* _UAPI__SOUND_USB_STREAM_H */
diff --git a/sound/usb/usx2y/usb_stream.h b/sound/usb/usx2y/usb_stream.h
index 4dd74ab1e9cc..90369001eab6 100644
--- a/sound/usb/usx2y/usb_stream.h
+++ b/sound/usb/usx2y/usb_stream.h
@@ -1,76 +1,7 @@
-/*
- * Copyright (C) 2007, 2008 Karsten Wiese <fzu@wemgehoertderstaat.de>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
- * for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundation,
- * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
+#ifndef __USB_STREAM_H
+#define __USB_STREAM_H
 
-#define USB_STREAM_INTERFACE_VERSION 2
-
-#define SNDRV_USB_STREAM_IOCTL_SET_PARAMS \
-	_IOW('H', 0x90, struct usb_stream_config)
-
-struct usb_stream_packet {
-	unsigned offset;
-	unsigned length;
-};
-
-
-struct usb_stream_config {
-	unsigned version;
-	unsigned sample_rate;
-	unsigned period_frames;
-	unsigned frame_size;
-};
-
-struct usb_stream {
-	struct usb_stream_config cfg;
-	unsigned read_size;
-	unsigned write_size;
-
-	int period_size;
-
-	unsigned state;
-
-	int idle_insize;
-	int idle_outsize;
-	int sync_packet;
-	unsigned insize_done;
-	unsigned periods_done;
-	unsigned periods_polled;
-
-	struct usb_stream_packet outpacket[2];
-	unsigned		 inpackets;
-	unsigned		 inpacket_head;
-	unsigned		 inpacket_split;
-	unsigned		 inpacket_split_at;
-	unsigned		 next_inpacket_split;
-	unsigned		 next_inpacket_split_at;
-	struct usb_stream_packet inpacket[0];
-};
-
-enum usb_stream_state {
-	usb_stream_invalid,
-	usb_stream_stopped,
-	usb_stream_sync0,
-	usb_stream_sync1,
-	usb_stream_ready,
-	usb_stream_running,
-	usb_stream_xrun,
-};
-
-#if __KERNEL__
+#include <uapi/sound/usb_stream.h>
 
 #define USB_STREAM_NURBS 4
 #define USB_STREAM_URBDEPTH 4
@@ -108,5 +39,4 @@ void usb_stream_free(struct usb_stream_kernel *);
 int usb_stream_start(struct usb_stream_kernel *);
 void usb_stream_stop(struct usb_stream_kernel *);
 
-
-#endif
+#endif /* __USB_STREAM_H */
-- 
2.2.2
