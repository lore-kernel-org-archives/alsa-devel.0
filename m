From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt6358: add codec document"
	to the asoc tree
Date: Fri, 25 Jan 2019 18:11:09 +0000 (GMT)
Message-ID: <20190125181109.790E61126FC0@debutante.sirena.org.uk>
References: <1548139153-18783-5-git-send-email-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 56F0D26680F
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 19:11:10 +0100 (CET)
In-Reply-To: <1548139153-18783-5-git-send-email-shunli.wang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, shunli.wang@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt6358: add codec document

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

>From 7ca80f232e810b758ba72daef8f189c34a20bd32 Mon Sep 17 00:00:00 2001
From: Shunli Wang <shunli.wang@mediatek.com>
Date: Tue, 22 Jan 2019 14:39:11 +0800
Subject: [PATCH] ASoC: mediatek: mt6358: add codec document

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/mt6358.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt

diff --git a/Documentation/devicetree/bindings/sound/mt6358.txt b/Documentation/devicetree/bindings/sound/mt6358.txt
new file mode 100644
index 000000000000..5465730013a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt6358.txt
@@ -0,0 +1,18 @@
+Mediatek MT6358 Audio Codec
+
+The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
+For more detail, please visit Mediatek PMIC wrapper documentation.
+
+Must be a child node of PMIC wrapper.
+
+Required properties:
+
+- compatible : "mediatek,mt6358-sound".
+- Avdd-supply : power source of AVDD
+
+Example:
+
+mt6358_snd {
+	compatible = "mediatek,mt6358-sound";
+	Avdd-supply = <&mt6358_vaud28_reg>;
+};
-- 
2.20.1
