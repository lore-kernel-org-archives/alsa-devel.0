From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/3] ALSA: usb-audio: fix Amanero Combo384
	quirk on big-endian hosts
Date: Fri, 12 May 2017 14:34:37 +0200
Message-ID: <20170512123439.14994-2-johan@kernel.org>
References: <20170512123439.14994-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f65.google.com (mail-lf0-f65.google.com
 [209.85.215.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D452D267129
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 14:34:57 +0200 (CEST)
Received: by mail-lf0-f65.google.com with SMTP id 99so57372lfu.2
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 05:34:57 -0700 (PDT)
In-Reply-To: <20170512123439.14994-1-johan@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Johan Hovold <johan@kernel.org>, Jussi Laako <jussi@sonarnerd.net>
List-Id: alsa-devel@alsa-project.org

Add missing endianness conversion when using the USB device-descriptor
bcdDevice field when applying the Amanero Combo384 (endianness!) quirk.

Fixes: 3eff682d765b ("ALSA: usb-audio: Support both DSD LE/BE Amanero firmware versions")
Cc: Jussi Laako <jussi@sonarnerd.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/usb/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 01eff6ce6401..d7b0b0a3a2db 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1364,7 +1364,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	/* Amanero Combo384 USB interface with native DSD support */
 	case USB_ID(0x16d0, 0x071a):
 		if (fp->altsetting == 2) {
-			switch (chip->dev->descriptor.bcdDevice) {
+			switch (le16_to_cpu(chip->dev->descriptor.bcdDevice)) {
 			case 0x199:
 				return SNDRV_PCM_FMTBIT_DSD_U32_LE;
 			case 0x19b:
-- 
2.13.0
