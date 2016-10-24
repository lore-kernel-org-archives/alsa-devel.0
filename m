From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt298: fix jack type detect error
Date: Mon, 24 Oct 2016 18:32:18 +0800
Message-ID: <1477305139-10513-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id C99EF266B76
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 12:32:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, vinod.koul@intel.com, Bard Liao <bardliao@realtek.com>, shumingf@realtek.com, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

rt298_jack_detect may be called before card is instantiated. And
snd_soc_dapm_force_enable_pin will not work in that case. So, update
bit manually by regmap_update_bits.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index f80cfe4..dceffe9 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -249,6 +249,11 @@ static int rt298_jack_detect(struct rt298_priv *rt298, bool *hp, bool *mic)
 			snd_soc_dapm_force_enable_pin(dapm, "LDO1");
 			snd_soc_dapm_sync(dapm);
 
+			regmap_update_bits(rt298->regmap,
+				RT298_POWER_CTRL1, 0x1001, 0);
+			regmap_update_bits(rt298->regmap,
+				RT298_POWER_CTRL2, 0x4, 0x4);
+
 			regmap_write(rt298->regmap, RT298_SET_MIC1, 0x24);
 			msleep(50);
 
-- 
1.8.1.1.439.g50a6b54
