From: Shunli Wang <shunli.wang@mediatek.com>
Subject: [RESEND PATCH 2/6] ASoC: mediatek: mt8183: add audio
	afe document
Date: Sat, 26 Jan 2019 15:44:56 +0800
Message-ID: <1548488700-47792-3-git-send-email-shunli.wang@mediatek.com>
References: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FE7C267441
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 08:46:23 +0100 (CET)
In-Reply-To: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, shunli.wang@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
---
 .../devicetree/bindings/sound/mt8183-afe-pcm.txt   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
new file mode 100644
index 0000000..396ba38
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
@@ -0,0 +1,36 @@
+Mediatek AFE PCM controller for mt8183
+
+Required properties:
+- compatible = "mediatek,mt68183-audio";
+- reg: register location and size
+- interrupts: should contain AFE interrupt
+- power-domains: should define the power domain
+- clocks: Must contain an entry for each entry in clock-names
+- clock-names: should have these clock names:
+		"infra_sys_audio_clk",
+		"mtkaif_26m_clk",
+		"top_mux_audio",
+		"top_mux_aud_intbus",
+		"top_sys_pll3_d4",
+		"top_clk26m_clk";
+
+Example:
+
+	afe: mt8183-afe-pcm@11220000  {
+		compatible = "mediatek,mt8183-audio";
+		reg = <0 0x11220000 0 0x1000>;
+		interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT8183_POWER_DOMAIN_AUDIO>;
+		clocks = <&infrasys CLK_INFRA_AUDIO>,
+			 <&infrasys CLK_INFRA_AUDIO_26M_BCLK>,
+			 <&topckgen CLK_TOP_MUX_AUDIO>,
+			 <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
+			 <&topckgen CLK_TOP_SYSPLL_D2_D4>,
+			 <&clk26m>;
+		clock-names = "infra_sys_audio_clk",
+			      "mtkaif_26m_clk",
+			      "top_mux_audio",
+			      "top_mux_aud_intbus",
+			      "top_sys_pll_d2_d4",
+			      "top_clk26m_clk";
+	};
-- 
1.9.1
