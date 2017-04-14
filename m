From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Mark rt5514_i2c_driver as
	static" to the asoc tree
Date: Fri, 14 Apr 2017 18:12:01 +0100
Message-ID: <E1cz4lN-0005aL-Ij@debutante>
References: <20170414164033.11681-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E7B92671F3
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 19:12:13 +0200 (CEST)
In-Reply-To: <20170414164033.11681-1-dianders@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Douglas Anderson <dianders@chromium.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Mark rt5514_i2c_driver as static

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

>From d0c02e14e48be94dd312ff6edffab9f9e6acd480 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Fri, 14 Apr 2017 09:40:30 -0700
Subject: [PATCH] ASoC: rt5514: Mark rt5514_i2c_driver as static

There's no reason for rt5514_i2c_driver to be non-static.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index b281a46d769d..481e77763fe4 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1149,7 +1149,7 @@ static int rt5514_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-struct i2c_driver rt5514_i2c_driver = {
+static struct i2c_driver rt5514_i2c_driver = {
 	.driver = {
 		.name = "rt5514",
 		.of_match_table = of_match_ptr(rt5514_of_match),
-- 
2.11.0
