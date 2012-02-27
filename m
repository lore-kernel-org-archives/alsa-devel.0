From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH] ASoC: DT: Update digital microphone binding
	documentation to PAZ00 board.
Date: Mon, 27 Feb 2012 21:18:19 +0200
Message-ID: <1330370299-19329-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FAA2246C2
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 20:18:40 +0100 (CET)
Received: by eaan11 with SMTP id n11so1978413eaa.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 11:18:36 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

This patch updates device tree binding documentation to add digital microphone to PAZ00
board.

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 .../bindings/sound/tegra-audio-alc5632.txt         |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tegra-audio-alc5632.txt b/Documentation/devicetree/bindings/sound/tegra-audio-alc5632.txt
index 300f2da..9e305bb 100644
--- a/Documentation/devicetree/bindings/sound/tegra-audio-alc5632.txt
+++ b/Documentation/devicetree/bindings/sound/tegra-audio-alc5632.txt
@@ -25,12 +25,14 @@ Required properties:
   * MIC2_P
   * MIC2_N
   * MICBIAS1
+  * DMICDAT
 
   Board connectors:
 
   * Headset Stereophone
   * Int Spk
   * Headset Mic
+  * Digital Mic
 
 - nvidia,i2s-controller : The phandle of the Tegra I2S controller
 - nvidia,audio-codec : The phandle of the ALC5632 audio codec
-- 
1.7.3.4
