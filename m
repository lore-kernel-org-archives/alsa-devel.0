From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: wm2200: Drop unnecessary dapm
	bias_level initialization
Date: Mon, 16 Mar 2015 16:39:57 +0100
Message-ID: <1426520397-24263-2-git-send-email-lars@metafoo.de>
References: <1426520397-24263-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-126.synserver.de
 [212.40.185.126])
 by alsa0.perex.cz (Postfix) with ESMTP id DAA732612D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 16:39:53 +0100 (CET)
In-Reply-To: <1426520397-24263-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The default value for the bias_level is SND_SOC_BIAS_OFF when probe is being
called, there is no need to initialize it explicitly.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm2200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index b48694a..5a9da28 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1554,7 +1554,6 @@ static int wm2200_probe(struct snd_soc_codec *codec)
 	int ret;
 
 	wm2200->codec = codec;
-	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 
 	ret = snd_soc_add_codec_controls(codec, wm_adsp1_fw_controls, 2);
 	if (ret != 0)
-- 
1.8.0
