From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: img-parallel-out: Add
	pm_runtime_get/put to set_fmt callback" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:39 +0100
Message-ID: <E1dzhqx-0004Om-7C@debutante>
References: <1506938433-681-1-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B61D267447
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 13:28:41 +0200 (CEST)
In-Reply-To: <1506938433-681-1-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: img-parallel-out: Add pm_runtime_get/put to set_fmt callback

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

>From c70458890ff15d858bd347fa9f563818bcd6e457 Mon Sep 17 00:00:00 2001
From: Ed Blake <ed.blake@sondrel.com>
Date: Mon, 2 Oct 2017 11:00:33 +0100
Subject: [PATCH] ASoC: img-parallel-out: Add pm_runtime_get/put to set_fmt
 callback

Add pm_runtime_get_sync and pm_runtime_put calls to set_fmt callback
function. This fixes a bus error during boot when CONFIG_SUSPEND is
defined when this function gets called while the device is runtime
disabled and device registers are accessed while the clock is disabled.

Signed-off-by: Ed Blake <ed.blake@sondrel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/img/img-parallel-out.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index 23b0f0f6ec9c..2fc8a6372206 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -164,9 +164,11 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
+	pm_runtime_get_sync(prl->dev);
 	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
 	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
 	img_prl_out_writel(prl, reg, IMG_PRL_OUT_CTL);
+	pm_runtime_put(prl->dev);
 
 	return 0;
 }
-- 
2.14.1
