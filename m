From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] ASoC: twl6040: Prevent extra power
	transitions during resume
Date: Fri, 11 Jan 2013 11:32:32 +0100
Message-ID: <1357900355-5055-3-git-send-email-peter.ujfalusi@ti.com>
References: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id D75C82625F3
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 11:32:41 +0100 (CET)
In-Reply-To: <1357900355-5055-1-git-send-email-peter.ujfalusi@ti.com>
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

From: Misael Lopez Cruz <misael.lopez@ti.com>

Prevent unnecessary power state transitions that might occur while
CODEC is resuming if already in target state.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index ef31ace..b40830c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1114,8 +1114,10 @@ static int twl6040_suspend(struct snd_soc_codec *codec)
 
 static int twl6040_resume(struct snd_soc_codec *codec)
 {
-	twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
+	if (codec->dapm.bias_level != codec->dapm.suspend_bias_level) {
+		twl6040_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+		twl6040_set_bias_level(codec, codec->dapm.suspend_bias_level);
+	}
 
 	return 0;
 }
-- 
1.8.1
