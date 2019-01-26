From: Shunli Wang <shunli.wang@mediatek.com>
Subject: [RESEND PATCH 6/6] ASoC: mediatek: add document for
	mt8183-mt6358
Date: Sat, 26 Jan 2019 15:45:00 +0800
Message-ID: <1548488700-47792-7-git-send-email-shunli.wang@mediatek.com>
References: <1548488700-47792-1-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 050A32673E2
 for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2019 08:47:33 +0100 (CET)
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
 Documentation/devicetree/bindings/sound/mt8183-mt6358.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-mt6358.txt

diff --git a/Documentation/devicetree/bindings/sound/mt8183-mt6358.txt b/Documentation/devicetree/bindings/sound/mt8183-mt6358.txt
new file mode 100644
index 0000000..75b19f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8183-mt6358.txt
@@ -0,0 +1,12 @@
+MT8183 with MT6358 CODEC
+
+Required properties:
+- compatible: "mediatek,mt8183-mt6358-sound"
+- mediatek,platform: the phandle of MT8183 ASoC platform
+
+Example:
+
+	sound {
+		compatible = "mediatek,mt8183-mt6358-sound";
+		mediatek,platform = <&afe>;
+	};
-- 
1.9.1
