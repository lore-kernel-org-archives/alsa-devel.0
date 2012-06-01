From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Fix connected widget capture path
	query.
Date: Fri,  1 Jun 2012 18:03:00 +0100
Message-ID: <1338570180-12299-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog128.obsmtp.com (na3sys009aog128.obsmtp.com
	[74.125.149.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 166B0104582
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 19:03:09 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so1575344wgb.20
	for <alsa-devel@alsa-project.org>; Fri, 01 Jun 2012 10:03:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Make sure we check the correct path for capture.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3bb7a6f..24ddcb6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -960,7 +960,7 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		paths = is_connected_output_ep(dai->playback_widget, list);
 	else
-		paths = is_connected_input_ep(dai->playback_widget, list);
+		paths = is_connected_input_ep(dai->capture_widget, list);
 
 	trace_snd_soc_dapm_connected(paths, stream);
 	dapm_clear_walk(&card->dapm);
-- 
1.7.9.5
