From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/3] ASoC: omap: rx51: Report headset insertion
	instead of video out cable
Date: Mon, 14 Feb 2011 17:20:22 +0200
Message-ID: <1297696822-32174-3-git-send-email-jhnikula@gmail.com>
References: <1297696822-32174-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 77F8C243F7
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 16:20:47 +0100 (CET)
Received: by eyg24 with SMTP id 24so2155270eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2011 07:20:41 -0800 (PST)
In-Reply-To: <1297696822-32174-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

It is more usefull to report headset instead of video out cable in response
to jack insertion as this is more usual use-case and because now the headset
feature is supported. Automatic accessory detection is not possible at the
moment so most sensible static accessory type have to be used.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/omap/rx51.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 9860018..e28f089 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -240,7 +240,7 @@ static struct snd_soc_jack_gpio rx51_av_jack_gpios[] = {
 	{
 		.gpio = RX51_JACK_DETECT_GPIO,
 		.name = "avdet-gpio",
-		.report = SND_JACK_VIDEOOUT,
+		.report = SND_JACK_HEADSET,
 		.invert = 1,
 		.debounce_time = 200,
 	},
@@ -331,7 +331,8 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtime *rtd)
 
 	/* AV jack detection */
 	err = snd_soc_jack_new(codec, "AV Jack",
-			       SND_JACK_VIDEOOUT, &rx51_av_jack);
+			       SND_JACK_HEADSET | SND_JACK_VIDEOOUT,
+			       &rx51_av_jack);
 	if (err)
 		return err;
 	err = snd_soc_jack_add_gpios(&rx51_av_jack,
-- 
1.7.0.4
