From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Compillation error fix
Date: Tue,  7 Apr 2009 09:14:00 +0300
Message-ID: <1239084840-16546-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1239084840-16546-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C5EF24356
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Apr 2009 08:14:24 +0200 (CEST)
In-Reply-To: <1239084840-16546-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, sfr@canb.auug.org.au, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Fix for compillation error introduced by the constrain patch.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index bfda7a8..921b205 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1220,11 +1220,12 @@ static int twl4030_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int twl4030_startup(struct snd_pcm_substream *substream)
+static int twl4030_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->codec;
+	struct snd_soc_codec *codec = socdev->card->codec;
 	struct twl4030_priv *twl4030 = codec->private_data;
 
 	/* If we already have a playback or capture going then constrain
@@ -1251,11 +1252,12 @@ static int twl4030_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static void twl4030_shutdown(struct snd_pcm_substream *substream)
+static void twl4030_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->codec;
+	struct snd_soc_codec *codec = socdev->card->codec;
 	struct twl4030_priv *twl4030 = codec->private_data;
 
 	if (twl4030->master_substream == substream)
-- 
1.6.2.2
