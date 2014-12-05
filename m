From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: samsung: Fix non-DT use of I2S controller
Date: Fri,  5 Dec 2014 19:57:07 +0000
Message-ID: <1417809427-5126-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B758C260426
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 20:57:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Padmavathi Venna <padma.v@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The changes in commit a5a56871f804e (ASoC: samsung: add support for exynos7
I2S controller) introduce a new variant_regs structure in the driver data
which is now mandatory for accessing registers. Unfortunately this is only
hooked up for DT platforms so non-DT platforms like my primary development
platform for audio are broken by this change and crash on boot.

Since the only non-DT user of these device is s3c64xx fix this by making
the standard samsung-i2s device be of type I2Sv3 and add a new I2Sv4 name
to the platform data section, currently using the I2Sv5 information which
should be about right.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e1ace5270a8b..25919e090983 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1418,10 +1418,13 @@ static const struct samsung_i2s_dai_data samsung_dai_type_sec = {
 static struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
-		.driver_data    = (kernel_ulong_t)&samsung_dai_type_pri,
+		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
 	}, {
 		.name           = "samsung-i2s-sec",
 		.driver_data    = (kernel_ulong_t)&samsung_dai_type_sec,
+	}, {
+		.name		= "samsung-i2sv4",
+		.driver_data	= (kernel_ulong_t)&i2sv5_dai_type_i2s1,
 	},
 	{},
 };
-- 
2.1.3
