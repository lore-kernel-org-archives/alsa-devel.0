From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 07/11] soc - spitz - Fix checkpatch warnings
Date: Wed, 23 Apr 2008 13:08:01 +0100
Message-ID: <1208952485-20385-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1208952485-20385-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1208952485-20385-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5151244DC
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 14:08:08 +0200 (CEST)
In-Reply-To: <1208952485-20385-6-git-send-email-broonie@opensource.wolfsonmicro.com>
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
 sound/soc/pxa/spitz.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index ecca390..d8b8372 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -313,15 +313,13 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	}
 
 	/* Add spitz specific widgets */
-	for (i = 0; i < ARRAY_SIZE(wm8750_dapm_widgets); i++) {
+	for (i = 0; i < ARRAY_SIZE(wm8750_dapm_widgets); i++)
 		snd_soc_dapm_new_control(codec, &wm8750_dapm_widgets[i]);
-	}
 
 	/* Set up spitz specific audio path audio_map */
-	for (i = 0; audio_map[i][0] != NULL; i++) {
+	for (i = 0; audio_map[i][0] != NULL; i++)
 		snd_soc_dapm_connect_input(codec, audio_map[i][0],
 			audio_map[i][1], audio_map[i][2]);
-	}
 
 	snd_soc_dapm_sync_endpoints(codec);
 	return 0;
-- 
1.5.5.1
