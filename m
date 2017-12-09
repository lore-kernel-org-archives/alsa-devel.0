From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V3 2/2] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Sat,  9 Dec 2017 12:26:35 +0100
Message-ID: <1512818795-1441-3-git-send-email-stefan.wahren@i2se.com>
References: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B41426707F
 for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2017 12:27:46 +0100 (CET)
In-Reply-To: <1512818795-1441-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@martin.sperl.org, Matthias Reichl <hias@horus.com>, phil@raspberrypi.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
the bcm2835-i2s requires a clock as DT property. Unfortunately
the necessary DT change has never been applied. While we are at it
also fix the first PCM register range to cover the PCM_GRAY register.

Fixes: 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Tested-by: Matthias Reichl <hias@horus.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 013431e..e08203c 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -396,8 +396,8 @@
 
 		i2s: i2s@7e203000 {
 			compatible = "brcm,bcm2835-i2s";
-			reg = <0x7e203000 0x20>,
-			      <0x7e101098 0x02>;
+			reg = <0x7e203000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 			dmas = <&dma 2>,
 			       <&dma 3>;
-- 
2.7.4
