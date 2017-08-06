From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/7] ALSA: usb-audio: constify usb_device_id.
Date: Sun,  6 Aug 2017 12:18:56 +0530
Message-ID: <1502002139-10787-5-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, zonque@gmail.com, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/usb/card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 6640277..3dc36d9 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -486,7 +486,7 @@ static bool get_alias_id(struct usb_device *dev, unsigned int *id)
 	return false;
 }
 
-static struct usb_device_id usb_audio_ids[]; /* defined below */
+static const struct usb_device_id usb_audio_ids[]; /* defined below */
 
 /* look for the corresponding quirk */
 static const struct snd_usb_audio_quirk *
@@ -814,7 +814,7 @@ static int usb_audio_reset_resume(struct usb_interface *intf)
 #define usb_audio_reset_resume	NULL
 #endif		/* CONFIG_PM */
 
-static struct usb_device_id usb_audio_ids [] = {
+static const struct usb_device_id usb_audio_ids [] = {
 #include "quirks-table.h"
     { .match_flags = (USB_DEVICE_ID_MATCH_INT_CLASS | USB_DEVICE_ID_MATCH_INT_SUBCLASS),
       .bInterfaceClass = USB_CLASS_AUDIO,
-- 
2.7.4
