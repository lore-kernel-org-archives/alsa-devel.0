From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/3] ALSA: us122l: enable compile testing
Date: Fri, 12 May 2017 14:34:39 +0200
Message-ID: <20170512123439.14994-4-johan@kernel.org>
References: <20170512123439.14994-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id B0BB0267131
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 14:34:58 +0200 (CEST)
Received: by mail-lf0-f67.google.com with SMTP id q24so57342lfb.1
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 05:34:58 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

This USB driver currently depends on X86 for some undocumented reason.
Since it compiles just fine for arm, we can at least enable compile
testing.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/usb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index a452ad7cec40..f61b5662bb89 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -91,7 +91,7 @@ config SND_USB_CAIAQ_INPUT
 
 config SND_USB_US122L
 	tristate "Tascam US-122L USB driver"
-	depends on X86
+	depends on X86 || COMPILE_TEST
 	select SND_HWDEP
 	select SND_RAWMIDI
 	help
-- 
2.13.0
