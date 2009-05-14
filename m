From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V1 13/13] Support for AC97 on Phytec pmc030
	base board.
Date: Wed, 13 May 2009 21:59:26 -0400
Message-ID: <20090514015926.28145.93104.stgit@terra>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 83B3D24388
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:59:36 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so720053ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:59:36 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Support for AC97 on Phytec pmc030 base board. This uses the generic fabric driver binding.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 arch/powerpc/boot/dts/pcm030.dts |    8 ++++++++
 sound/soc/fsl/Kconfig            |    7 +++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 8958347..001c8ef 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -190,6 +190,14 @@
 			cell-index = <0>;
 			reg = <0x2000 0x100>;
 			interrupts = <2 1 0>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			codec@0 {
+				compatible = "wlf,wm9712";
+				reg = <0x0>;
+			};
 		};
 
 		/* PSC2 port is used by CAN1/2 */
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 266c6b7..11735e4 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -48,4 +48,11 @@ config SND_MPC52xx_SOC_EFIKA
 	help
 	  Say Y if you want to add support for sound on the Efika.
 
+config SND_MPC52xx_SOC_PCM030
+	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
+	depends on PPC_MPC5200_SIMPLE
+	select SND_SOC_MPC5200_AC97
+	select SND_SOC_WM9712
+	help
+	  Say Y if you want to add support for sound on the Phytec pcm030 baseboard.
