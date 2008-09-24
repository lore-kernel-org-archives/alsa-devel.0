From: <20080924115907.GA12401@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Use snd_soc_dapm_nc_pin() in GTA01
	audio driver
Date: Wed, 24 Sep 2008 13:01:10 +0100
Message-ID: <1222257670-12527-4-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
References: <1222257670-12527-1-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
	<1222257670-12527-2-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
	<1222257670-12527-3-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8FB062432C
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 14:01:11 +0200 (CEST)
In-Reply-To: <1222257670-12527-3-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 48c6756..41fc69c 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -510,13 +510,12 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 	DBG("Entered %s\n", __func__);
 
 	/* set up NC codec pins */
-	snd_soc_dapm_disable_pin(codec, "LOUT2");
-	snd_soc_dapm_disable_pin(codec, "ROUT2");
-	snd_soc_dapm_disable_pin(codec, "OUT3");
-	snd_soc_dapm_disable_pin(codec, "OUT4");
-	snd_soc_dapm_disable_pin(codec, "LINE1");
-	snd_soc_dapm_disable_pin(codec, "LINE2");
-
+	snd_soc_dapm_nc_pin(codec, "LOUT2");
+	snd_soc_dapm_nc_pin(codec, "ROUT2");
+	snd_soc_dapm_nc_pin(codec, "OUT3");
+	snd_soc_dapm_nc_pin(codec, "OUT4");
+	snd_soc_dapm_nc_pin(codec, "LINE1");
+	snd_soc_dapm_nc_pin(codec, "LINE2");
 
 	/* set endpoints to default mode */
 	set_scenario_endpoints(codec, NEO_AUDIO_OFF);
-- 
1.5.6.5
