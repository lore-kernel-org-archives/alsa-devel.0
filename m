From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: pxa: Remove superfluous locking
Date: Sat, 22 Feb 2014 18:44:17 +0100
Message-ID: <1393091057-13510-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-133.synserver.de
 [212.40.185.133])
 by alsa0.perex.cz (Postfix) with ESMTP id AB55E261B0C
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2014 18:44:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

The locking here was added in commit 71a295602e ("ASoC: Lock the CODEC in PXA
external jack controls") to protect the DAPM changes that are made inside of
${board}_ext_control() against concurrent updates. The ASoC core was updated in
commit a73fb2df01 ("ASoC: dapm: Use DAPM mutex for DAPM ops instead of codec
mutex") to use a card wide lock rather the CODEC mutex to protect DAPM
operations. We now have proper locking inside ${board}_ext_control() itself, so
taking the CODEC lock can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/corgi.c    | 4 ----
 sound/soc/pxa/magician.c | 4 ----
 sound/soc/pxa/poodle.c   | 4 ----
 sound/soc/pxa/spitz.c    | 4 ----
 sound/soc/pxa/tosa.c     | 4 ----
 5 files changed, 20 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 9d9c8ad..b4db3b9 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -103,13 +103,9 @@ static int corgi_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
-	mutex_lock(&codec->mutex);
-
 	/* check the jack status at stream startup */
 	corgi_ext_control(&codec->dapm);
 
-	mutex_unlock(&codec->mutex);
-
 	return 0;
 }
 
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 31242be..41ab6678 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -77,13 +77,9 @@ static int magician_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
-	mutex_lock(&codec->mutex);
-
 	/* check the jack status at stream startup */
 	magician_ext_control(codec);
 
-	mutex_unlock(&codec->mutex);
-
 	return 0;
 }
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index c93e138..27c6c03 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -76,13 +76,9 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
-	mutex_lock(&codec->mutex);
-
 	/* check the jack status at stream startup */
 	poodle_ext_control(&codec->dapm);
 
-	mutex_unlock(&codec->mutex);
-
 	return 0;
 }
 
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 04dbb5a..a3a13c9 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -113,13 +113,9 @@ static int spitz_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
-	mutex_lock(&codec->mutex);
-
 	/* check the jack status at stream startup */
 	spitz_ext_control(&codec->dapm);
 
-	mutex_unlock(&codec->mutex);
-
 	return 0;
 }
 
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 2a4b438..cead165 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -84,13 +84,9 @@ static int tosa_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
-	mutex_lock(&codec->mutex);
-
 	/* check the jack status at stream startup */
 	tosa_ext_control(codec);
 
-	mutex_unlock(&codec->mutex);
-
 	return 0;
 }
 
-- 
1.8.0
