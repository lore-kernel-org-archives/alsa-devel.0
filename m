From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: Intel: rt5645_set_jack_detect is
	changed
Date: Mon, 20 Apr 2015 10:37:22 +0800
Message-ID: <1429497442-13021-2-git-send-email-bardliao@realtek.com>
References: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D1F8F2652AE
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 04:37:45 +0200 (CEST)
In-Reply-To: <1429497442-13021-1-git-send-email-bardliao@realtek.com>
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

rt5645_set_jack_detect is changed, so we need to modify the code
which is using rt5645_set_jack_detect.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/intel/cht_bsw_rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/cht_bsw_rt5645.c b/sound/soc/intel/cht_bsw_rt5645.c
index bd29617..3d0b549 100644
--- a/sound/soc/intel/cht_bsw_rt5645.c
+++ b/sound/soc/intel/cht_bsw_rt5645.c
@@ -185,7 +185,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	rt5645_set_jack_detect(codec, &ctx->hp_jack, &ctx->mic_jack);
+	rt5645_set_jack_detect(codec, &ctx->hp_jack, &ctx->mic_jack, NULL);
 
 	return ret;
 }
-- 
1.8.1.1.439.g50a6b54
