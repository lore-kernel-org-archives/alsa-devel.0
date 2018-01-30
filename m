From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 7/7] ASoC: max9867: Take chip out of shutdown
Date: Tue, 30 Jan 2018 12:11:12 +0100
Message-ID: <20180130111112.GH18123@lenoch>
References: <20180130110604.GA18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id D22D62675DA
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 12:11:13 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23994711AbeA3LLNUaZd0 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Tue, 30 Jan 2018 12:11:13 +0100
Content-Disposition: inline
In-Reply-To: <20180130110604.GA18123@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Note: It would be great to take only used parts of
       codec out of shutdown and put them to sleep
       again once unused.

 sound/soc/codecs/max9867.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 6272cf5df4a9..06d11b9f4286 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -158,8 +158,7 @@ static int max9867_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
 
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
+	regmap_write(max9867->regmap, MAX9867_PWRMAN, 0xff);
 	return 0;
 }
 
-- 
2.15.1
