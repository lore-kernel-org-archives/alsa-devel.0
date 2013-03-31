From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 02/10] ALSA: usb-audio: neaten
	MODULE_DEVICE_TABLE placement
Date: Sun, 31 Mar 2013 17:52:24 +0200
Message-ID: <1364745152-1762-3-git-send-email-eldad@fogrefinery.com>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f49.google.com (mail-bk0-f49.google.com
 [209.85.214.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 505BD261723
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:53:01 +0200 (CEST)
Received: by mail-bk0-f49.google.com with SMTP id w12so671826bku.8
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:53:01 -0700 (PDT)
In-Reply-To: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Minor style fix, following a general code style in the kernel.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 8bab36c..314e8a2 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -714,8 +714,7 @@ static struct usb_device_id usb_audio_ids [] = {
       .bInterfaceSubClass = USB_SUBCLASS_AUDIOCONTROL },
     { }						/* Terminating entry */
 };
-
-MODULE_DEVICE_TABLE (usb, usb_audio_ids);
+MODULE_DEVICE_TABLE(usb, usb_audio_ids);
 
 /*
  * entry point for linux usb interface
-- 
1.8.1.5
