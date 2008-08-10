From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] sound/pci/Kconfig: update for ice1712/24
Date: Mon, 11 Aug 2008 02:52:42 +0400
Message-ID: <20080810225242.GE5093@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1901924530
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 00:52:48 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so896717fgg.44
	for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2008 15:52:47 -0700 (PDT)
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
To: perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Alexander Beregalov <a.beregalov@gmail.com>

sound/pci/Kconfig: update for ice1712/24


Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/Kconfig |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index f7d95b2..e14dc54 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -649,8 +649,9 @@ config SND_ICE1712
 
 	  Currently supported hardware is: M-Audio Delta 1010(LT),
 	  DiO 2496, 66, 44, 410, Audiophile 24/96; Digigram VX442;
-	  TerraTec EWX 24/96, EWS 88MT, 88D, DMX 6Fire, Phase 88;
-	  Hoontech SoundTrack DSP 24/Value/Media7.1; Event EZ8.
+	  TerraTec EWX 24/96, EWS 88MT/D, DMX 6Fire, Phase 88;
+	  Hoontech SoundTrack DSP 24/Value/Media7.1; Event EZ8;
+	  Lionstracs Mediastation, Terrasoniq TS 88.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-ice1712.
@@ -665,9 +666,12 @@ config SND_ICE1724
 	  ICE/VT1724/1720 (Envy24HT/PT) chips.
 
 	  Currently supported hardware is: AMP AUDIO2000; M-Audio
-	  Revolution 7.1; TerraTec Aureon 5.1 Sky, 7.1 Space/Universe;
-	  AudioTrak Prodigy 7.1; Pontis MS300; Albatron K8X800 Pro II;
-	  Chaintech ZNF3-150/250.
+	  Revolution 5.1, 7.1, Audiophile 192; TerraTec Aureon 5.1 Sky,
+	  7.1 Space/Universe, Phase 22/28; Onkyo SE-90PCI, SE-200PCI;
+	  AudioTrak Prodigy 192, 7.1 (HIFI/LT/XT), HD2; Hercules
+	  Fortissimo IV; ESI Juli@; Pontis MS300; EGO-SYS WaveTerminal
+	  192M; Albatron K8X800 Pro II; Chaintech ZNF3-150/250, 9CJS,
+	  AV-710; Shuttle SN25P.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-ice1724.
