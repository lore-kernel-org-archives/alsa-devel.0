From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 098/199] Documentation/sound/oss/PSS: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:48 +0200
Message-ID: <1274644376-24176-6-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/PSS:1: ERROR: trailing whitespace
Documentation/sound/oss/PSS:2: ERROR: trailing whitespace
Documentation/sound/oss/PSS:3: ERROR: trailing whitespace
Documentation/sound/oss/PSS:4: ERROR: trailing whitespace
Documentation/sound/oss/PSS:17: ERROR: trailing whitespace
Documentation/sound/oss/PSS:21: ERROR: trailing whitespace
Documentation/sound/oss/PSS:31: ERROR: trailing whitespace
Documentation/sound/oss/PSS:34: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/PSS |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/sound/oss/PSS b/Documentation/sound/oss/PSS
index 187b952..f173ecf 100644
--- a/Documentation/sound/oss/PSS
+++ b/Documentation/sound/oss/PSS
@@ -1,7 +1,7 @@
-The PSS cards and other ECHO based cards provide an onboard DSP with 
-downloadable programs and also has an AD1848 "Microsoft Sound System" 
-device. The PSS driver enables MSS and MPU401 modes of the card. SB 
-is not enabled since it doesn't work concurrently with MSS. 
+The PSS cards and other ECHO based cards provide an onboard DSP with
+downloadable programs and also has an AD1848 "Microsoft Sound System"
+device. The PSS driver enables MSS and MPU401 modes of the card. SB
+is not enabled since it doesn't work concurrently with MSS.
 
 If you build this driver as a module then the driver takes the following
 parameters
@@ -14,11 +14,11 @@ mss_io		The base address of the Microsoft Sound System interface.
 
 mss_irq		The interrupt assigned to the Microsoft Sound System
 		emulation. IRQ's 3,5,7,9,10,11 and 12 are available. If you
-		get IRQ errors be sure to check the interrupt is set to 
+		get IRQ errors be sure to check the interrupt is set to
 		"ISA/Legacy" in the BIOS on modern machines.
 
 mss_dma		The DMA channel used by the Microsoft Sound System.
-		This can be 0, 1, or 3. DMA 0 is not available on older 
+		This can be 0, 1, or 3. DMA 0 is not available on older
 		machines and will cause a crash on them.
 
 mpu_io		The MPU emulation base address. This sets the base of the
@@ -28,10 +28,10 @@ mpu_irq		The interrupt to use for the synthesizer. It must differ
 		from the IRQ used by the Microsoft Sound System port.
 
 
-The mpu_io/mpu_irq fields are optional. If they are not specified the 
+The mpu_io/mpu_irq fields are optional. If they are not specified the
 synthesizer parts are not configured.
 
-When the module is loaded it looks for a file called 
+When the module is loaded it looks for a file called
 /etc/sound/pss_synth. This is the firmware file from the DOS install disks.
 This fil holds a general MIDI emulation. The file expected is called
 genmidi.ld on newer DOS driver install disks and synth.ld on older ones.
-- 
1.7.1.251.gf80a2

