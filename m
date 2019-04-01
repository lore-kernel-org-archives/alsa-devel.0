From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Mediatek: Add document for mt8183-da7219-max98357" to
 the asoc tree
Date: Mon,  1 Apr 2019 09:53:01 +0100 (BST)
Message-ID: <20190401085301.698AF440082@finisterre.ee.mobilebroadband>
References: <1553848489-27926-5-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1553848489-27926-5-git-send-email-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Mediatek: Add document for mt8183-da7219-max98357

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5a79acf9a9188d85e1f1a697ed7531e0f0f36943 Mon Sep 17 00:00:00 2001
From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Fri, 29 Mar 2019 16:34:49 +0800
Subject: [PATCH] ASoC: Mediatek: Add document for mt8183-da7219-max98357

This patch adds document for the machine board with
mt6358, da7219 and max98357 codecs.

Signed-off-by: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../bindings/sound/mt8183-da7219-max98357.txt     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-da7219-max98357.txt

diff --git a/Documentation/devicetree/bindings/sound/mt8183-da7219-max98357.txt b/Documentation/devicetree/bindings/sound/mt8183-da7219-max98357.txt
new file mode 100644
index 000000000000..92ac86f83822
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt8183-da7219-max98357.txt
@@ -0,0 +1,15 @@
+MT8183 with MT6358, DA7219 and MAX98357 CODECS
+
+Required properties:
+- compatible : "mediatek,mt8183_da7219_max98357"
+- mediatek,headset-codec: the phandles of da7219 codecs
+- mediatek,platform: the phandle of MT8183 ASoC platform
+
+Example:
+
+	sound {
+		compatible = "mediatek,mt8183_da7219_max98357";
+		mediatek,headset-codec = <&da7219>;
+		mediatek,platform = <&afe>;
+	};
+
-- 
2.20.1
