From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel_wm8904: add snd_soc_pm_ops" to
	the asoc tree
Date: Wed, 23 Dec 2015 00:08:54 +0000
Message-ID: <E1aBWz8-0007It-5j@debutante>
References: <1450764402-15669-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76FF9265D9D
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:02 +0100 (CET)
In-Reply-To: <1450764402-15669-1-git-send-email-songjun.wu@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Songjun Wu <songjun.wu@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel_wm8904: add snd_soc_pm_ops

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

>From 50860e1d17d1bc2f1a2ebfc5042f2af786e53ad6 Mon Sep 17 00:00:00 2001
From: Songjun Wu <songjun.wu@atmel.com>
Date: Tue, 22 Dec 2015 14:06:42 +0800
Subject: [PATCH] ASoC: atmel_wm8904: add snd_soc_pm_ops

Sometimes the audio play can not be resumed after it is
suspended. Add snd_soc_pm_ops to execute power management
operations, then this issue is fixed.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_wm8904.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
index 1933bcd46cca..fdd28ed3e0b9 100644
--- a/sound/soc/atmel/atmel_wm8904.c
+++ b/sound/soc/atmel/atmel_wm8904.c
@@ -183,6 +183,7 @@ static struct platform_driver atmel_asoc_wm8904_driver = {
 	.driver = {
 		.name = "atmel-wm8904-audio",
 		.of_match_table = of_match_ptr(atmel_asoc_wm8904_dt_ids),
+		.pm		= &snd_soc_pm_ops,
 	},
 	.probe = atmel_asoc_wm8904_probe,
 	.remove = atmel_asoc_wm8904_remove,
-- 
2.6.2
