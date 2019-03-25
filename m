From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sirf-audio: Remove redundant
	of_match_node call" to the asoc tree
Date: Mon, 25 Mar 2019 12:22:04 +0000 (GMT)
Message-ID: <20190325122204.AEE4411288F1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33AE6F801D9
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 13:22:09 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Aditya Pakki <pakki001@umn.edu>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sirf-audio: Remove redundant of_match_node call

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

>From 78540a259b050480d20354efaf1055c233728b3b Mon Sep 17 00:00:00 2001
From: Aditya Pakki <pakki001@umn.edu>
Date: Fri, 22 Mar 2019 17:00:29 -0500
Subject: [PATCH] ASoC: sirf-audio: Remove redundant of_match_node call

Unlike other drivers probe method, of_match_node return value
is not used or checked. This patch removes the redundant code.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sirf-audio-codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index e424499a8450..e0af21050078 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -461,9 +461,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 	struct sirf_audio_codec *sirf_audio_codec;
 	void __iomem *base;
 	struct resource *mem_res;
-	const struct of_device_id *match;
-
-	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
 
 	sirf_audio_codec = devm_kzalloc(&pdev->dev,
 		sizeof(struct sirf_audio_codec), GFP_KERNEL);
-- 
2.20.1
