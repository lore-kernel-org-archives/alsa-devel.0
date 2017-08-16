From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Null pointer dereference on samsung_i2s_remove" to the asoc tree
Date: Wed, 16 Aug 2017 17:02:09 +0100
Message-ID: <E1di0ll-0003PE-W1@debutante>
References: <1502454942-739-1-git-send-email-vasilyev@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502454942-739-1-git-send-email-vasilyev@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, ldv-project@linuxtesting.org, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Krzysztof Kozlowski <krzk@kernel.org>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Null pointer dereference on samsung_i2s_remove

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

>From 7b814a7d4e83b0917efef9dd11a8c095371f987c Mon Sep 17 00:00:00 2001
From: Anton Vasilyev <vasilyev@ispras.ru>
Date: Tue, 15 Aug 2017 15:19:54 +0300
Subject: [PATCH] ASoC: samsung: i2s: Null pointer dereference on
 samsung_i2s_remove

If (quirks & QUIRK_SEC_DAI == 0) then samsung_i2s_probe() doesn't allocate
sec_dai and pri_dai->sec_dai remains Null, but samsung_i2s_remove()
performs pri_dai->sec_dai dereference in any case.

The patch removes useless reinitialization of sec_dai at
samsung_i2s_remove(), because resources are under devm control.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index daf7b892c967..10a4da06c0a1 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1388,13 +1388,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 
 static int samsung_i2s_remove(struct platform_device *pdev)
 {
-	struct i2s_dai *pri_dai, *sec_dai;
+	struct i2s_dai *pri_dai;
 
 	pri_dai = dev_get_drvdata(&pdev->dev);
-	sec_dai = pri_dai->sec_dai;
-
-	pri_dai->sec_dai = NULL;
-	sec_dai->pri_dai = NULL;
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.13.3
