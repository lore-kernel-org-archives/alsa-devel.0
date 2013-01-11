From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/5] ASoC: twl6040: Only set the bias_level
	once in twl6040_resume()
Date: Fri, 11 Jan 2013 17:01:00 +0100
Message-ID: <1357920063-15141-3-git-send-email-peter.ujfalusi@ti.com>
References: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id B132A265017
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 17:01:10 +0100 (CET)
In-Reply-To: <1357920063-15141-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

No need to set the bias_level twice to _STANDBY - since this is the only
state the device could be at suspend time. The driver do not support
idle_bias_off yet.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index ef31ace..86f12a4 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1115,7 +1115,6 @@ static int twl6040_suspend(struct snd_soc_codec *codec)
 static int twl6040_resume(struct snd_soc_codec *codec)
 {
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
 
 	return 0;
 }
-- 
1.8.1
