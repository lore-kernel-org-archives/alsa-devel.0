From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: board: Remove .owner
	initialization in bxt_rt298 driver" to the asoc tree
Date: Thu, 20 Jul 2017 13:23:59 +0100
Message-ID: <E1dYAUp-00019p-CU@debutante>
References: <1500531057-4286-2-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3DAD266CED
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 14:24:09 +0200 (CEST)
In-Reply-To: <1500531057-4286-2-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: board: Remove .owner initialization in bxt_rt298 driver

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

>From 0e46ccd5bc12ab28da9d2f514492aeead65f8332 Mon Sep 17 00:00:00 2001
From: Pradeep Tewani <pradeep.d.tewani@intel.com>
Date: Thu, 20 Jul 2017 11:40:55 +0530
Subject: [PATCH] ASoC: Intel: board: Remove .owner initialization in bxt_rt298
 driver

The .owner field is not required to be initialized in the driver. So,
remove it.

Signed-off-by: Pradeep Tewani <pradeep.d.tewani@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 0c3a3cbcb884..1daf98ef9d28 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -492,7 +492,6 @@ static int bxt_card_late_probe(struct snd_soc_card *card)
 /* broxton audio machine driver for SPT + RT298S */
 static struct snd_soc_card broxton_rt298 = {
 	.name = "broxton-rt298",
-	.owner = THIS_MODULE,
 	.dai_link = broxton_rt298_dais,
 	.num_links = ARRAY_SIZE(broxton_rt298_dais),
 	.controls = broxton_controls,
-- 
2.13.2
