From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 092/199] Documentation/sound/oss/ALS: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:43 +0200
Message-ID: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/ALS:15: ERROR: trailing whitespace
Documentation/sound/oss/ALS:40: ERROR: trailing whitespace
Documentation/sound/oss/ALS:55: ERROR: trailing whitespace
Documentation/sound/oss/ALS:56: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/ALS |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/oss/ALS b/Documentation/sound/oss/ALS
index d01ffbf..282a2e1 100644
--- a/Documentation/sound/oss/ALS
+++ b/Documentation/sound/oss/ALS
@@ -12,7 +12,7 @@ SB16 driver).
 To use an ALS sound card under Linux, enable the following options as
 modules in the sound configuration section of the kernel config:
   - 100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support
-  - FM synthesizer (YM3812/OPL-3) support 
+  - FM synthesizer (YM3812/OPL-3) support
   - standalone MPU401 support may be required for some cards; for the
     ALS-007, when using isapnptools, it is required
 Since the ALS-007/100/200 are PnP cards, ISAPnP support should probably be
@@ -37,7 +37,7 @@ requires they be different.  For "sb", "io", "irq" and "dma" should be set
 to the same values used to configure the audio section of the card with
 isapnp.  "dma16" should be explicitly set to "-1" for an ALS-007 since this
 card does not have a 16 bit dma channel; if not specified the kernel will
-default to using channel 5 anyway which will cause audio not to work. 
+default to using channel 5 anyway which will cause audio not to work.
 "mpu_io" should be set to 0.  The "io" parameter of the "opl3" module should
 also agree with the setting used by isapnp.  To get the MPU401 interface
 working on an ALS-007 card, the "mpu401" module will be required since this
@@ -52,8 +52,8 @@ The resulting sound driver will provide the following capabilities:
   - Software selection of record source (line in, CD, FM, mic, master)
   - Record and playback of midi data via the external MPU-401
   - Playback of midi data using inbuilt FM synthesizer
-  - Control of the ALS-007 mixer via any OSS-compatible mixer programs. 
-    Controls available are Master (L&R), Line in (L&R), CD (L&R), 
+  - Control of the ALS-007 mixer via any OSS-compatible mixer programs.
+    Controls available are Master (L&R), Line in (L&R), CD (L&R),
     DSP/PCM/audio out (L&R), FM (L&R) and Mic in (mono).
 
 Jonathan Woithe
-- 
1.7.1.251.gf80a2

