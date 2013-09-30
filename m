From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: pcm: Remove extra spaces from dev_ prints
Date: Mon, 30 Sep 2013 17:08:15 +0300
Message-ID: <1380550095-21080-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F028261A50
 for <alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 16:09:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

dev_ prints are already prefixed by ": " before format string so there is no
need for extra spaces.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/soc-pcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 330c9a6..d449872 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -721,7 +721,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
 	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
 
-	dev_dbg(fe->dev, "  connected new DPCM %s path %s %s %s\n",
+	dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
 			stream ? "capture" : "playback",  fe->dai_link->name,
 			stream ? "<-" : "->", be->dai_link->name);
 
@@ -749,7 +749,7 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 		if (dpcm->fe == fe)
 			continue;
 
-		dev_dbg(fe->dev, "  reparent %s path %s %s %s\n",
+		dev_dbg(fe->dev, "reparent %s path %s %s %s\n",
 			stream ? "capture" : "playback",
 			dpcm->fe->dai_link->name,
 			stream ? "<-" : "->", dpcm->be->dai_link->name);
@@ -773,7 +773,7 @@ static void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 		if (dpcm->state != SND_SOC_DPCM_LINK_STATE_FREE)
 			continue;
 
-		dev_dbg(fe->dev, "  freed DSP %s path %s %s %s\n",
+		dev_dbg(fe->dev, "freed DSP %s path %s %s %s\n",
 			stream ? "capture" : "playback", fe->dai_link->name,
 			stream ? "<-" : "->", dpcm->be->dai_link->name);
 
@@ -2116,7 +2116,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 	pcm->private_free = platform->driver->pcm_free;
 out:
-	dev_info(rtd->card->dev, " %s <-> %s mapping ok\n", codec_dai->name,
+	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n", codec_dai->name,
 		cpu_dai->name);
 	return ret;
 }
-- 
1.8.4.rc3
