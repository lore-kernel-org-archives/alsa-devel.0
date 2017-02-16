From: Garlic Tseng <garlic.tseng@mediatek.com>
Subject: [PATCH 2/2] ASoC: mediatek: add power-domains for
	mt2701-afe-pcm.txt
Date: Thu, 16 Feb 2017 13:27:16 +0800
Message-ID: <1487222836-21174-3-git-send-email-garlic.tseng@mediatek.com>
References: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 782572666EA
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 06:27:24 +0100 (CET)
In-Reply-To: <1487222836-21174-1-git-send-email-garlic.tseng@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ir.lian@mediatek.com, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This add power-domains for mt2701-afe-pcm

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
index 3e623a7..9800a56 100644
--- a/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
+++ b/Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible = "mediatek,mt2701-audio";
 - reg: register location and size
 - interrupts: Should contain AFE interrupt
+- power-domains: should define the power domain
 - clock-names: should have these clock names:
 		"infra_sys_audio_clk",
 		"top_audio_mux1_sel",
@@ -58,6 +59,7 @@ Example:
 		      <0 0x112A0000 0 0x20000>;
 		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 132 IRQ_TYPE_LEVEL_LOW>;
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_IFR_MSC>;
 		clocks = <&infracfg CLK_INFRA_AUDIO>,
 			 <&topckgen CLK_TOP_AUD_MUX1_SEL>,
 			 <&topckgen CLK_TOP_AUD_MUX2_SEL>,
-- 
1.9.1
