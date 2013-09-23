From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/6] ASoC: tlv320aic3x: Remove nonsense comment
	for register cache
Date: Tue, 24 Sep 2013 00:12:43 +0100
Message-ID: <1379977968-25982-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A0EB2610D3
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 01:12:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Every statement in this comment is incorrect either through bitrot or
(mostly) through never having corresponded to reality in the first place.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic3x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6e3f269..3abbff3 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -90,12 +90,6 @@ struct aic3x_priv {
 	enum aic3x_micbias_voltage micbias_vg;
 };
 
-/*
- * AIC3X register cache
- * We can't read the AIC3X register space when we are
- * using 2 wire for device control, so we cache them instead.
- * There is no point in caching the reset register
- */
 static const u8 aic3x_reg[AIC3X_CACHEREGNUM] = {
 	0x00, 0x00, 0x00, 0x10,	/* 0 */
 	0x04, 0x00, 0x00, 0x00,	/* 4 */
-- 
1.8.4.rc3
