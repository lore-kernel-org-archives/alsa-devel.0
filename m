From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2 16/16] ASoC: twl6040: Fix TLV dB step values
	for gains
Date: Fri, 10 Dec 2010 21:06:39 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225DF@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 358141039F6
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 04:06:42 +0100 (CET)
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

Some gains were incorrectly configured for dB values.

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 6e0839a..315ce19 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -954,9 +954,9 @@ static DECLARE_TLV_DB_SCALE(mic_preamp_tlv, -600, 600, 0);
 
 /*
  * MICGAIN volume control:
- * from 6 to 30 dB in 6 dB steps
+ * from -6 to 30 dB in 6 dB steps
  */
-static DECLARE_TLV_DB_SCALE(mic_amp_tlv, 600, 600, 0);
+static DECLARE_TLV_DB_SCALE(mic_amp_tlv, -600, 600, 0);
 
 /*
  * AFMGAIN volume control:
-- 
1.7.0.4
