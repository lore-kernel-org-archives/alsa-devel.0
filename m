From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Fix bclk for sample rates that
	are multiple of 4kHz
Date: Wed, 23 Dec 2015 14:18:05 +0000
Message-ID: <1450880285-23865-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 44DF12664C8
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 15:18:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Nikesh Oswal <Nikesh.Oswal@cirrus.com>

For a sample rate of 12kHz the bclk was taken from the 44.1kHz table as
we test for a multiple of 8kHz. This patch fixes this issue by testing
for multiples of 4kHz instead.

Signed-off-by: Nikesh Oswal <Nikesh.Oswal@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 88e2c74..33143fe 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1659,7 +1659,7 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	bool reconfig;
 	unsigned int aif_tx_state, aif_rx_state;
 
-	if (params_rate(params) % 8000)
+	if (params_rate(params) % 4000)
 		rates = &arizona_44k1_bclk_rates[0];
 	else
 		rates = &arizona_48k_bclk_rates[0];
-- 
2.1.4
