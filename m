From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Lock the CODEC in PXA external jack
	controls
Date: Fri,  5 Nov 2010 13:53:21 -0400
Message-ID: <1288979601-9105-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D744E10396F
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 18:53:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When doing anything with the system, especially DAPM, we need to hold the
CODEC mutex.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/corgi.c    |    5 +++++
 sound/soc/pxa/magician.c |    4 ++++
 sound/soc/pxa/poodle.c   |    5 +++++
 sound/soc/pxa/spitz.c    |    5 +++++
 sound/soc/pxa/tosa.c     |    5 +++++
 5 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 97e9423..f451acd 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -100,8 +100,13 @@ static int corgi_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
+	mutex_lock(&codec->mutex);
+
 	/* check the jack status at stream startup */
 	corgi_ext_control(codec);
+
+	mutex_unlock(&codec->mutex);
+
 	return 0;
 }
 
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index b8207ce..5ef0526 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -72,9 +72,13 @@ static int magician_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
+	mutex_lock(&codec->mutex);
+
 	/* check the jack status at stream startup */
 	magician_ext_control(codec);
 
+	mutex_unlock(&codec->mutex);
+
 	return 0;
 }
 
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index af84ee9..84edd03 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -77,8 +77,13 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
+	mutex_lock(&codec->mutex);
+
 	/* check the jack status at stream startup */
 	poodle_ext_control(codec);
+
+	mutex_unlock(&codec->mutex);
+
 	return 0;
 }
 
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index f470f36..0b30d7d 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -108,8 +108,13 @@ static int spitz_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
+	mutex_lock(&codec->mutex);
+
 	/* check the jack status at stream startup */
 	spitz_ext_control(codec);
+
+	mutex_unlock(&codec->mutex);
+
 	return 0;
 }
 
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 73d0edd..7b983f9 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -81,8 +81,13 @@ static int tosa_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
 
+	mutex_lock(&codec->mutex);
+
 	/* check the jack status at stream startup */
 	tosa_ext_control(codec);
+
+	mutex_unlock(&codec->mutex);
+
 	return 0;
 }
 
-- 
1.7.1
