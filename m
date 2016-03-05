From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Remove unneeded variable ret
	returning 0" to the asoc tree
Date: Sat, 05 Mar 2016 21:24:40 +0900
Message-ID: <E1acBGC-0003DY-IL@finisterre>
References: <1455170015-25009-1-git-send-email-rajan.vaja@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3AE3260515
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:53 +0100 (CET)
In-Reply-To: <1455170015-25009-1-git-send-email-rajan.vaja@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajan Vaja <rajan.vaja@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Remove unneeded variable ret returning 0

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

>From e066ea2214f77e13e24344313243f9b3a182d3c4 Mon Sep 17 00:00:00 2001
From: Rajan Vaja <rajan.vaja@gmail.com>
Date: Thu, 11 Feb 2016 11:23:35 +0530
Subject: [PATCH] ASoC: dapm: Remove unneeded variable ret returning 0

This patch fixes coccicheck report:
	Unneeded variable: "ret". Return "0" on line 2817

Remove unneccesary variable ret created to return zero.

Signed-off-by: Rajan Vaja <rajan.vaja@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5a2812fa8946..8dc395f15049 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2805,7 +2805,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num)
 {
-	int i, ret = 0;
+	int i;
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
@@ -2814,7 +2814,7 @@ int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 	}
 	mutex_unlock(&dapm->card->dapm_mutex);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_del_routes);
 
-- 
2.7.0
