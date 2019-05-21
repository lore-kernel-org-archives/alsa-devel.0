From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42xx8: add reset-gpios in binding
	document" to the asoc tree
Date: Tue, 21 May 2019 21:32:41 +0100 (BST)
Message-ID: <20190521203241.F0EF91126D1C@debutante.sirena.org.uk>
References: <3e15abaee348468a69005e4240346822320c7f69.1558006714.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61DF1F8972C
 for <alsa-devel@alsa-project.org>; Tue, 21 May 2019 22:32:51 +0200 (CEST)
In-Reply-To: <3e15abaee348468a69005e4240346822320c7f69.1558006714.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>, tiwai@suse.com, linux-kernel@vger.kernel.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42xx8: add reset-gpios in binding document

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 90fdbe8ab27047f7b9da57d1975c14a8d8f39370 Mon Sep 17 00:00:00 2001
From: "S.j. Wang" <shengjiu.wang@nxp.com>
Date: Thu, 16 May 2019 11:40:56 +0000
Subject: [PATCH] ASoC: cs42xx8: add reset-gpios in binding document

Add reset-gpios property, which is optional.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/cs42xx8.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42xx8.txt b/Documentation/devicetree/bindings/sound/cs42xx8.txt
index 8619a156d038..bbfe39347c20 100644
--- a/Documentation/devicetree/bindings/sound/cs42xx8.txt
+++ b/Documentation/devicetree/bindings/sound/cs42xx8.txt
@@ -14,6 +14,11 @@ Required properties:
   - VA-supply, VD-supply, VLS-supply, VLC-supply: power supplies for the device,
     as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
+Optional properties:
+
+  - reset-gpios : a GPIO spec to define which pin is connected to the chip's
+    !RESET pin
+
 Example:
 
 cs42888: codec@48 {
@@ -25,4 +30,5 @@ cs42888: codec@48 {
 	VD-supply = <&reg_audio>;
 	VLS-supply = <&reg_audio>;
 	VLC-supply = <&reg_audio>;
+	reset-gpios = <&pca9557_b 1 GPIO_ACTIVE_LOW>;
 };
-- 
2.20.1
