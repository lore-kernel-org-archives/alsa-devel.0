From: weiyj_lk@163.com
Subject: [PATCH -next v2] ASoC: mediatek: mt2701: fix non
	static symbol warning
Date: Fri,  8 Jul 2016 13:47:01 +0000
Message-ID: <1467985621-13755-1-git-send-email-weiyj_lk@163.com>
References: <1467985293-9041-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C7D1B265B65
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 15:47:04 +0200 (CEST)
In-Reply-To: <1467985293-9041-1-git-send-email-weiyj_lk@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warning:

sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:72:5: warning:
 symbol 'mt2701_dai_num_to_i2s' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 15522c0..34a6123 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -69,7 +69,7 @@ static const struct mt2701_afe_rate mt2701_afe_i2s_rates[] = {
 	{ .rate = 352800, .regvalue = 24 },
 };
 
-int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
+static int mt2701_dai_num_to_i2s(struct mtk_base_afe *afe, int num)
 {
 	int val = num - MT2701_IO_I2S;
