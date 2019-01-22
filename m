From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/6] ASoC: mediatek: mt8183: add audio afe document
Date: Tue, 22 Jan 2019 14:39:09 +0800
Message-ID: <1548139153-18783-3-git-send-email-shunli.wang@mediatek.com>
References: <1548139153-18783-1-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1548139153-18783-1-git-send-email-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
