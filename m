From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] ASoC: soc-pcm: skip dpcm path checking with
	incapable/unready FE
Date: Mon, 17 Nov 2014 16:02:57 +0800
Message-ID: <1416211377-9559-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 29A9D2614E3
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 09:03:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.de, perex@perex.cz, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

Skip dpcm path checking for playback or capture, if corresponding FE
doesn't support playback or capture, or currently is not ready. It
can reduce the unnecessary cost to search connected widgets.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 sound/soc/soc-pcm.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 002311a..3b068d4 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2248,7 +2248,13 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 			fe->dai_link->name);
 
 		/* skip if FE doesn't have playback capability */
-		if (!fe->cpu_dai->driver->playback.channels_min)
+		if (!fe->cpu_dai->driver->playback.channels_min
+		    || !fe->codec_dai->driver->playback.channels_min)
+			goto capture;
+
+		/* skip if FE doesn't do playback */
+		if (!fe->cpu_dai->playback_active
+		    || !fe->codec_dai->playback_active)
 			goto capture;
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
@@ -2278,7 +2284,13 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 		dpcm_path_put(&list);
 capture:
 		/* skip if FE doesn't have capture capability */
-		if (!fe->cpu_dai->driver->capture.channels_min)
+		if (!fe->cpu_dai->driver->capture.channels_min
+		    || !fe->codec_dai->driver->capture.channels_min)
+			continue;
+
+		/* skip if FE doesn't do capture */
+		if (!fe->cpu_dai->capture_active
+		    || !fe->codec_dai->capture_active)
 			continue;
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
-- 
1.7.9.5
