From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 097/199] Documentation/sound/oss/PAS16: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:47 +0200
Message-ID: <1274644376-24176-5-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/PAS16:35: ERROR: trailing whitespace
Documentation/sound/oss/PAS16:127: ERROR: trailing whitespace
Documentation/sound/oss/PAS16:131: ERROR: trailing whitespace
Documentation/sound/oss/PAS16:155: ERROR: trailing whitespace
Documentation/sound/oss/PAS16:161: ERROR: trailing whitespace
Documentation/sound/oss/PAS16:163: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/PAS16 |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/sound/oss/PAS16 b/Documentation/sound/oss/PAS16
index 951b3dc..fbf0a6a 100644
--- a/Documentation/sound/oss/PAS16
+++ b/Documentation/sound/oss/PAS16
@@ -32,7 +32,7 @@ when answering to these questions since answering y to a question may
 prevent some later ones from being asked. For example don't answer y to
 the question about (PAS16) if you don't really have a PAS16.  Sound
 configuration may also be made modular by answering m to configuration
-options presented. 
+options presented.
 
 Note also that all questions may not be asked. The configuration program
 may disable some questions depending on the earlier choices. It may also
@@ -124,11 +124,11 @@ CONFIG_SOUND_YM3812
   If you compile the driver into the kernel, you have to add
   "opl3=<io>" to the kernel command line.
 
-  If you compile your drivers into the kernel, you MUST configure 
+  If you compile your drivers into the kernel, you MUST configure
   OPL3 support as a module for PAS16 support to work properly.
   You can then get OPL3 functionality by issuing the command:
   insmod opl3
-  In addition, you must either add the following line to 
+  In addition, you must either add the following line to
   /etc/modprobe.conf:
   options opl3 io=0x388
   or else add the following line to /etc/lilo.conf:
@@ -152,12 +152,12 @@ I have also included the following append line in /etc/lilo.conf:
 append="pas2=0x388,10,3,-1,0x220,5,1,-1 sb=0x220,5,1,-1 opl3=0x388"
 
 The io address of 0x388 is default configuration on the PAS16.  The
-irq of 10 and dma of 3 may not match your installation.  The above 
+irq of 10 and dma of 3 may not match your installation.  The above
 configuration enables PAS16, 8-bit Soundblaster and OPL3
 functionality.  If Soundblaster functionality is not desired, the
 following line would be appropriate:
 append="pas2=0x388,10,3,-1,0,-1,-1,-1 opl3=0x388"
 
-If sound is built totally modular, the above options may be 
+If sound is built totally modular, the above options may be
 specified in /etc/modprobe.conf for pas2, sb and opl3
-respectively. 
+respectively.
-- 
1.7.1.251.gf80a2

