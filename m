From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 05/11] soc - corgi - Fix checkpatch warnings
Date: Wed, 23 Apr 2008 13:07:59 +0100
Message-ID: <1208952485-20385-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF727244CD
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:08 +0200 (CEST)
In-Reply-To: <1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/corgi.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 1a70a6a..7f32a11 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -297,21 +297,19 @@ static int corgi_wm8731_init(struct snd_soc_codec *codec)
 	/* Add corgi specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8731_corgi_controls); i++) {
 		err = snd_ctl_add(codec->card,
-			snd_soc_cnew(&wm8731_corgi_controls[i],codec, NULL));
+			snd_soc_cnew(&wm8731_corgi_controls[i], codec, NULL));
 		if (err < 0)
 			return err;
 	}
 
 	/* Add corgi specific widgets */
-	for(i = 0; i < ARRAY_SIZE(wm8731_dapm_widgets); i++) {
+	for (i = 0; i < ARRAY_SIZE(wm8731_dapm_widgets); i++)
 		snd_soc_dapm_new_control(codec, &wm8731_dapm_widgets[i]);
-	}
 
 	/* Set up corgi specific audio path audio_map */
-	for(i = 0; audio_map[i][0] != NULL; i++) {
+	for (i = 0; audio_map[i][0] != NULL; i++)
 		snd_soc_dapm_connect_input(codec, audio_map[i][0],
 			audio_map[i][1], audio_map[i][2]);
-	}
 
 	snd_soc_dapm_sync_endpoints(codec);
 	return 0;
@@ -353,7 +351,8 @@ static int __init corgi_init(void)
 {
 	int ret;
 
-	if (!(machine_is_corgi() || machine_is_shepherd() || machine_is_husky()))
+	if (!(machine_is_corgi() || machine_is_shepherd() ||
+	      machine_is_husky()))
 		return -ENODEV;
 
 	corgi_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.5.5.1
