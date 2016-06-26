From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: fix spelling mistake: "unknwon" -> "unknown"" to the asoc tree
Date: Sun, 26 Jun 2016 13:02:36 +0100
Message-ID: <E1bH8lo-0002Nu-9B@debutante>
References: <1466703478-9034-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466703478-9034-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: fix spelling mistake: "unknwon" -> "unknown"

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

>From 48b418d7fd359fe1d9845507bdbecf151e0a0dd9 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 23 Jun 2016 18:37:58 +0100
Subject: [PATCH] ASoC: samsung: fix spelling mistake: "unknwon" -> "unknown"

trivial fix to spelling mistake in pr_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c-i2s-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index b6ab3fc5789e..bf8ae79b0fd2 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -268,7 +268,7 @@ static int s3c2412_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		iismod &= ~S3C2412_IISMOD_SLAVE;
 		break;
 	default:
-		pr_err("unknwon master/slave format\n");
+		pr_err("unknown master/slave format\n");
 		return -EINVAL;
 	}
 
-- 
2.8.1
