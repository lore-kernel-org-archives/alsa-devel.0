From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt2701: Fix -Wunused-const-variable
 warnings" to the asoc tree
Date: Thu, 22 Aug 2019 19:32:57 +0100 (BST)
Message-ID: <20190822183257.3AE96D02CE6@fitzroy.sirena.org.uk>
References: <20190822143747.20944-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190822143747.20944-1-yuehaibing@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: alsa-devel@alsa-project.org, swboyd@chromium.org, tiwai@suse.com, yuehaibing@huawei.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, pihsun@chromium.org, matthias.bgg@gmail.com, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt2701: Fix -Wunused-const-variable warnings

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

>From 97aad5ce88164bc5f884b5234f015ac553ea2fe5 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 22 Aug 2019 22:37:47 +0800
Subject: [PATCH] ASoC: mediatek: mt2701: Fix -Wunused-const-variable warnings

sound/soc/mediatek/mt2701/mt2701-afe-common.h:66:27: warning:
 mt2701_afe_backup_list defined but not used [-Wunused-const-variable=]

mt2701_afe_backup_list is only used in mt2701-afe-pcm.c,
so just move the definition over there.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190822143747.20944-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-common.h | 21 -------------------
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    | 21 +++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
index d44faba27d3c..32bef5e2a56d 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-common.h
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
@@ -63,27 +63,6 @@ enum audio_base_clock {
 	MT2701_BASE_CLK_NUM,
 };
 
-static const unsigned int mt2701_afe_backup_list[] = {
-	AUDIO_TOP_CON0,
-	AUDIO_TOP_CON4,
-	AUDIO_TOP_CON5,
-	ASYS_TOP_CON,
-	AFE_CONN0,
-	AFE_CONN1,
-	AFE_CONN2,
-	AFE_CONN3,
-	AFE_CONN15,
-	AFE_CONN16,
-	AFE_CONN17,
-	AFE_CONN18,
-	AFE_CONN19,
-	AFE_CONN20,
-	AFE_CONN21,
-	AFE_CONN22,
-	AFE_DAC_CON0,
-	AFE_MEMIF_PBUF_SIZE,
-};
-
 struct mt2701_i2s_data {
 	int i2s_ctrl_reg;
 	int i2s_asrc_fs_shift;
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index d7f5defa50c2..76502ba261c8 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -60,6 +60,27 @@ static const struct mt2701_afe_rate mt2701_afe_i2s_rates[] = {
 	{ .rate = 352800, .regvalue = 24 },
 };
 
+static const unsigned int mt2701_afe_backup_list[] = {
+	AUDIO_TOP_CON0,
+	AUDIO_TOP_CON4,
+	AUDIO_TOP_CON5,
+	ASYS_TOP_CON,
+	AFE_CONN0,
+	AFE_CONN1,
+	AFE_CONN2,
+	AFE_CONN3,
+	AFE_CONN15,
+	AFE_CONN16,
+	AFE_CONN17,
+	AFE_CONN18,
+	AFE_CONN19,
+	AFE_CONN20,
+	AFE_CONN21,
+	AFE_CONN22,
+	AFE_DAC_CON0,
+	AFE_MEMIF_PBUF_SIZE,
+};
+
 static int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
 {
 	struct mt2701_afe_private *afe_priv = afe->platform_priv;
-- 
2.20.1
