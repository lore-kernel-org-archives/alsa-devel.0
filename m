From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 22/30] ALSA: doc: ReSTize emu10k1-jack.txt
Date: Thu, 10 Nov 2016 22:06:33 +0100
Message-ID: <20161110210641.5907-23-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DF1502673D3
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E7484ADFC
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Another simple conversion from a plain text file.
Put to cards directory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../emu10k1-jack.txt => cards/emu10k1-jack.rst}      | 20 ++++++++++++--------
 Documentation/sound/cards/index.rst                  |  2 +-
 2 files changed, 13 insertions(+), 9 deletions(-)
 rename Documentation/sound/{alsa/emu10k1-jack.txt => cards/emu10k1-jack.rst} (89%)

diff --git a/Documentation/sound/alsa/emu10k1-jack.txt b/Documentation/sound/cards/emu10k1-jack.rst
similarity index 89%
rename from Documentation/sound/alsa/emu10k1-jack.txt
rename to Documentation/sound/cards/emu10k1-jack.rst
index 751d45036a05..6597f1ea83f0 100644
--- a/Documentation/sound/alsa/emu10k1-jack.txt
+++ b/Documentation/sound/cards/emu10k1-jack.rst
@@ -1,3 +1,7 @@
+=================================================================
+Low latency, multichannel audio with JACK and the emu10k1/emu10k2
+=================================================================
+
 This document is a guide to using the emu10k1 based devices with JACK for low
 latency, multichannel recording functionality.  All of my recent work to allow
 Linux users to use the full capabilities of their hardware has been inspired 
@@ -7,8 +11,6 @@ power of this hardware.
 	http://www.kxproject.com
 						- Lee Revell, 2005.03.30
 
-Low latency, multichannel audio with JACK and the emu10k1/emu10k2
------------------------------------------------------------------
 
 Until recently, emu10k1 users on Linux did not have access to the same low
 latency, multichannel features offered by the "kX ASIO" feature of their
@@ -23,14 +25,15 @@ select the correct device for JACK to use.  Actually, for qjackctl users it's
 fairly self explanatory - select Duplex, then for capture and playback select
 the multichannel devices, set the in and out channels to 16, and the sample
 rate to 48000Hz.  The command line looks like this:
+::
 
-/usr/local/bin/jackd -R -dalsa -r48000 -p64 -n2 -D -Chw:0,2 -Phw:0,3 -S
+  /usr/local/bin/jackd -R -dalsa -r48000 -p64 -n2 -D -Chw:0,2 -Phw:0,3 -S
 
 This will give you 16 input ports and 16 output ports.
 
 The 16 output ports map onto the 16 FX buses (or the first 16 of 64, for the
 Audigy).  The mapping from FX bus to physical output is described in
-SB-Live-mixer.txt (or Audigy-mixer.txt).
+sb-live-mixer.rst (or audigy-mixer.rst).
 
 The 16 input ports are connected to the 16 physical inputs.  Contrary to
 popular belief, all emu10k1 cards are multichannel cards.  Which of these
@@ -49,10 +52,11 @@ This chart, borrowed from kxfxlib/da_asio51.cpp, describes the mapping of JACK
 ports to FXBUS2 (multitrack recording input) and EXTOUT (physical output)
 channels.
 
-/*JACK (& ASIO) mappings on 10k1 5.1 SBLive cards:
---------------------------------------------
+JACK (& ASIO) mappings on 10k1 5.1 SBLive cards:
+
+==============  ========        ============
 JACK		Epilog		FXBUS2(nr)
---------------------------------------------
+==============  ========        ============
 capture_1	asio14		FXBUS2(0xe)
 capture_2	asio15		FXBUS2(0xf)
 capture_3	asio0		FXBUS2(0x0)	
@@ -69,6 +73,6 @@ capture_13	asio10		FXBUS2(0xa)
 capture_14	asio11		FXBUS2(0xb)
 capture_15	asio12		FXBUS2(0xc)
 capture_16	asio13		FXBUS2(0xd)
-*/
+==============  ========        ============
 
 TODO: describe use of ld10k1/qlo10k1 in conjunction with JACK
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index c9d7ce4286b2..251f1d7675f7 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -8,4 +8,4 @@ Card-Specific Information
    cmipci
    sb-live-mixer
    audigy-mixer
-  
+   emu10k1-jack
-- 
2.10.2
