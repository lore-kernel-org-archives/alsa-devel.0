From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/5] ALSA: usb-audio: export
	snd_usb_feature_unit_ctl
Date: Wed, 25 May 2011 09:09:01 +0200
Message-ID: <1306307343-3247-4-git-send-email-zonque@gmail.com>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BB59103866
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 09:09:33 +0200 (CEST)
In-Reply-To: <1306307343-3247-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, gdiffey@gmail.com, clemens@ladisch.de, linuxaudio@showlabor.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In order to allow quirks functions to hook up to the standard feature
unit op tables, this patch exports a pointer to the struct that is used
internally.

That way, all the code handling the control can be kept private, and
external code can reference the symbol to re-use it.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/usb/card.c   |    1 +
 sound/usb/mixer.c  |   13 +++----------
 sound/usb/mixer.h  |   11 ++++++++++-
 sound/usb/quirks.c |    1 +
 4 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 84a5ce7..220c616 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -48,6 +48,7 @@
 #include <linux/usb/audio.h>
 #include <linux/usb/audio-v2.h>
 
+#include <sound/control.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/pcm.h>
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ba19bfd..c22fa76 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -86,16 +86,6 @@ struct mixer_build {
 	const struct usbmix_selector_map *selector_map;
 };
 
-enum {
-	USB_MIXER_BOOLEAN,
-	USB_MIXER_INV_BOOLEAN,
-	USB_MIXER_S8,
-	USB_MIXER_U8,
-	USB_MIXER_S16,
-	USB_MIXER_U16,
-};
-
-
 /*E-mu 0202/0404/0204 eXtension Unit(XU) control*/
 enum {
 	USB_XU_CLOCK_RATE 		= 0xe301,
@@ -985,6 +975,9 @@ static struct snd_kcontrol_new usb_feature_unit_ctl_ro = {
 	.put = NULL,
 };
 
+/* This symbol is exported in order to allow the mixer quirks to
+ * hook up to the standard feature unit control mechanism */
+struct snd_kcontrol_new *snd_usb_feature_unit_ctl = &usb_feature_unit_ctl;
 
 /*
  * build a feature control
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 459551a..ae1a14d 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -24,7 +24,16 @@ struct usb_mixer_interface {
 	u8 xonar_u1_status;
 };
 
-#define MAX_CHANNELS	10	/* max logical channels */
+#define MAX_CHANNELS	16	/* max logical channels */
+
+enum {
+	USB_MIXER_BOOLEAN,
+	USB_MIXER_INV_BOOLEAN,
+	USB_MIXER_S8,
+	USB_MIXER_U8,
+	USB_MIXER_S16,
+	USB_MIXER_U16,
+};
 
 struct usb_mixer_elem_info {
 	struct usb_mixer_interface *mixer;
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index bd13d72..2546dc8 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -19,6 +19,7 @@
 #include <linux/usb.h>
 #include <linux/usb/audio.h>
 
+#include <sound/control.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/pcm.h>
-- 
1.7.5.1
