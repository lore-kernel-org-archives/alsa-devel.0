From: Marc Dietrich <marvin24@gmx.de>
Subject: [PATCH 2/2] ARM: dt: documentation: tegra+alc5632:
	don't use MICBIAS1 in external dapm linkage
Date: Sat,  7 Jul 2012 15:36:30 +0200
Message-ID: <465bb7e7592b1f2b6dbd02ca0cc97427688fe4ad.1341668123.git.marvin24@gmx.de>
References: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by alsa0.perex.cz (Postfix) with SMTP id D9DFD24341
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jul 2012 15:37:01 +0200 (CEST)
In-Reply-To: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
In-Reply-To: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
References: <b561a188ff2521d81b282edd45ded4b2c7133468.1341668123.git.marvin24@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Marc Dietrich <marvin24@gmx.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Leon Romanovsky <leon@leon.nu>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

Remove MICBIAS1 from the user configurable widgets because it is only used
internally.

Cc: Leon Romanovsky <leon@leon.nu>
Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 .../bindings/sound/nvidia,tegra-audio-alc5632.txt  |    2 --
 arch/arm/boot/dts/tegra20-paz00.dts                |    1 -
 2 files changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
index b77a97c..fad1ba1 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
@@ -24,7 +24,6 @@ Required properties:
   * MIC1_N
   * MIC2_P
   * MIC2_N
-  * MICBIAS1
   * DMICDAT
 
   Board connectors:
@@ -48,7 +47,6 @@ sound {
 	nvidia,audio-routing =
 				"Int Spk", "SPK_OUTP",
 				"Int Spk", "SPK_OUTN",
-				"Headset Mic","MICBIAS1",
 				"MIC1_N", "Headset Mic",
 				"MIC1_P", "Headset Mic",
 				"Headset Stereophone", "HP_OUT_R",
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index abeb7fb..580906a 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -481,7 +481,6 @@
 		nvidia,audio-routing =
 			"Int Spk", "SPKOUT",
 			"Int Spk", "SPKOUTN",
-			"Headset Mic", "MICBIAS1",
 			"MIC1", "Headset Mic",
 			"Headset Stereophone", "HPR",
 			"Headset Stereophone", "HPL",
-- 
1.7.9.5
