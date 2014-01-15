From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/3] ASoC: tlv320aic32x4: Fix regmap range_min
Date: Wed, 15 Jan 2014 18:12:40 +0100
Message-ID: <1389805962-18670-2-git-send-email-mpa@pengutronix.de>
References: <1389805962-18670-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7C33C2608EA
 for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2014 18:12:54 +0100 (CET)
In-Reply-To: <1389805962-18670-1-git-send-email-mpa@pengutronix.de>
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

range_min is the lowest address in the virtual register range. This is
the first register with address 0, not the first register of page 1.

Currently all writes to page 1 are mapped to page 0, so the codec fails
to operate.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 6941fa9..385dec1 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -267,7 +267,7 @@ static const struct regmap_range_cfg aic32x4_regmap_pages[] = {
 		.selector_mask  = 0xff,
 		.window_start = 0,
 		.window_len = 128,
-		.range_min = AIC32X4_PAGE1,
+		.range_min = 0,
 		.range_max = AIC32X4_RMICPGAVOL,
 	},
 };
-- 
1.8.5.2
