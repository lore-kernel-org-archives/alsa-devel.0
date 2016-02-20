From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Make max9867_i2c_id NULL
	terminated" to the asoc tree
Date: Sun, 21 Feb 2016 03:10:25 +0900
Message-ID: <E1aXBz7-0001jv-6b@finisterre>
References: <1455936795.19371.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BDD62606D3
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:10:34 +0100 (CET)
In-Reply-To: <1455936795.19371.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, anish kumar <yesanishhere@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Make max9867_i2c_id NULL terminated

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

>From 1b36e4a2ab0cfcc322153337d2615bc6fa922567 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 20 Feb 2016 10:53:15 +0800
Subject: [PATCH] ASoC: max9867: Make max9867_i2c_id NULL terminated

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: anish kumar <yesanishhere@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 5a8481b..70b5406 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -512,6 +512,7 @@ static int max9867_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id max9867_i2c_id[] = {
 	{ "max9867", 0 },
+	{ }
 };
 
 static const struct of_device_id max9867_of_match[] = {
-- 
2.7.0
