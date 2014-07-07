From: <bardliao@realtek.com>
Subject: [PATCH 1/3] ASoC: RT286: remove test code
Date: Mon, 7 Jul 2014 16:48:36 +0800
Message-ID: <1404722918-17466-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 98DE826533B
 for <alsa-devel@alsa-project.org>; Mon,  7 Jul 2014 10:49:13 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Remove test code.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt286.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index acfba9c..7c5f9d0 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -993,7 +993,6 @@ static int rt286_probe(struct snd_soc_codec *codec)
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	rt286->codec = codec;
 
-	rt286->i2c->irq = 0;
 	if (rt286->i2c->irq) {
 		snd_soc_update_bits(codec,
 					RT286_IRQ_CTRL, 0x2, 0x2);
-- 
1.8.1.1.439.g50a6b54
