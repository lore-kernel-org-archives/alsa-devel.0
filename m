From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 09/10] ASoC: twl6040/sdp4430: Change legacy
	DAI name
Date: Thu, 22 Sep 2011 11:05:53 +0300
Message-ID: <1316678754-11935-10-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id DD771103B0D
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:36 +0200 (CEST)
Received: by bkbzu5 with SMTP id zu5so3343408bkb.35
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:34 -0700 (PDT)
In-Reply-To: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Change the legacy DAI name from "twl6040-hifi" to "twl6040-legacy" to
be more intuitive.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 sound/soc/omap/sdp4430.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 3908b88..760701e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1444,7 +1444,7 @@ static struct snd_soc_dai_ops twl6040_dai_ops = {
 
 static struct snd_soc_dai_driver twl6040_dai[] = {
 {
-	.name = "twl6040-hifi",
+	.name = "twl6040-legacy",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index a951774..4200eb4 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -166,7 +166,7 @@ static struct snd_soc_dai_link sdp4430_dai = {
 	.name = "TWL6040",
 	.stream_name = "TWL6040",
 	.cpu_dai_name = "omap-mcpdm",
-	.codec_dai_name = "twl6040-hifi",
+	.codec_dai_name = "twl6040-legacy",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl6040-codec",
 	.init = sdp4430_twl6040_init,
-- 
1.7.6.1
