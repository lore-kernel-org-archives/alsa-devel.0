From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] ALSA: firewire: trivial typo fixes in Kconfig
Date: Sat, 26 Jul 2014 14:05:10 +0200
Message-ID: <20140726140510.20b7764b@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id B2CD5264F34
 for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2014 14:05:12 +0200 (CEST)
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

ESI Quotafire -> QuataFire
TerraTec EWS Mic4 -> Mic8
Firewire -> FireWire

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 sound/firewire/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 775ef2efc296..46dff64908c8 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -83,8 +83,8 @@ config SND_BEBOB
 	  * Edirol FA-66/FA-101
 	  * PreSonus FIREBOX/FIREPOD/FP10/Inspire1394
 	  * BridgeCo RDAudio1/Audio5
-	  * Mackie Onyx 1220/1620/1640 (Firewire I/O Card)
-	  * Mackie d.2 (Firewire Option)
+	  * Mackie Onyx 1220/1620/1640 (FireWire I/O Card)
+	  * Mackie d.2 (FireWire Option)
 	  * Stanton FinalScratch 2 (ScratchAmp)
 	  * Tascam IF-FW/DM
 	  * Behringer XENIX UFX 1204/1604
@@ -92,7 +92,7 @@ config SND_BEBOB
 	  * Apogee Rosetta 200/400 (X-FireWire card)
 	  * Apogee DA/AD/DD-16X (X-FireWire card)
 	  * Apogee Ensemble
-	  * ESI Quotafire610
+	  * ESI QuataFire 610
 	  * AcousticReality eARMasterOne
 	  * CME MatrixKFW
 	  * Phonic Helix Board 12 MkII/18 MkII/24 MkII
@@ -101,13 +101,13 @@ config SND_BEBOB
 	  * ICON FireXon
 	  * PrismSound Orpheus/ADA-8XR
 	  * TerraTec PHASE 24 FW/PHASE X24 FW/PHASE 88 Rack FW
-	  * Terratec EWS MIC2/EWS MIC4
-	  * Terratec Aureon 7.1 Firewire
+	  * TerraTec EWS MIC2/EWS MIC8
+	  * TerraTec Aureon 7.1 FireWire
 	  * Yamaha GO44/GO46
 	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
-	  * M-Audio Firewire410/AudioPhile/Solo
+	  * M-Audio FireWire410/AudioPhile/Solo
 	  * M-Audio Ozonic/NRV10/ProfireLightBridge
-	  * M-Audio Firewire 1814/ProjectMix IO
+	  * M-Audio FireWire 1814/ProjectMix IO
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
-- 
Stefan Richter
-=====-====- -=== ==-=-
http://arcgraph.de/sr/
