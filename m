From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: dpcm: Explicitly set BE DAI link
	supported stream directions
Date: Tue,  7 Jan 2014 17:51:42 +0000
Message-ID: <1389117102-6488-2-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1389117102-6488-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F8AF2650C2
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:52:19 +0100 (CET)
In-Reply-To: <1389117102-6488-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some BE DAIs can be "dummy" (when the DSP is controlling the DAI) and as such
wont have set a minimum number of playback or capture channels required for BE
DAI registration (to establish supported stream directions).

Force machine drivers to explicitly set whether they support playback and capture
stream directions for every BE DAIs.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc.h | 4 ++++
 sound/soc/soc-pcm.c | 6 ++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1cda7d3..0a600b8d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -888,6 +888,10 @@ struct snd_soc_dai_link {
 	/* This DAI link can route to other DAI links at runtime (Frontend)*/
 	unsigned int dynamic:1;
 
+	/* DPCM capture and Playback support */
+	unsigned int dpcm_capture:1;
+	unsigned int dpcm_playback:1;
+
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index feb0f28..9680d5f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2133,10 +2133,8 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	int ret = 0, playback = 0, capture = 0;
 
 	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
-		if (cpu_dai->driver->playback.channels_min)
-			playback = 1;
-		if (cpu_dai->driver->capture.channels_min)
-			capture = 1;
+		playback = rtd->dai_link->dpcm_playback;
+		capture = rtd->dai_link->dpcm_capture;
 	} else {
 		if (codec_dai->driver->playback.channels_min &&
 		    cpu_dai->driver->playback.channels_min)
-- 
1.8.3.2
