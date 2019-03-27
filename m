From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: mt8183: change supported formats of DL2
	and UL1
Date: Wed, 27 Mar 2019 14:42:36 +0800
Message-ID: <20190327064236.144843-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com
 [IPv6:2607:f8b0:4864:20::849])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1CBE2F801D9
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2019 07:42:58 +0100 (CET)
Received: by mail-qt1-x849.google.com with SMTP id 18so15962322qtw.20
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2019 23:42:57 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, cychiang@google.com, jiaxin.yu@mediatek.com, tzungbi@google.com, shunli.wang@mediatek.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

DL2 and UL1 should only provide 16-bit, mono, 8kHz and 16kHz to
userspace.  Change the formats accordingly.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 43be51bf0329..ad42da1b948c 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -195,9 +195,9 @@ static struct snd_soc_dai_driver mt8183_memif_dai_driver[] = {
 		.playback = {
 			.stream_name = "DL2",
 			.channels_min = 1,
-			.channels_max = 2,
-			.rates = MTK_PCM_RATES,
-			.formats = MTK_PCM_FORMATS,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
 		.ops = &mtk_afe_fe_ops,
 	},
@@ -219,9 +219,9 @@ static struct snd_soc_dai_driver mt8183_memif_dai_driver[] = {
 		.capture = {
 			.stream_name = "UL1",
 			.channels_min = 1,
-			.channels_max = 2,
-			.rates = MTK_PCM_RATES,
-			.formats = MTK_PCM_FORMATS,
+			.channels_max = 1,
+			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 		},
 		.ops = &mtk_afe_fe_ops,
 	},
-- 
2.21.0.392.gf8f6787159e-goog
