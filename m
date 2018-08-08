From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Fix initialization of
	rt5677_of_match.data" to the asoc tree
Date: Wed,  8 Aug 2018 12:08:03 +0100 (BST)
Message-ID: <20180808110803.1F0861124340@debutante.sirena.org.uk>
References: <20180807171940.150507-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D2DD62678EC
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 13:08:05 +0200 (CEST)
In-Reply-To: <20180807171940.150507-1-mka@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Nicolas Boichat <drinkcat@chromium.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Guenter Roeck <groeck@chromium.org>, Bard Liao <bardliao@realtek.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Fix initialization of rt5677_of_match.data

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

>From f861e3e28a3016a2064d9f600eaa92a530b732b4 Mon Sep 17 00:00:00 2001
From: Matthias Kaehlcke <mka@chromium.org>
Date: Tue, 7 Aug 2018 10:19:40 -0700
Subject: [PATCH] ASoC: rt5677: Fix initialization of rt5677_of_match.data

The driver expects to find the device id in rt5677_of_match.data, however
it is currently assigned to rt5677_of_match.type. Fix this.

The problem was found with the help of clang:
  sound/soc/codecs/rt5677.c:5010:36: warning: expression which evaluates to
  zero treated as a null pointer constant of type 'const void *'
  [-Wnon-literal-null-conversion]
    { .compatible = "realtek,rt5677", RT5677 },
                                      ^~~~~~

Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module sources")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 922becfee59b..9b7a1833d331 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5008,7 +5008,7 @@ static const struct regmap_config rt5677_regmap = {
 };
 
 static const struct of_device_id rt5677_of_match[] = {
-	{ .compatible = "realtek,rt5677", RT5677 },
+	{ .compatible = "realtek,rt5677", .data = (const void *)RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
-- 
2.18.0
