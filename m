From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Factor out common init code"
	to the asoc tree
Date: Tue, 13 Nov 2018 18:28:02 +0000 (GMT)
Message-ID: <20181113182802.C98BA440078@finisterre.ee.mobilebroadband>
References: <20181112133639.13444-2-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B47B26751A
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:28:11 +0100 (CET)
In-Reply-To: <20181112133639.13444-2-rf@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Factor out common init code

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From dcad34f818f2a23b9a51c7c2a21e167fff441e52 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Mon, 12 Nov 2018 13:36:39 +0000
Subject: [PATCH] ASoC: wm_adsp: Factor out common init code

Factor out the duplicated initialization statements from
wm_adsp1_init() and wm_adsp2_init() into new function
wm_adsp_common_init().

The entire content of wm_adsp1_init() is the common code
but it is convenient to retain this exported function
to hide what we currently treat as common init (which might
change in the future) and also make clear the difference
between an ADSP1 entry point and common code.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index a53dc174bbf0..0ed44e5c58f7 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2416,7 +2416,7 @@ static int wm_adsp_create_name(struct wm_adsp *dsp)
 	return 0;
 }
 
-int wm_adsp1_init(struct wm_adsp *dsp)
+static int wm_adsp_common_init(struct wm_adsp *dsp)
 {
 	int ret;
 
@@ -2425,11 +2425,17 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 		return ret;
 
 	INIT_LIST_HEAD(&dsp->alg_regions);
+	INIT_LIST_HEAD(&dsp->ctl_list);
 
 	mutex_init(&dsp->pwr_lock);
 
 	return 0;
 }
+
+int wm_adsp1_init(struct wm_adsp *dsp)
+{
+	return wm_adsp_common_init(dsp);
+}
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
 
 int wm_adsp1_event(struct snd_soc_dapm_widget *w,
@@ -2914,7 +2920,7 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 {
 	int ret;
 
-	ret = wm_adsp_create_name(dsp);
+	ret = wm_adsp_common_init(dsp);
 	if (ret)
 		return ret;
 
@@ -2936,12 +2942,8 @@ int wm_adsp2_init(struct wm_adsp *dsp)
 		break;
 	}
 
-	INIT_LIST_HEAD(&dsp->alg_regions);
-	INIT_LIST_HEAD(&dsp->ctl_list);
 	INIT_WORK(&dsp->boot_work, wm_adsp2_boot_work);
 
-	mutex_init(&dsp->pwr_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_init);
-- 
2.19.1
