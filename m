From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH 2/2] ARM: dts: sun8i: Add ADC routing
Date: Wed, 13 Dec 2017 13:34:08 +0100
Message-ID: <20171213123408.10422-3-mylene.josserand@free-electrons.com>
References: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: mylene.josserand@free-electrons.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

Add the ADC route between the analog and the digital parts
of sun8i A33. Configure the MIC1 to use MBIAS and MIC2 to use HBIAS.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 22660919bd08..1841eecd5993 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -191,7 +191,15 @@
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
 			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right";
+			"Right DAC", "AIF1 Slot 0 Right",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Mic",  "MBIAS",
+			"Headset Mic", "HBIAS",
+			"MIC1", "Mic",
+			"MIC2", "Headset Mic";
 		status = "disabled";
 
 		simple-audio-card,cpu {
-- 
2.11.0
