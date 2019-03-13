From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 2/5] arm64: dts: renesas: r8a7796: add extended audio dmac register
Date: Wed, 13 Mar 2019 14:57:17 +0900
Message-ID: <20190313055720.26082-3-jiada_wang@mentor.com>
References: <20190313055720.26082-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313055720.26082-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

Basic audio dmac register only supports busif from 0 to 3,
in order to use busif4 ~ busif7, extended audio dmac register
need to be used

This patch adds extended audio dmac register with name "extaudmapp".

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index cdf784899cf8..761305199f17 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -1775,8 +1775,9 @@
 				<0 0xec5a0000 0 0x100>,  /* ADG */
 				<0 0xec540000 0 0x1000>, /* SSIU */
 				<0 0xec541000 0 0x280>,  /* SSI */
-				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
-			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+				<0 0xec740000 0 0x200>,  /* Audio DMAC peri peri*/
+				<0 0xec760000 0 0x200>;  /* Extended Audio DMAC peri peri*/
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp", "extaudmapp";
 
 			clocks = <&cpg CPG_MOD 1005>,
 				 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-- 
2.19.2
