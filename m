From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Add widgets before setting endpoints
	on GTA01
Date: Thu,  2 Oct 2008 11:02:29 +0100
Message-ID: <1222941751-3238-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081002100200.GA3025@rakim.wolfsonmicro.main>
	<1222941751-3238-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1222941751-3238-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67E0124514
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Oct 2008 12:02:33 +0200 (CEST)
In-Reply-To: <1222941751-3238-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jonas Bonn <jonas.bonn@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Jonas Bonn <jonas.bonn@gmail.com>

This prevents error messages at startup where the endpoints are being
set before the widgets/controls have even been added.

Signed-off-by: Jonas Bonn <jonas.bonn@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 41fc69c..f3ac449 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -517,13 +517,13 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_nc_pin(codec, "LINE1");
 	snd_soc_dapm_nc_pin(codec, "LINE2");
 
-	/* set endpoints to default mode */
-	set_scenario_endpoints(codec, NEO_AUDIO_OFF);
-
 	/* Add neo1973 specific widgets */
 	snd_soc_dapm_new_controls(codec, wm8753_dapm_widgets,
 				  ARRAY_SIZE(wm8753_dapm_widgets));
 
+	/* set endpoints to default mode */
+	set_scenario_endpoints(codec, NEO_AUDIO_OFF);
+
 	/* add neo1973 specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8753_neo1973_controls); i++) {
 		err = snd_ctl_add(codec->card,
-- 
1.5.6.5
