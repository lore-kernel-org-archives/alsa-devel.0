From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: constify dev_pm_ops structures."
	to the asoc tree
Date: Fri, 30 Jun 2017 12:59:10 +0100
Message-ID: <E1dQuZq-00080J-Im@finisterre>
References: <6de23d3755cd8c312f213173338e26de6c319f6d.1498712868.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F0EB26752D
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:25 +0200 (CEST)
In-Reply-To: <6de23d3755cd8c312f213173338e26de6c319f6d.1498712868.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, hiroyuki.yokoyama.vx@renesas.com, baoyou.xie@linaro.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: constify dev_pm_ops structures.

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

>From 49ebf13b0453d8535cd53abb514e1683a1875208 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Thu, 29 Jun 2017 10:40:50 +0530
Subject: [PATCH] ASoC: rsnd: constify dev_pm_ops structures.

dev_pm_ops are not supposed to change at runtime. All functions
working with dev_pm_ops provided by <linux/device.h> work with const
dev_pm_ops. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   8172	    920	      0	   9092	   2384	sound/soc/sh/rcar/core.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   8364	    728	      0	   9092	   2384	sound/soc/sh/rcar/core.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 409bac331d27..3f2ced26ed37 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1534,7 +1534,7 @@ static int rsnd_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops rsnd_pm_ops = {
+static const struct dev_pm_ops rsnd_pm_ops = {
 	.suspend		= rsnd_suspend,
 	.resume			= rsnd_resume,
 };
-- 
2.13.2
