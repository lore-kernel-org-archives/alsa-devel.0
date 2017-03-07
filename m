From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: dio2125: use gpiod_set_value_cansleep
Date: Tue,  7 Mar 2017 14:12:22 +0100
Message-ID: <20170307131222.23907-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C134266AC4
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 14:12:33 +0100 (CET)
Received: by mail-wm0-f42.google.com with SMTP id t189so4400789wmt.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Mar 2017 05:12:33 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Use the "cansleep" variant of gpiod_set_value so the driver can be used
with slow gpio controllers as well.

Fixes: 85825d5e8869 ("ASoC: dio2125: add dio2125 amp driver")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/dio2125.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/dio2125.c b/sound/soc/codecs/dio2125.c
index 015e310556d3..09451cd44f9b 100644
--- a/sound/soc/codecs/dio2125.c
+++ b/sound/soc/codecs/dio2125.c
@@ -46,7 +46,7 @@ static int drv_event(struct snd_soc_dapm_widget *w,
 		return -EINVAL;
 	}
 
-	gpiod_set_value(priv->gpiod_enable, val);
+	gpiod_set_value_cansleep(priv->gpiod_enable, val);
 
 	return 0;
 }
-- 
2.9.3
