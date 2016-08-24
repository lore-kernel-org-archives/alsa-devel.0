From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: tas5086: fix typo: "Inavlid" -> "Invalid"
Date: Wed, 24 Aug 2016 07:48:06 +0100
Message-ID: <20160824064806.15809-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AED2266142
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 08:49:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

trivial typo fix in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tas5086.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index c297b9f..b7de857 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -387,7 +387,7 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 	val = index_in_array(tas5086_ratios, ARRAY_SIZE(tas5086_ratios),
 			     priv->mclk / priv->rate);
 	if (val < 0) {
-		dev_err(codec->dev, "Inavlid MCLK / Fs ratio\n");
+		dev_err(codec->dev, "Invalid MCLK / Fs ratio\n");
 		return -EINVAL;
 	}
 
-- 
2.9.3
