From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 024/199] Documentation/sound/alsa/emu10k1-jack.txt: Checkpatch cleanup
Date: Sun, 23 May 2010 21:55:57 +0200
Message-ID: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/alsa/emu10k1-jack.txt:3: ERROR: trailing whitespace
Documentation/sound/alsa/emu10k1-jack.txt:39: ERROR: trailing whitespace
Documentation/sound/alsa/emu10k1-jack.txt:58: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/alsa/emu10k1-jack.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/sound/alsa/emu10k1-jack.txt b/Documentation/sound/alsa/emu10k1-jack.txt
index 751d450..3cc6548 100644
--- a/Documentation/sound/alsa/emu10k1-jack.txt
+++ b/Documentation/sound/alsa/emu10k1-jack.txt
@@ -1,6 +1,6 @@
 This document is a guide to using the emu10k1 based devices with JACK for low
 latency, multichannel recording functionality.  All of my recent work to allow
-Linux users to use the full capabilities of their hardware has been inspired 
+Linux users to use the full capabilities of their hardware has been inspired
 by the kX Project.  Without their work I never would have discovered the true
 power of this hardware.
 
@@ -36,7 +36,7 @@ The 16 input ports are connected to the 16 physical inputs.  Contrary to
 popular belief, all emu10k1 cards are multichannel cards.  Which of these
 input channels have physical inputs connected to them depends on the card
 model.  Trial and error is highly recommended; the pinout diagrams
-for the card have been reverse engineered by some enterprising kX users and are 
+for the card have been reverse engineered by some enterprising kX users and are
 available on the internet.  Meterbridge is helpful here, and the kX forums are
 packed with useful information.
 
@@ -55,7 +55,7 @@ JACK		Epilog		FXBUS2(nr)
 --------------------------------------------
 capture_1	asio14		FXBUS2(0xe)
 capture_2	asio15		FXBUS2(0xf)
-capture_3	asio0		FXBUS2(0x0)	
+capture_3	asio0		FXBUS2(0x0)
 ~capture_4	Center		EXTOUT(0x11)	// mapped to by Center
 ~capture_5	LFE		EXTOUT(0x12)	// mapped to by LFE
 capture_6	asio3		FXBUS2(0x3)
-- 
1.7.1.251.gf80a2

