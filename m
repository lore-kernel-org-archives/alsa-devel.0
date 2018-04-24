From: Khem Raj <raj.khem@gmail.com>
Subject: [alsa-tools][PATCH] Fix clang
	-Wreserved-user-defined-literal warnings
Date: Tue, 24 Apr 2018 12:24:32 -0700
Message-ID: <20180424192432.41355-1-raj.khem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 687512676AB
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 21:24:41 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id f189so3985945pfa.7
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 12:24:41 -0700 (PDT)
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
Cc: tiwai@suse.de, broonie@sirena.org.uk, Khem Raj <raj.khem@gmail.com>
List-Id: alsa-devel@alsa-project.org

| us428control.cc:66:18: error: invalid suffix on literal; C++11 requires a space between literal and identifier [-Wreserved-user-defined-literal]
|         printf("usage: "PROGNAME" [-v verbosity_level 0..2] [-c card] [-D device] [-u usb-device] [-m mode]\n");
|                         ^

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 us428control/us428control.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/us428control/us428control.cc b/us428control/us428control.cc
index e839bf4..8cb3c42 100644
--- a/us428control/us428control.cc
+++ b/us428control/us428control.cc
@@ -63,7 +63,7 @@ static void usage(void)
 {
 	printf("Tascam US-428 Control\n");
 	printf("version %s\n", VERSION);
-	printf("usage: "PROGNAME" [-v verbosity_level 0..2] [-c card] [-D device] [-u usb-device] [-m mode]\n");
+	printf("usage: " PROGNAME " [-v verbosity_level 0..2] [-c card] [-D device] [-u usb-device] [-m mode]\n");
 	printf("mode is one of (us224, us428, mixxx)\n");
 }
 /*
-- 
2.17.0
