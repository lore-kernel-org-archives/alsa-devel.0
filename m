From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Use of_match_ptr() when
	assigning match table" to the asoc tree
Date: Wed, 07 Oct 2015 12:18:24 +0100
Message-ID: <E1Zjmjo-0006R1-6f@finisterre>
References: <0ba5a5ba6765f9f9d520a604ffd06dcb61a68822.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A8B5C265C96
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 13:18:52 +0200 (CEST)
In-Reply-To: <0ba5a5ba6765f9f9d520a604ffd06dcb61a68822.1444214947.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Use of_match_ptr() when assigning match table

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

>From b7ebd78d1d142e4e47c3547b08faf51218384583 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 7 Oct 2015 11:57:12 +0100
Subject: [PATCH] ASoC: da7219: Use of_match_ptr() when assigning match table

Use of_match_ptr() to handle non-DT kernel scenario where match
table should be NULL.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index c86a833..adcc079 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1932,7 +1932,7 @@ MODULE_DEVICE_TABLE(i2c, da7219_i2c_id);
 static struct i2c_driver da7219_i2c_driver = {
 	.driver = {
 		.name = "da7219",
-		.of_match_table = da7219_of_match,
+		.of_match_table = of_match_ptr(da7219_of_match),
 	},
 	.probe		= da7219_i2c_probe,
 	.remove		= da7219_i2c_remove,
-- 
2.5.0
