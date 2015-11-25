From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: core: Change power state before
	rechecking endpoint" to the asoc tree
Date: Wed, 25 Nov 2015 13:00:00 +0000
Message-ID: <E1a1Zg0-0002o1-9n@debutante>
References: <1448293951-32071-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C81232606CD
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:06 +0100 (CET)
In-Reply-To: <1448293951-32071-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: core: Change power state before rechecking endpoint

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

>From 1a7aaa58ec7aaa389cd6b200809908ec472d316b Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 23 Nov 2015 21:22:31 +0530
Subject: [PATCH] ASoC: core: Change power state before rechecking endpoint

For DAPM resume, we should first change the power state of the
card and then recheck the endpoints. This ensures the dapm is
resumed first and then userspace can resume the streams.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 24b096066a07..a1305f827a98 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -795,12 +795,12 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	dev_dbg(card->dev, "ASoC: resume work completed\n");
 
-	/* userspace can access us now we are back as we were before */
-	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
-
 	/* Recheck all endpoints too, their state is affected by suspend */
 	dapm_mark_endpoints_dirty(card);
 	snd_soc_dapm_sync(&card->dapm);
+
+	/* userspace can access us now we are back as we were before */
+	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D0);
 }
 
 /* powers up audio subsystem after a suspend */
-- 
2.6.2
