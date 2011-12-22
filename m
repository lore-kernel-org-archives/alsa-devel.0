From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Declare soc_new_pcm() properly
Date: Thu, 22 Dec 2011 12:17:06 +0000
Message-ID: <1324556226-26386-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 950FF103D13
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 13:17:10 +0100 (CET)
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

Ensure that everything is seeing the same declaration by moving it to
a header file rather than putting the declaration in soc-core.c

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |    2 --
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e5414ed..312dfd3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -323,6 +323,7 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 					unsigned int reg);
 int snd_soc_platform_write(struct snd_soc_platform *platform,
 					unsigned int reg, unsigned int val);
+int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
 
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d3fcdc1..d19d0d1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -59,8 +59,6 @@ static LIST_HEAD(dai_list);
 static LIST_HEAD(platform_list);
 static LIST_HEAD(codec_list);
 
-int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
-
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
  * It can be used to eliminate pops between different playback streams, e.g.
-- 
1.7.7.3
