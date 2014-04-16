From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 17/18] ASoC: omap-hdmi-card: Use the same name
	for platform as the cpu_dai
Date: Wed, 16 Apr 2014 12:23:30 +0300
Message-ID: <1397640211-15447-18-git-send-email-peter.ujfalusi@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C65FF265312
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:24:18 +0200 (CEST)
In-Reply-To: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that the platform driver is registered with the cpu_dai's device we
can use the same name for it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-hdmi-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index 7e66e9cba5a8..f649fe84b629 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -33,7 +33,7 @@ static struct snd_soc_dai_link omap_hdmi_dai = {
 	.name = "HDMI",
 	.stream_name = "HDMI",
 	.cpu_dai_name = "omap-hdmi-audio-dai",
-	.platform_name = "omap-pcm-audio",
+	.platform_name = "omap-hdmi-audio-dai",
 	.codec_name = "hdmi-audio-codec",
 	.codec_dai_name = "hdmi-hifi",
 };
-- 
1.9.2
