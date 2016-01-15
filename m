From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: document DT compatible string "fsl,
	imx-audio-wm8960"" to the asoc tree
Date: Fri, 15 Jan 2016 18:18:51 +0000
Message-ID: <E1aK8xX-0005Ov-Nd@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 986F42604EF
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 19:19:03 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <lixiubo@cmss.chinamobile.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: document DT compatible string "fsl,imx-audio-wm8960"

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2935bf43ef12a8d68b96776ec11155cfa120cb0d Mon Sep 17 00:00:00 2001
From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Date: Fri, 15 Jan 2016 13:33:08 +0800
Subject: [PATCH] ASoC: fsl: document DT compatible string
 "fsl,imx-audio-wm8960"

The devicetree compatible string "fsl,imx-audio-wm8960" for
fsl-asoc-card is missing.

Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index ce55c0a6f757..4da41bf1888e 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -30,6 +30,8 @@ The compatible list for this generic sound card currently:
  "fsl,imx-audio-sgtl5000"
  (compatible with Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt)
 
+ "fsl,imx-audio-wm8960"
+
 Required properties:
 
   - compatible		: Contains one of entries in the compatible list.
-- 
2.7.0.rc3
