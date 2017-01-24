From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Fixup wm_adsp2_boot_work error
	paths" to the asoc tree
Date: Tue, 24 Jan 2017 18:39:07 +0000
Message-ID: <E1cW5zn-0006V6-B4@debutante>
References: <1485258241-10575-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C4337266CC1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 19:39:22 +0100 (CET)
In-Reply-To: <1485258241-10575-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Fixup wm_adsp2_boot_work error paths

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

>From d589d8b83503c1f153965f4c2747349ccca6995e Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 24 Jan 2017 11:44:01 +0000
Subject: [PATCH] ASoC: wm_adsp: Fixup wm_adsp2_boot_work error paths

Currently we are not disabling MEM_ENA on the error path, we should
really do this to unwind the state back to how it was. This patch adds a
clear of MEM_ENA on the error path, again there is no major issues
caused by this minor fix.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 746a5e23cb8b..651857b529f9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2450,7 +2450,7 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 
 	ret = wm_adsp2_ena(dsp);
 	if (ret != 0)
-		goto err_mutex;
+		goto err_mem;
 
 	ret = wm_adsp_load(dsp);
 	if (ret != 0)
@@ -2484,6 +2484,9 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 err_ena:
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+err_mem:
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+			   ADSP2_MEM_ENA, 0);
 err_mutex:
 	mutex_unlock(&dsp->pwr_lock);
 }
-- 
2.11.0
