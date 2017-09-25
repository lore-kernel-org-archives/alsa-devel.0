From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_rt5672: use actual HID
	in suspend/resume" to the asoc tree
Date: Mon, 25 Sep 2017 17:16:26 +0100 (BST)
Message-ID: <20170925161626.0C4FF440053@finisterre.ee.mobilebroadband>
References: <20170822203239.19891-14-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E198266ECE
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:30 +0200 (CEST)
In-Reply-To: <20170822203239.19891-14-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_rt5672: use actual HID in suspend/resume

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

>From e45e39123a04a1bb1fbccfcd4c59efc332a0037f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 7 Sep 2017 20:12:55 -0500
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5672: use actual HID in suspend/resume

The code scans all components looking for the default name
i2c-10EC5670:00, which of course doesn't work in platforms
where the BIOS uses a different HID such as Dell 5585

Since we already have the correct information available, just
use the actual codec name and length.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index a0e60bc1f84f..5b1e3ee965a7 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -347,9 +347,11 @@ static struct snd_soc_dai_link cht_dailink[] = {
 static int cht_suspend_pre(struct snd_soc_card *card)
 {
 	struct snd_soc_component *component;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 
 	list_for_each_entry(component, &card->component_dev_list, card_list) {
-		if (!strcmp(component->name, "i2c-10EC5670:00")) {
+		if (!strncmp(component->name,
+			     ctx->codec_name, sizeof(ctx->codec_name))) {
 			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
 			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
@@ -363,9 +365,11 @@ static int cht_suspend_pre(struct snd_soc_card *card)
 static int cht_resume_post(struct snd_soc_card *card)
 {
 	struct snd_soc_component *component;
+	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(card);
 
 	list_for_each_entry(component, &card->component_dev_list, card_list) {
-		if (!strcmp(component->name, "i2c-10EC5670:00")) {
+		if (!strncmp(component->name,
+			     ctx->codec_name, sizeof(ctx->codec_name))) {
 			struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
 
 			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
-- 
2.14.1
