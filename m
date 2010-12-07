From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 14/15] ASoC: twl6040: Use correct offset for
	LineInAmp Right
Date: Mon, 6 Dec 2010 18:18:20 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD4@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id C573410397E
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:18:23 +0100 (CET)
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

From: Misael Lopez Cruz <misael.lopez@ti.com>

Gain for LineInAmp Right uses LINEGAIN[5:3], which means that
offset for right channel should be 4.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index a8bad49..9b12219 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -997,7 +997,7 @@ static const struct snd_kcontrol_new twl6040_snd_controls[] = {
 
 	/* AFM gains */
 	SOC_DOUBLE_TLV("Aux FM Volume",
-		TWL6040_REG_LINEGAIN, 0, 5, 0xF, 0, afm_amp_tlv),
+		TWL6040_REG_LINEGAIN, 0, 4, 0xF, 0, afm_amp_tlv),
 
 	/* Playback gains */
 	SOC_TWL6040_DOUBLE_TLV("Headset Playback Volume",
-- 
1.7.0.4
