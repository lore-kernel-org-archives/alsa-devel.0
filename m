From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 10/10] ARM: dts: sun8i: sinlinx: Enable audio nodes
Date: Tue, 17 Jan 2017 15:02:30 +0100
Message-ID: <20170117140230.23142-11-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com, mylene.josserand@free-electrons.com, alexandre.belloni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

Enable the audio codec and the audio dai for the sun8i A33 sinlinx board.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 370ee82882de..b08811007f44 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -63,6 +63,14 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
+&dai {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.11.0
