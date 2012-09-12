From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH 4/5] arch/powerpc/boot/dts pcm030 add
	mpc5200-soc-audio node
Date: Tue, 11 Sep 2012 22:14:48 -0400
Message-ID: <1347416089-23393-5-git-send-email-emillbrandt@dekaresearch.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id BCEF82615F6
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 04:15:36 +0200 (CEST)
In-Reply-To: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anatolij Gustschin <agust@denx.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Describe the audio codec on the pcm030 baseboard.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 arch/powerpc/boot/dts/pcm030.dts |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 9e35499..e9475e9 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -59,7 +59,7 @@
 			#gpio-cells = <2>;
 		};
 
-		psc@2000 { /* PSC1 in ac97 mode */
+		audio_platform: psc@2000 { /* PSC1 in ac97 mode */
 			compatible = "mpc5200b-psc-ac97","fsl,mpc5200b-psc-ac97";
 			cell-index = <0>;
 		};
@@ -134,4 +134,25 @@
 	localbus {
 		status = "disabled";
 	};
+
+	sound {
+		compatible = "fsl,mpc5200b-soc-audio","fsl,mpc5200-soc-audio";
+		card-name = "pcm030";
+		audio-platform = <&audio_platform>;
+		number-of-dais = <2>;
+
+		analog@0 {
+			stream-name = "AC97 Analog";
+			codec-name = "wm9712-codec.0";
+			codec-dai-name = "wm9712-hifi";
+			cpu-dai-name = "mpc5200-psc-ac97.0";
+		};
+
+		digital@1 {
+			stream-name = "AC97 IEC958";
+			codec-name = "wm9712-codec.0";
+			codec-dai-name = "wm9712-aux";
+			cpu-dai-name = "mpc5200-psc-ac97.0";
+		};
+	};
 };
-- 
1.7.2.5
