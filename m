From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/3] ALSA: usb: header file cleanups
Date: Fri, 26 Feb 2010 15:34:42 +0100
Message-ID: <1267194883-6854-3-git-send-email-daniel@caiaq.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CDB38103A52
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:35:29 +0100 (CET)
In-Reply-To: <1267194883-6854-2-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Rename snd-usb-lib to snd-usbmidi-lib as MIDI functions are the only
thing it actually contains. Introduce a new header file to only declare
these functions.

Introduced usbmixer.h for all functions exported by usbmixer.c.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/Makefile         |   11 +++++----
 sound/usb/ua101/ua101.c    |    1 +
 sound/usb/usbaudio.c       |    3 +-
 sound/usb/usbaudio.h       |   51 --------------------------------------------
 sound/usb/usbmidi.c        |    1 +
 sound/usb/usbmidi.h        |   48 +++++++++++++++++++++++++++++++++++++++++
 sound/usb/usbmixer.c       |    1 +
 sound/usb/usbmixer.h       |   11 +++++++++
 sound/usb/usx2y/us122l.c   |    1 +
 sound/usb/usx2y/usbusx2y.h |    1 +
 10 files changed, 72 insertions(+), 57 deletions(-)
 create mode 100644 sound/usb/usbmidi.h
 create mode 100644 sound/usb/usbmixer.h

diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 8bc005b..dc31306 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -3,12 +3,13 @@
 #
 
 snd-usb-audio-objs := usbaudio.o usbmixer.o
-snd-usb-lib-objs := usbmidi.o
+snd-usbmidi-lib-objs := usbmidi.o
 
 # Toplevel Module Dependency
-obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usb-lib.o
-obj-$(CONFIG_SND_USB_UA101) += snd-usb-lib.o
-obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-lib.o
-obj-$(CONFIG_SND_USB_US122L) += snd-usb-lib.o
+obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usbmidi-lib.o
+
+obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
+obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
+obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
 
 obj-$(CONFIG_SND) += ua101/ usx2y/ caiaq/
diff --git a/sound/usb/ua101/ua101.c b/sound/usb/ua101/ua101.c
index c7dcfe2..34a55c3 100644
--- a/sound/usb/ua101/ua101.c
+++ b/sound/usb/ua101/ua101.c
@@ -24,6 +24,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include "../usbaudio.h"
+#include "../usbmidi.h"
 
 MODULE_DESCRIPTION("Edirol UA-101 driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index c539f7f..02870d5 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -56,7 +56,8 @@
 #include <sound/initval.h>
 
 #include "usbaudio.h"
-
+#include "usbmidi.h"
+#include "usbmixer.h"
 
 MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("USB Audio");
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 6b016d4..4fde472 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -21,9 +21,6 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-/* maximum number of endpoints per interface */
-#define MIDI_MAX_ENDPOINTS 2
-
 /* handling of USB vendor/product ID pairs as 32-bit numbers */
 #define USB_ID(vendor, product) (((vendor) << 16) | (product))
 #define USB_ID_VENDOR(id) ((id) >> 16)
@@ -90,39 +87,6 @@ struct snd_usb_audio_quirk {
 	const void *data;
 };
 
-/* data for QUIRK_MIDI_FIXED_ENDPOINT */
-struct snd_usb_midi_endpoint_info {
-	int8_t   out_ep;	/* ep number, 0 autodetect */
-	uint8_t  out_interval;	/* interval for interrupt endpoints */
-	int8_t   in_ep;	
-	uint8_t  in_interval;
-	uint16_t out_cables;	/* bitmask */
-	uint16_t in_cables;	/* bitmask */
-};
-
-/* for QUIRK_MIDI_YAMAHA, data is NULL */
-
-/* for QUIRK_MIDI_MIDIMAN, data points to a snd_usb_midi_endpoint_info
- * structure (out_cables and in_cables only) */
-
-/* for QUIRK_COMPOSITE, data points to an array of snd_usb_audio_quirk
- * structures, terminated with .ifnum = -1 */
-
-/* for QUIRK_AUDIO_FIXED_ENDPOINT, data points to an audioformat structure */
-
-/* for QUIRK_AUDIO/MIDI_STANDARD_INTERFACE, data is NULL */
-
-/* for QUIRK_AUDIO_EDIROL_UA700_UA25/UA1000, data is NULL */
-
-/* for QUIRK_IGNORE_INTERFACE, data is NULL */
-
-/* for QUIRK_MIDI_NOVATION and _RAW, data is NULL */
-
-/* for QUIRK_MIDI_EMAGIC, data points to a snd_usb_midi_endpoint_info
- * structure (out_cables and in_cables only) */
-
-/* for QUIRK_MIDI_CME, data is NULL */
-
 /*
  */
 
@@ -149,21 +113,6 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
 		    __u8 request, __u8 requesttype, __u16 value, __u16 index,
 		    void *data, __u16 size, int timeout);
 
-int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
-			 int ignore_error);
-void snd_usb_mixer_disconnect(struct list_head *p);
-
-int snd_usbmidi_create(struct snd_card *card,
-		       struct usb_interface *iface,
-		       struct list_head *midi_list,
-		       const struct snd_usb_audio_quirk *quirk);
-void snd_usbmidi_input_stop(struct list_head* p);
-void snd_usbmidi_input_start(struct list_head* p);
-void snd_usbmidi_disconnect(struct list_head *p);
-
-void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
-			unsigned char samplerate_id);
-
 /*
  * retrieve usb_interface descriptor from the host interface
  * (conditional for compatibility with the older API)
diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index 2c59afd..5915a04 100644
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -53,6 +53,7 @@
 #include <sound/rawmidi.h>
 #include <sound/asequencer.h>
 #include "usbaudio.h"
+#include "usbmidi.h"
 
 
 /*
diff --git a/sound/usb/usbmidi.h b/sound/usb/usbmidi.h
new file mode 100644
index 0000000..2089ec9
--- /dev/null
+++ b/sound/usb/usbmidi.h
@@ -0,0 +1,48 @@
+#ifndef __USBMIDI_H
+#define __USBMIDI_H
+
+/* maximum number of endpoints per interface */
+#define MIDI_MAX_ENDPOINTS 2
+
+/* data for QUIRK_MIDI_FIXED_ENDPOINT */
+struct snd_usb_midi_endpoint_info {
+	int8_t   out_ep;	/* ep number, 0 autodetect */
+	uint8_t  out_interval;	/* interval for interrupt endpoints */
+	int8_t   in_ep;
+	uint8_t  in_interval;
+	uint16_t out_cables;	/* bitmask */
+	uint16_t in_cables;	/* bitmask */
+};
+
+/* for QUIRK_MIDI_YAMAHA, data is NULL */
+
+/* for QUIRK_MIDI_MIDIMAN, data points to a snd_usb_midi_endpoint_info
+ * structure (out_cables and in_cables only) */
+
+/* for QUIRK_COMPOSITE, data points to an array of snd_usb_audio_quirk
+ * structures, terminated with .ifnum = -1 */
+
+/* for QUIRK_AUDIO_FIXED_ENDPOINT, data points to an audioformat structure */
+
+/* for QUIRK_AUDIO/MIDI_STANDARD_INTERFACE, data is NULL */
+
+/* for QUIRK_AUDIO_EDIROL_UA700_UA25/UA1000, data is NULL */
+
+/* for QUIRK_IGNORE_INTERFACE, data is NULL */
+
+/* for QUIRK_MIDI_NOVATION and _RAW, data is NULL */
+
+/* for QUIRK_MIDI_EMAGIC, data points to a snd_usb_midi_endpoint_info
+ * structure (out_cables and in_cables only) */
+
+/* for QUIRK_MIDI_CME, data is NULL */
+
+int snd_usbmidi_create(struct snd_card *card,
+		       struct usb_interface *iface,
+		       struct list_head *midi_list,
+		       const struct snd_usb_audio_quirk *quirk);
+void snd_usbmidi_input_stop(struct list_head* p);
+void snd_usbmidi_input_start(struct list_head* p);
+void snd_usbmidi_disconnect(struct list_head *p);
+
+#endif /* __USBMIDI_H */
diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 8e8f871..43d53a3 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -41,6 +41,7 @@
 #include <sound/tlv.h>
 
 #include "usbaudio.h"
+#include "usbmixer.h"
 
 /*
  */
diff --git a/sound/usb/usbmixer.h b/sound/usb/usbmixer.h
new file mode 100644
index 0000000..e199e4b
--- /dev/null
+++ b/sound/usb/usbmixer.h
@@ -0,0 +1,11 @@
+#ifndef __USBMIXER_H
+#define __USBMIXER_H
+
+int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
+			 int ignore_error);
+void snd_usb_mixer_disconnect(struct list_head *p);
+
+void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
+			unsigned char samplerate_id);
+
+#endif /* __USBMIXER_H */
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 44deb21..4f6518c 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -25,6 +25,7 @@
 #define MODNAME "US122L"
 #include "usb_stream.c"
 #include "../usbaudio.h"
+#include "../usbmidi.h"
 #include "us122l.h"
 
 MODULE_AUTHOR("Karsten Wiese <fzu@wemgehoertderstaat.de>");
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 1d174ce..9ab97b4 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -1,6 +1,7 @@
 #ifndef USBUSX2Y_H
 #define USBUSX2Y_H
 #include "../usbaudio.h"
+#include "../usbmidi.h"
 #include "usbus428ctldefs.h" 
 
 #define NRURBS	        2	
-- 
1.6.6.2
