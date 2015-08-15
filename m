From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: instantiate AC'97 CODEC" to
	the asoc tree
Date: Fri, 14 Aug 2015 19:13:28 -0700
Message-ID: <E1ZQQyO-0004Jk-6x@finisterre>
References: <558FFB35.8000105@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CEF7F2665E0
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:13:35 +0200 (CEST)
In-Reply-To: <558FFB35.8000105@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maciej Szmigiero <mail@maciej.szmigiero.name>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: instantiate AC'97 CODEC

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

>From 8ed0c842153434fa3aeeb89d16b71ac7dc8e12ee Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Wed, 5 Aug 2015 17:26:44 +0200
Subject: [PATCH] ASoC: fsl_ssi: instantiate AC'97 CODEC

Instantiate AC'97 CODEC in fsl_ssi driver AC'97 mode.

Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0b4fcd9..e79dc16 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1460,6 +1460,27 @@ done:
 		_fsl_ssi_set_dai_fmt(&pdev->dev, ssi_private,
 				     ssi_private->dai_fmt);
 
+	if (fsl_ssi_is_ac97(ssi_private)) {
+		u32 ssi_idx;
+
+		ret = of_property_read_u32(np, "cell-index", &ssi_idx);
+		if (ret) {
+			dev_err(&pdev->dev, "cannot get SSI index property\n");
+			goto error_sound_card;
+		}
+
+		ssi_private->pdev =
+			platform_device_register_data(NULL,
+					"ac97-codec", ssi_idx, NULL, 0);
+		if (IS_ERR(ssi_private->pdev)) {
+			ret = PTR_ERR(ssi_private->pdev);
+			dev_err(&pdev->dev,
+				"failed to register AC97 codec platform: %d\n",
+				ret);
+			goto error_sound_card;
+		}
+	}
+
 	return 0;
 
 error_sound_card:
-- 
2.5.0
