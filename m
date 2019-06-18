From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: sof_rt5682: use GFP_KERNEL
	instead of GFP_ATOMIC" to the asoc tree
Date: Tue, 18 Jun 2019 19:33:10 +0100 (BST)
Message-ID: <20190618183310.A31A1440049@finisterre.sirena.org.uk>
References: <20190618070426.35405-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41F6BF8075C
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 20:33:11 +0200 (CEST)
In-Reply-To: <20190618070426.35405-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, yung-chuan.liao@linux.intel.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: sof_rt5682: use GFP_KERNEL instead of GFP_ATOMIC

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 281c443f1e8e25ebc46aaebf48c73e0545a0830e Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Tue, 18 Jun 2019 15:04:26 +0800
Subject: [PATCH] ASoC: Intel: sof_rt5682: use GFP_KERNEL instead of GFP_ATOMIC

Change the memory allocation flag from GFP_ATOMIC to GFP_KERNEL because
probe of platform device is unlikely a place where cannot sleep.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 3343dbcd506f..90d262ebeb10 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -494,7 +494,7 @@ static int sof_audio_probe(struct platform_device *pdev)
 	int dmic_num, hdmi_num;
 	int ret, ssp_amp, ssp_codec;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
2.20.1
