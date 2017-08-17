From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: make snd_soc_ops const" to the
	asoc tree
Date: Thu, 17 Aug 2017 18:13:02 +0100
Message-ID: <E1diOLu-0008Lv-8p@debutante>
References: <1502902770-3758-7-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E60A0267054
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 19:13:36 +0200 (CEST)
In-Reply-To: <1502902770-3758-7-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, heiko@sntech.de, linux-rockchip@lists.infradead.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, tiwai@suse.com, haojian.zhuang@gmail.com, lgirdwood@gmail.com, julia.lawall@lip6.fr, broonie@kernel.org, krzk@kernel.org, s.nawrocki@samsung.com, robert.jarzmik@free.fr, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: make snd_soc_ops const

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

>From 2af236391f5a167630ebca0eced832afcc4634e0 Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 16 Aug 2017 22:29:29 +0530
Subject: [PATCH] ASoC: samsung: make snd_soc_ops const

Make these const as they are only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/jive_wm8750.c     | 2 +-
 sound/soc/samsung/s3c24xx_simtec.c  | 2 +-
 sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
 sound/soc/samsung/smdk_spdif.c      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
index 7fcb51faa2a0..529b10dc532b 100644
--- a/sound/soc/samsung/jive_wm8750.c
+++ b/sound/soc/samsung/jive_wm8750.c
@@ -79,7 +79,7 @@ static int jive_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops jive_ops = {
+static const struct snd_soc_ops jive_ops = {
 	.hw_params	= jive_hw_params,
 };
 
diff --git a/sound/soc/samsung/s3c24xx_simtec.c b/sound/soc/samsung/s3c24xx_simtec.c
index dcc008d1e1ab..6de63f3e37d5 100644
--- a/sound/soc/samsung/s3c24xx_simtec.c
+++ b/sound/soc/samsung/s3c24xx_simtec.c
@@ -211,7 +211,7 @@ static int simtec_call_startup(struct s3c24xx_audio_simtec_pdata *pd)
 	return 0;
 }
 
-static struct snd_soc_ops simtec_snd_ops = {
+static const struct snd_soc_ops simtec_snd_ops = {
 	.hw_params	= simtec_hw_params,
 };
 
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 55538e333cc8..c65c89d4aaa6 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -199,7 +199,7 @@ static int s3c24xx_uda134x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_ops s3c24xx_uda134x_ops = {
+static const struct snd_soc_ops s3c24xx_uda134x_ops = {
 	.startup = s3c24xx_uda134x_startup,
 	.shutdown = s3c24xx_uda134x_shutdown,
 	.hw_params = s3c24xx_uda134x_hw_params,
diff --git a/sound/soc/samsung/smdk_spdif.c b/sound/soc/samsung/smdk_spdif.c
index a2f2363fe1c2..7fc7cc6d1530 100644
--- a/sound/soc/samsung/smdk_spdif.c
+++ b/sound/soc/samsung/smdk_spdif.c
@@ -144,7 +144,7 @@ static int smdk_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_ops smdk_spdif_ops = {
+static const struct snd_soc_ops smdk_spdif_ops = {
 	.hw_params = smdk_hw_params,
 };
 
-- 
2.13.3
