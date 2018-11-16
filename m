From: Colin King <colin.king@canonical.com>
Subject: [PATCH 2/5] ASoC: tlv320aic31xx: asihpi: clean up
	indentation, remove extraneous tab
Date: Fri, 16 Nov 2018 15:06:33 +0000
Message-ID: <20181116150636.5226-2-colin.king@canonical.com>
References: <20181116150636.5226-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 03FA9267949
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 16:06:41 +0100 (CET)
In-Reply-To: <20181116150636.5226-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The return statement is indented too much by one level, fix this by
removing an extraneous tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 608ad49ad978..c6048d95c6d3 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1095,7 +1095,7 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if (freq/i > 20000000) {
 		dev_err(aic31xx->dev, "%s: Too high mclk frequency %u\n",
 			__func__, freq);
-			return -EINVAL;
+		return -EINVAL;
 	}
 	aic31xx->p_div = i;
 
-- 
2.19.1
