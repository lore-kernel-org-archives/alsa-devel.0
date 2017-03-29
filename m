From: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] ASoC: mediatek: add bindings for wm8960 codec
Date: Wed, 29 Mar 2017 16:59:32 +0800
Message-ID: <1490777972-41841-3-git-send-email-ryder.lee@mediatek.com>
References: <1490777972-41841-1-git-send-email-ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1490777972-41841-1-git-send-email-ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

add device tree bindings for mt2701-wm8960.

Signed-off-by: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/sound/mt2701-wm8960.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.txt

diff --git a/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt b/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
new file mode 100644
index 0000000..809b609
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
@@ -0,0 +1,24 @@
+MT2701 with WM8960 CODEC
+
+Required properties:
+- compatible: "mediatek,mt2701-wm8960-machine"
+- mediatek,platform: the phandle of MT2701 ASoC platform
+- audio-routing: a list of the connections between audio
+- mediatek,audio-codec: the phandles of wm8960 codec
+- pinctrl-names: Should contain only one value - "default"
+- pinctrl-0: Should specify pin control groups used for this controller.
+
+Example:
+
+	sound:sound {
+		compatible = "mediatek,mt2701-wm8960-machine";
+		mediatek,platform = <&afe>;
+		audio-routing =
+			"Headphone", "HP_L",
+			"Headphone", "HP_R",
+			"LINPUT1", "AMIC",
+			"RINPUT1", "AMIC";
+		mediatek,audio-codec = <&wm8960>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&aud_pins_default>;
+	};
-- 
1.9.1
