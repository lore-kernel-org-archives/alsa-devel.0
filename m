From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: sti_uniperiph_dai_create_ctrl()
	can be static" to the asoc tree
Date: Fri, 17 Jul 2015 01:10:03 +0100
Message-ID: <E1ZFtE3-00040d-Nq@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E374260614
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 02:10:14 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: sti_uniperiph_dai_create_ctrl() can be static

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

>From f2da4542268503d22869617b7dbcb40d364c78bb Mon Sep 17 00:00:00 2001
From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 17 Jul 2015 07:44:09 +0800
Subject: [PATCH] ASoC: sti: sti_uniperiph_dai_create_ctrl() can be static

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/sti_uniperif.c    | 2 +-
 sound/soc/sti/uniperif_player.c | 4 ++--
 sound/soc/sti/uniperif_reader.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 749e6b294184..83a301f2aa66 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -14,7 +14,7 @@
  * This function is used to create Ctrl associated to DAI but also pcm device.
  * Request is done by front end to associate ctrl with pcm device id
  */
-int sti_uniperiph_dai_create_ctrl(struct snd_soc_dai *dai)
+static int sti_uniperiph_dai_create_ctrl(struct snd_soc_dai *dai)
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *uni = priv->dai_data.uni;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d990d2c81a5d..f609089a6e00 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -43,7 +43,7 @@
  * Note: snd_pcm_hardware is linked to DMA controller but is declared here to
  * integrate  DAI_CPU capability in term of rate and supported channels
  */
-const struct snd_pcm_hardware uni_player_pcm_hw = {
+static const struct snd_pcm_hardware uni_player_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID,
@@ -175,7 +175,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
-int uni_player_clk_set_rate(struct uniperif *player, unsigned long rate)
+static int uni_player_clk_set_rate(struct uniperif *player, unsigned long rate)
 {
 	int rate_adjusted, rate_achieved, delta, ret;
 	int adjustment = player->clk_adj;
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 7d83827ba660..c502626f339b 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -17,7 +17,7 @@
  * Note: snd_pcm_hardware is linked to DMA controller but is declared here to
  * integrate unireader capability in term of rate and supported channels
  */
-const struct snd_pcm_hardware uni_reader_pcm_hw = {
+static const struct snd_pcm_hardware uni_reader_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID,
@@ -324,7 +324,7 @@ static int uni_reader_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
-const struct snd_soc_dai_ops uni_reader_dai_ops = {
+static const struct snd_soc_dai_ops uni_reader_dai_ops = {
 		.shutdown = uni_reader_shutdown,
 		.prepare = uni_reader_prepare,
 		.trigger = uni_reader_trigger,
-- 
2.1.4
