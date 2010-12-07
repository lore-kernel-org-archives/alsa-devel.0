From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH 05/15] ASoC: twl6040: Restore bias level at
	resume
Date: Mon, 6 Dec 2010 18:17:56 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCCB@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id D35E5103996
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 01:17:58 +0100 (CET)
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

This patch restores the CODEC bias level at resume().

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 7417b50..81bf781 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1072,6 +1072,7 @@ static int twl6040_suspend(struct snd_soc_codec *codec, pm_message_t state)
 static int twl6040_resume(struct snd_soc_codec *codec)
 {
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
 
 	return 0;
 }
-- 
1.7.0.4
