From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH v4 5/5] ASoC: mediatek: add documents for mt6797
Date: Wed, 25 Apr 2018 15:25:22 +0800
Message-ID: <20180425072522.14167-6-kaichieh.chuang@mediatek.com>
References: <20180425072522.14167-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 471BF267035
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 09:30:11 +0200 (CEST)
In-Reply-To: <20180425072522.14167-1-kaichieh.chuang@mediatek.com>
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
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 .../devicetree/bindings/sound/mt6797-afe-pcm.txt   | 42 ++++++++++++++++++++++
 .../devicetree/bindings/sound/mt6797-mt6351.txt    | 14 ++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt6797-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt6797-mt6351.txt

diff --git a/Documentation/devicetree/bindings/sound/mt6797-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt6797-afe-pcm.txt
new file mode 100644
index 000000000000..0ae29de15bfd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt6797-afe-pcm.txt
@@ -0,0 +1,42 @@
+Mediatek AFE PCM controller for mt6797
+
+Required properties:
+- compatible = "mediatek,mt6797-audio";
+- reg: register location and size
+- interrupts: should contain AFE interrupt
+- power-domains: should define the power domain
+- clocks: Must contain an entry for each entry in clock-names
+- clock-names: should have these clock names:
+		"infra_sys_audio_clk",
+		"infra_sys_audio_26m",
+		"mtkaif_26m_clk",
+		"top_mux_audio",
+		"top_mux_aud_intbus",
+		"top_sys_pll3_d4",
+		"top_sys_pll1_d4",
+		"top_clk26m_clk";
+
+Example:
+
+	afe: mt6797-afe-pcm@11220000  {
+		compatible = "mediatek,mt6797-audio";
+		reg = <0 0x11220000 0 0x1000>;
+		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT6797_POWER_DOMAIN_AUDIO>;
+		clocks = <&infrasys CLK_INFRA_AUDIO>,
+			 <&infrasys CLK_INFRA_AUDIO_26M>,
+			 <&infrasys CLK_INFRA_AUDIO_26M_PAD_TOP>,
+			 <&topckgen CLK_TOP_MUX_AUDIO>,
+			 <&topckgen CLK_TOP_MUX_AUD_INTBUS>,
+			 <&topckgen CLK_TOP_SYSPLL3_D4>,
+			 <&topckgen CLK_TOP_SYSPLL1_D4>,
+			 <&clk26m>;
+		clock-names = "infra_sys_audio_clk",
+			      "infra_sys_audio_26m",
+			      "mtkaif_26m_clk",
+			      "top_mux_audio",
+			      "top_mux_aud_intbus",
+			      "top_sys_pll3_d4",
+			      "top_sys_pll1_d4",
+			      "top_clk26m_clk";
+	};
diff --git a/Documentation/devicetree/bindings/sound/mt6797-mt6351.txt b/Documentation/devicetree/bindings/sound/mt6797-mt6351.txt
new file mode 100644
index 000000000000..1d95a8840f19
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt6797-mt6351.txt
@@ -0,0 +1,14 @@
+MT6797 with MT6351 CODEC
+
+Required properties:
+- compatible: "mediatek,mt6797-mt6351-sound"
+- mediatek,platform: the phandle of MT6797 ASoC platform
+- mediatek,audio-codec: the phandles of MT6351 codec
+
+Example:
+
+	sound {
+		compatible = "mediatek,mt6797-mt6351-sound";
+		mediatek,audio-codec = <&mt6351_snd>;
+		mediatek,platform = <&afe>;
+	};
-- 
2.12.5
