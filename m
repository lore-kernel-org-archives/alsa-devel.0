From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] ALSA: us122l: drop x86 dependency
Date: Fri, 12 May 2017 12:28:21 +0200
Message-ID: <20170512102821.2630-4-johan@kernel.org>
References: <20170512102821.2630-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F4217266BF2
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 12:28:45 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id v42so7036707wrc.3
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 03:28:45 -0700 (PDT)
In-Reply-To: <20170512102821.2630-1-johan@kernel.org>
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
Cc: alsa-devel@alsa-project.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a driver for a USB device and compiles just fine on non-x86 so
drop the x86 dependency.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/usb/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index a452ad7cec40..d6417cef226b 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -91,7 +91,6 @@ config SND_USB_CAIAQ_INPUT
 
 config SND_USB_US122L
 	tristate "Tascam US-122L USB driver"
-	depends on X86
 	select SND_HWDEP
 	select SND_RAWMIDI
 	help
-- 
2.13.0
