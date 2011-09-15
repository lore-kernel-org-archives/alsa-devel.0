From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 15/17] ASoC: twl6040/sdp4430: Change legacy DAI
	name
Date: Thu, 15 Sep 2011 15:39:37 +0300
Message-ID: <1316090379-30760-16-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E07F103B76
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:46 +0200 (CEST)
Received: by mail-bw0-f50.google.com with SMTP id zt19so2903326bkb.23
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:45 -0700 (PDT)
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Change the legacy DAI name from "twl6040-hifi" to "twl6040-legacy" to
be more intuitive.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |    2 +-
 sound/soc/omap/sdp4430.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 891b9ec..1be8d1b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1440,7 +1440,7 @@ static struct snd_soc_dai_ops twl6040_dai_ops = {
 
 static struct snd_soc_dai_driver twl6040_dai[] = {
 {
-	.name = "twl6040-hifi",
+	.name = "twl6040-legacy",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index d462f1a..060066b 100644
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
