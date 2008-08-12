From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ALSA-Configuration.txt: supported cards update
Date: Wed, 13 Aug 2008 00:10:55 +0400
Message-ID: <20080812201055.GA12411@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 895E12448D
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Aug 2008 22:11:04 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1441289fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 12 Aug 2008 13:11:03 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Alexander Beregalov <a.beregalov@gmail.com>

ALSA-Configuration.txt: supported cards update


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 Documentation/sound/alsa/ALSA-Configuration.txt |   28 ++++++++++++++++------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index 6f6d117..59069d7 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -746,8 +746,10 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
   Module snd-hda-intel
   --------------------
 
-    Module for Intel HD Audio (ICH6, ICH6M, ESB2, ICH7, ICH8),
-		ATI SB450, SB600, RS600,
+    Module for Intel HD Audio (ICH6, ICH6M, ESB2, ICH7, ICH8, ICH9, ICH10,
+			PCH, SCH),
+		ATI SB450, SB600, R600, RS600, RS690, RS780, RV610, RV620,
+			RV630, RV635, RV670, RV770,
 		VIA VT8251/VT8237A,
 		SIS966, ULI M5461
 
@@ -1168,6 +1170,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 			* Event Electronics, EZ8
                         * Digigram VX442
 			* Lionstracs, Mediastaton
+			* Terrasoniq TS 88
 
     model       - Use the given board model, one of the following:
 		  delta1010, dio2496, delta66, delta44, audiophile, delta410,
@@ -1202,7 +1205,10 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 			* TerraTec Phase 22
 			* TerraTec Phase 28
 			* AudioTrak Prodigy 7.1
-			* AudioTrak Prodigy 7.1LT
+			* AudioTrak Prodigy 7.1 LT
+			* AudioTrak Prodigy 7.1 XT
+			* AudioTrak Prodigy 7.1 HIFI
+			* AudioTrak Prodigy 7.1 HD2
 			* AudioTrak Prodigy 192
 			* Pontis MS300
 			* Albatron K8X800 Pro II 
@@ -1213,12 +1219,16 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 			* Shuttle SN25P
 			* Onkyo SE-90PCI
 			* Onkyo SE-200PCI
+			* ESI Juli@
+			* Hercules Fortissimo IV
+			* EGO-SYS WaveTerminal 192M
 
     model       - Use the given board model, one of the following:
 		  revo51, revo71, amp2000, prodigy71, prodigy71lt,
-		  prodigy192, aureon51, aureon71, universe, ap192,
-		  k8x800, phase22, phase28, ms300, av710, se200pci,
-		  se90pci
+		  prodigy71xt, prodigy71hifi, prodigyhd2, prodigy192,
+		  juli, aureon51, aureon71, universe, ap192, k8x800,
+		  phase22, phase28, ms300, av710, se200pci, se90pci,
+		  fortissimo4, sn25p, wt192m 
 
     This module supports multiple cards and autoprobe.
 
@@ -1257,7 +1267,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 
     Module for AC'97 motherboards from Intel and compatibles.
 			* Intel i810/810E, i815, i820, i830, i84x, MX440
-				ICH5, ICH6, ICH7, ESB2
+				ICH5, ICH6, ICH7, 6300ESB, ESB2
 			* SiS 7012 (SiS 735)
 			* NVidia NForce, NForce2, NForce3, MCP04, CK804
 				 CK8, CK8S, MCP501
@@ -1297,7 +1307,7 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 				ICH5, ICH6, ICH7
 			* SiS 7013 (SiS 735)
 			* NVidia NForce, NForce2, NForce2s, NForce3
-			* AMD AMD8111
+			* AMD AMD768, AMD8111
 			* ALi m5455
 
     ac97_clock	  - AC'97 codec clock base (0 = auto-detect)
@@ -1955,6 +1965,8 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
 			* CHIC  True Sound 4Dwave
 			* Shark  Predator4D-PCI
 			* Jaton  SonicWave 4D
+			* SiS SI7018 PCI Audio
+			* Hoontech SoundTrack Digital 4DWave NX
 
     pcm_channels   - max channels (voices) reserved for PCM
     wavetable_size - max wavetable size in kB (4-?kb)
