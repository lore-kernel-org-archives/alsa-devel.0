From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/2] ASoC: codec: tlv320aic32x4: Fix regmap
	range config
Date: Sat, 11 Jan 2014 14:48:30 +0100
Message-ID: <1389448111-17064-2-git-send-email-mpa@pengutronix.de>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7F4612616FA
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 14:49:09 +0100 (CET)
In-Reply-To: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

This codec driver fails to probe because it has a higher regmap
range_max value than max_register. This patch sets the range_max to the
max_register value as described in the for struct regmap_range_cfg:
"@range_max: Address of the highest register in virtual range."

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 18cdcca..6941fa9 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -268,7 +268,7 @@ static const struct regmap_range_cfg aic32x4_regmap_pages[] = {
 		.window_start = 0,
 		.window_len = 128,
 		.range_min = AIC32X4_PAGE1,
-		.range_max = AIC32X4_PAGE1 + 127,
+		.range_max = AIC32X4_RMICPGAVOL,
 	},
 };
 
-- 
1.8.5.2
