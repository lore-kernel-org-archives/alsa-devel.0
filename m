From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: mt2701: Fix -Wunused-const-variable warnings
Date: Thu, 22 Aug 2019 22:37:47 +0800
Message-ID: <20190822143747.20944-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, yuehaibing@huawei.com, pihsun@chromium.org, swboyd@chromium.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

sound/soc/mediatek/mt2701/mt2701-afe-common.h:66:27: warning:
 mt2701_afe_backup_list defined but not used [-Wunused-const-variable=]

mt2701_afe_backup_list is only used in mt2701-afe-pcm.c,
so just move the definition over there.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-common.h | 21 ---------------------
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
index d44faba..32bef5e 100644
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
index d7f5def..76502ba 100644
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
2.7.4
