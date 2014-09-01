From: weiyj_lk@163.com
Subject: [PATCH -next] ASoC: es8328: fix error return code in
	es8328_codec_probe()
Date: Mon,  1 Sep 2014 08:47:50 +0800
Message-ID: <1409532470-32364-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 511F2261B25
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 02:47:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Sean Cross <xobs@kosagi.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/es8328.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 7a9f65a..3ff7870 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -665,6 +665,7 @@ static int es8328_codec_probe(struct snd_soc_codec *codec)
 	es8328->clk = devm_clk_get(codec->dev, NULL);
 	if (IS_ERR(es8328->clk)) {
 		dev_err(codec->dev, "codec clock missing or invalid\n");
+		ret = PTR_ERR(es8328->clk);
 		goto clk_fail;
 	}
 
