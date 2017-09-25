From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Make snd_soc_dapm_add/del_routes
	use runtime mutex subclass" to the asoc tree
Date: Mon, 25 Sep 2017 17:35:20 +0100 (BST)
Message-ID: <20170925163521.039AA440052@finisterre.ee.mobilebroadband>
References: <1505988132-9511-1-git-send-email-stuarth@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 76399266FD8
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:56 +0200 (CEST)
In-Reply-To: <1505988132-9511-1-git-send-email-stuarth@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stuart Henderson <stuarth@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Make snd_soc_dapm_add/del_routes use runtime mutex subclass

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

>From f19c181f20cdfb2aa5f4a1bba095a008e34ed61b Mon Sep 17 00:00:00 2001
From: Stuart Henderson <stuarth@opensource.cirrus.com>
Date: Thu, 21 Sep 2017 11:02:12 +0100
Subject: [PATCH] ASoC: dapm: Make snd_soc_dapm_add/del_routes use runtime
 mutex subclass

Make snd_soc_dapm_add_routes and snd_soc_dapm_del_routes use the
SND_SOC_DAPM_CLASS_RUNTIME dapm subclass to allow dynamic dapm route
updates.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d55cac655195..ba78a88d2af0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2884,7 +2884,7 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 {
 	int i, r, ret = 0;
 
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	for (i = 0; i < num; i++) {
 		r = snd_soc_dapm_add_route(dapm, route);
 		if (r < 0) {
@@ -2915,7 +2915,7 @@ int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 {
 	int i;
 
-	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	for (i = 0; i < num; i++) {
 		snd_soc_dapm_del_route(dapm, route);
 		route++;
-- 
2.14.1
