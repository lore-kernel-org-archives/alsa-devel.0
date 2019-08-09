From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt6351: remove unused variable 'mt_lineout_control'"
 to the asoc tree
Date: Fri,  9 Aug 2019 13:31:52 +0100 (BST)
Message-ID: <20190809123152.AA2A0274303D@ypsilon.sirena.org.uk>
References: <20190809080234.23332-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190809080234.23332-1-yuehaibing@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt6351: remove unused variable 'mt_lineout_control'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From bc8d9f737fc01cce913f1cc215b7e66f01697e52 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 9 Aug 2019 16:02:34 +0800
Subject: [PATCH] ASoC: mt6351: remove unused variable 'mt_lineout_control'

sound/soc/codecs/mt6351.c:1070:38: warning:
 mt_lineout_control defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190809080234.23332-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/mt6351.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index 4b3ce01c5a93..5c0536eb1044 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1066,11 +1066,6 @@ static int mt_mic_bias_2_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-/* DAPM Kcontrols */
-static const struct snd_kcontrol_new mt_lineout_control =
-	SOC_DAPM_SINGLE("Switch", MT6351_AUDDEC_ANA_CON3,
-			RG_AUDLOLPWRUP_VAUDP32_BIT, 1, 0);
-
 /* DAPM Widgets */
 static const struct snd_soc_dapm_widget mt6351_dapm_widgets[] = {
 	/* Digital Clock */
-- 
2.20.1
