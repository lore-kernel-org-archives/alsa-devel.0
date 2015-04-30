From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: fix implicit declaration error
Date: Thu, 30 Apr 2015 10:30:01 +0800
Message-ID: <1430361001-17507-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D133F260851
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 04:30:14 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

kbuild robot reports a implicit declaration of function
'rt5645_irq_detection' error.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a81a24f..8bad9fe 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2535,6 +2535,8 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	return rt5645->jack_type;
 }
 
+static int rt5645_irq_detection(struct rt5645_priv *rt5645);
+
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack,
 	struct snd_soc_jack *btn_jack)
-- 
1.8.1.1.439.g50a6b54
