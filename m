From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/5] ALSA: usb-audio: move and add some comments
Date: Wed, 16 Jun 2010 17:57:30 +0200
Message-ID: <1276703851-22199-5-git-send-email-daniel@caiaq.de>
References: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 66CCE1038FD
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 17:57:50 +0200 (CEST)
In-Reply-To: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Also add a list of open topics.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 include/linux/usb/audio-v2.h |   15 +++++++++++++++
 sound/usb/clock.c            |   16 ++++++++++++++--
 sound/usb/mixer.c            |   24 ++++++++++++++++--------
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/linux/usb/audio-v2.h b/include/linux/usb/audio-v2.h
index 716aebe..964cb60 100644
--- a/include/linux/usb/audio-v2.h
+++ b/include/linux/usb/audio-v2.h
@@ -18,6 +18,21 @@
 /* v1.0 and v2.0 of this standard have many things in common. For the rest
  * of the definitions, please refer to audio.h */
 
+/*
+ * bmControl field decoders
+ *
+ * From the USB Audio spec v2.0:
+ *
+ *   bmaControls() is a (ch+1)-element array of 4-byte bitmaps,
+ *   each containing a set of bit pairs. If a Control is present,
+ *   it must be Host readable. If a certain Control is not
+ *   present then the bit pair must be set to 0b00.
+ *   If a Control is present but read-only, the bit pair must be
+ *   set to 0b01. If a Control is also Host programmable, the bit
+ *   pair must be set to 0b11. The value 0b10 is not allowed.
+ *
+ */
+
 static inline bool uac2_control_is_readable(u32 bmControls, u8 control)
 {
 	return (bmControls >> (control * 2)) & 0x1;
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 386b09c..7279d61 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -120,8 +120,6 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 	return !!data;
 }
 
-/* Try to find the clock source ID of a given clock entity */
-
 static int __uac_clock_find_source(struct snd_usb_audio *chip,
 				   struct usb_host_interface *host_iface,
 				   int entity_id, unsigned long *visited)
@@ -154,6 +152,8 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 		if (ret < 0)
 			return ret;
 
+		/* Selector values are one-based */
+
 		if (ret > selector->bNrInPins || ret < 1) {
 			printk(KERN_ERR
 				"%s(): selector reported illegal value, id %d, ret %d\n",
@@ -176,6 +176,17 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	return -EINVAL;
 }
 
+/*
+ * For all kinds of sample rate settings and other device queries,
+ * the clock source (end-leaf) must be used. However, clock selectors,
+ * clock multipliers and sample rate converters may be specified as
+ * clock source input to terminal. This functions walks the clock path
+ * to its end and tries to find the source.
+ *
+ * The 'visited' bitfield is used internally to detect recursive loops.
+ *
+ * Returns the clock source UnitID (>=0) on success, or an error.
+ */
 int snd_usb_clock_find_source(struct snd_usb_audio *chip,
 			      struct usb_host_interface *host_iface,
 			      int entity_id)
@@ -246,6 +257,7 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 		return clock;
 
 	if (!uac_clock_source_is_valid(chip, clock)) {
+		/* TODO: should we try to find valid clock setups by ourself? */
 		snd_printk(KERN_ERR "%d:%d:%d: clock source %d is not valid, cannot use\n",
 			   dev->devnum, iface, fmt->altsetting, clock);
 		return -ENXIO;
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index b6a261f..7ffea71 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -26,6 +26,22 @@
  *
  */
 
+/*
+ * TODOs, for both the mixer and the streaming interfaces:
+ *
+ *  - support for UAC2 effect units
+ *  - support for graphical equalizers
+ *  - RANGE and MEM set commands (UAC2)
+ *  - RANGE and MEM interrupt dispatchers (UAC2)
+ *  - audio channel clustering (UAC2)
+ *  - audio sample rate converter units (UAC2)
+ *  - proper handling of clock multipliers (UAC2)
+ *  - dispatch clock change notifications (UAC2)
+ *  	- stop PCM streams which use a clock that became invalid
+ *  	- stop PCM streams which use a clock selector that has changed
+ *  	- parse available sample rates again when clock sources changed
+ */
+
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -1186,14 +1202,6 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid, void
 		}
 	} else { /* UAC_VERSION_2 */
 		for (i = 0; i < 30/2; i++) {
-			/* From the USB Audio spec v2.0:
-			   bmaControls() is a (ch+1)-element array of 4-byte bitmaps,
-			   each containing a set of bit pairs. If a Control is present,
-			   it must be Host readable. If a certain Control is not
-			   present then the bit pair must be set to 0b00.
-			   If a Control is present but read-only, the bit pair must be
-			   set to 0b01. If a Control is also Host programmable, the bit
-			   pair must be set to 0b11. The value 0b10 is not allowed. */
 			unsigned int ch_bits = 0;
 			unsigned int ch_read_only = 0;
 
-- 
1.7.1
