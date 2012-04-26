From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm8994: Allow rate configuration
	with custom mic callback
Date: Thu, 26 Apr 2012 17:25:08 +0100
Message-ID: <1335457509-31442-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335457509-31442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C83510BB88
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 18:25:16 +0200 (CEST)
In-Reply-To: <1335457509-31442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If a driver using a custom mic detection callback has provided a table
of mic detection rates via platform data then use it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 9754904..95f34af 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -82,7 +82,8 @@ static void wm8958_micd_set_rate(struct snd_soc_codec *codec)
 	const struct wm8958_micd_rate *rates;
 	int num_rates;
 
-	if (wm8994->jack_cb != wm8958_default_micdet)
+	if (!(wm8994->pdata && wm8994->pdata->micd_rates) &&
+	    wm8994->jack_cb != wm8958_default_micdet)
 		return;
 
 	idle = !wm8994->jack_mic;
-- 
1.7.10
