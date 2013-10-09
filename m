From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ALSA: usb-audio: Use module_usb_driver
Date: Wed,  9 Oct 2013 17:22:32 +0530
Message-ID: <1381319552-18963-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A7472610AC
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 13:53:07 +0200 (CEST)
Received: by mail-pd0-f171.google.com with SMTP id g10so795402pdj.30
 for <alsa-devel@alsa-project.org>; Wed, 09 Oct 2013 04:53:03 -0700 (PDT)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org
List-Id: alsa-devel@alsa-project.org

module_usb_driver makes code simpler by removing the boilerplate.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/usb/card.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 9d9de8d..d979050 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -751,15 +751,4 @@ static struct usb_driver usb_audio_driver = {
 	.supports_autosuspend = 1,
 };
 
-static int __init snd_usb_audio_init(void)
-{
-	return usb_register(&usb_audio_driver);
-}
-
-static void __exit snd_usb_audio_cleanup(void)
-{
-	usb_deregister(&usb_audio_driver);
-}
-
-module_init(snd_usb_audio_init);
-module_exit(snd_usb_audio_cleanup);
+module_usb_driver(usb_audio_driver);
-- 
1.7.9.5
