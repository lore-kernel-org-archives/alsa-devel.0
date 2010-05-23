From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 096/199] Documentation/sound/oss/Opti: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:46 +0200
Message-ID: <1274644376-24176-4-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/Opti:86: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/Opti |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/sound/oss/Opti b/Documentation/sound/oss/Opti
index c15af3c..d5cb3e9 100644
--- a/Documentation/sound/oss/Opti
+++ b/Documentation/sound/oss/Opti
@@ -83,7 +83,7 @@ options opl3 io=0x388
 install mad16 /sbin/modprobe -i mad16 && /sbin/ad1848_mixer_reroute 14 8 15 3 16 6
 
 If you have an MPU daughtercard or onboard MPU you will want to add to the
-"options mad16" line - eg 
+"options mad16" line - eg
 
 options mad16 irq=5 dma=0 dma16=3 io=0x530 mpu_io=0x330 mpu_irq=9
 
-- 
1.7.1.251.gf80a2

