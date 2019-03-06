From: Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH 0/2] Fix UBSAN warning in mtk-afe-fe-dai
Date: Wed,  6 Mar 2019 17:09:01 +0800
Message-ID: <20190306090922.117634-1-pihsun@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Pi-Hsun Shih <pihsun@chromium.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Garlic Tseng <garlic.tseng@mediatek.com>, KaiChieh Chuang <kaichieh.chuang@mediatek.com>, Kees Cook <keescook@chromium.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC
        support" <linux-mediatek@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Masanari Iida <standby24x7@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shunli Wang <shunli.wang@mediatek.com>, Wei Yongjun <weiyongjun1@huawei.com>
List-Id: alsa-devel@alsa-project.org

This fix a UBSAN warning on mediatek mtk-afe-fe-dai, and also clean up
code to prevent new config introduce the UBSAN warning again.

Pi-Hsun Shih (2):
  ASoC: mediatek: Fix UBSAN warning.
  ASoC: mediatek: Reduce repititive code on mtk_regmap_update_bits.

 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 51 +++++++++-------------
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 ------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 16 -------
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 16 -------
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 20 ---------
 5 files changed, 20 insertions(+), 96 deletions(-)

-- 
2.21.0.352.gf09ad66450-goog
