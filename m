From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 3/3] ALSA: line6: Pass driver name to line6_probe()
Date: Sat,  7 Feb 2015 10:43:19 -0600
Message-ID: <1423327399-12619-4-git-send-email-chris@rorvick.com>
References: <1423327399-12619-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423327399-12619-1-git-send-email-chris@rorvick.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

Provide a unique name for each driver instead of using "line6usb" for
all of them.  This will allow for different configurations based on the
driver type.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 sound/usb/line6/driver.c   | 3 ++-
 sound/usb/line6/driver.h   | 3 +--
 sound/usb/line6/pod.c      | 2 +-
 sound/usb/line6/podhd.c    | 2 +-
 sound/usb/line6/toneport.c | 2 +-
 sound/usb/line6/variax.c   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 2328ec9..1e58e92 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -480,6 +480,7 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 */
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
+		const char *driver_name,
 		const struct line6_properties *properties,
 		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id),
 		size_t data_size)
@@ -511,7 +512,7 @@ int line6_probe(struct usb_interface *interface,
 	line6->ifcdev = &interface->dev;
 
 	strcpy(card->id, properties->id);
-	strcpy(card->driver, DRIVER_NAME);
+	strcpy(card->driver, driver_name);
 	strcpy(card->shortname, properties->name);
 	sprintf(card->longname, "Line 6 %s at USB %s", properties->name,
 		dev_name(line6->ifcdev));
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index fa877a3..8247a6b 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -18,8 +18,6 @@
 
 #include "midi.h"
 
-#define DRIVER_NAME "line6usb"
-
 #define USB_INTERVALS_PER_SECOND 1000
 
 /* Fallback USB interval and max packet size values */
@@ -168,6 +166,7 @@ extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
 
 int line6_probe(struct usb_interface *interface,
 		const struct usb_device_id *id,
+		const char *driver_name,
 		const struct line6_properties *properties,
 		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id),
 		size_t data_size);
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 61aadd7..c4246ad 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -574,7 +574,7 @@ static const struct line6_properties pod_properties_table[] = {
 static int pod_probe(struct usb_interface *interface,
 		     const struct usb_device_id *id)
 {
-	return line6_probe(interface, id,
+	return line6_probe(interface, id, "Line6-POD",
 			   &pod_properties_table[id->driver_info],
 			   pod_init, sizeof(struct usb_line6_pod));
 }
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 9c3c744..63dcaef 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -169,7 +169,7 @@ static const struct line6_properties podhd_properties_table[] = {
 static int podhd_probe(struct usb_interface *interface,
 		       const struct usb_device_id *id)
 {
-	return line6_probe(interface, id,
+	return line6_probe(interface, id, "Line6-PODHD",
 			   &podhd_properties_table[id->driver_info],
 			   podhd_init, sizeof(struct usb_line6));
 }
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 2420d2f..1a0a485 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -557,7 +557,7 @@ static const struct line6_properties toneport_properties_table[] = {
 static int toneport_probe(struct usb_interface *interface,
 			  const struct usb_device_id *id)
 {
-	return line6_probe(interface, id,
+	return line6_probe(interface, id, "Line6-TonePort",
 			   &toneport_properties_table[id->driver_info],
 			   toneport_init, sizeof(struct usb_line6_toneport));
 }
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index b1c1de6..ddc23dd 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -283,7 +283,7 @@ static const struct line6_properties variax_properties_table[] = {
 static int variax_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
-	return line6_probe(interface, id,
+	return line6_probe(interface, id, "Line6-Variax",
 			   &variax_properties_table[id->driver_info],
 			   variax_init, sizeof(struct usb_line6_variax));
 }
-- 
2.1.0
