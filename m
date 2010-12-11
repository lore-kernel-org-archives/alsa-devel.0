From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 09/16] ASoC: twl6040: Fix analog Mic L & R
	mux controls
Date: Fri, 10 Dec 2010 21:06:03 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225D8@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 39E84103A8E
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 04:06:05 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Francois Mazard <f-mazard@ti.com>

The mux control has 4 elements not 3

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 9776715..27fc1b9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -508,8 +508,8 @@ static const char *twl6040_amicr_texts[] =
 	{"Headset Mic", "Sub Mic", "Aux/FM Right", "Off"};
 
 static const struct soc_enum twl6040_enum[] = {
-	SOC_ENUM_SINGLE(TWL6040_REG_MICLCTL, 3, 3, twl6040_amicl_texts),
-	SOC_ENUM_SINGLE(TWL6040_REG_MICRCTL, 3, 3, twl6040_amicr_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_MICLCTL, 3, 4, twl6040_amicl_texts),
+	SOC_ENUM_SINGLE(TWL6040_REG_MICRCTL, 3, 4, twl6040_amicr_texts),
 };
 
 static const char *twl6040_hs_texts[] = {
-- 
1.7.0.4
