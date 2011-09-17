From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Add line loads to the list of
	supported detections for Speyside
Date: Sat, 17 Sep 2011 14:14:51 +0100
Message-ID: <1316265291-3758-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1316265291-3758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65745103820
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 15:14:55 +0200 (CEST)
In-Reply-To: <1316265291-3758-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 6652c3c..dfa62c9 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -167,7 +167,8 @@ static int speyside_wm8996_init(struct snd_soc_pcm_runtime *rtd)
 	gpio_direction_output(WM8996_HPSEL_GPIO, speyside_jack_polarity);
 
 	ret = snd_soc_jack_new(codec, "Headset",
-			       SND_JACK_HEADSET | SND_JACK_BTN_0,
+			       SND_JACK_LINEOUT | SND_JACK_HEADSET |
+			       SND_JACK_BTN_0,
 			       &speyside_headset);
 	if (ret)
 		return ret;
-- 
1.7.6.3
