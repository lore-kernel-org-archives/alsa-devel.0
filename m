From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/8] ASoC: pxa: Pass correct DAPM context to
	{corgi, poodle, spitz}_ext_control
Date: Sat,  1 Mar 2014 15:48:13 +0100
Message-ID: <1393685300-5307-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-192.synserver.de
 [212.40.185.192])
 by alsa0.perex.cz (Postfix) with ESMTP id DFF3826536B
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 15:47:52 +0100 (CET)
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

When calling {corgi,poodle,spitz}_ext_control() from the startup callback we
pass the CODEC's DAPM context instead of the card's DAPM context. This is not a
problem per se since all the DAPM functions in ext_control() fallback to widgets
from other DAPM contexts, but passing the card's context is more consistent.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/corgi.c  | 3 +--
 sound/soc/pxa/poodle.c | 3 +--
 sound/soc/pxa/spitz.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index b4db3b9..5a88136 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -101,10 +101,9 @@ static void corgi_ext_control(struct snd_soc_dapm_context *dapm)
 static int corgi_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
 
 	/* check the jack status at stream startup */
-	corgi_ext_control(&codec->dapm);
+	corgi_ext_control(&rtd->card->dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 27c6c03..c6bdc6c 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -74,10 +74,9 @@ static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 static int poodle_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
 
 	/* check the jack status at stream startup */
-	poodle_ext_control(&codec->dapm);
+	poodle_ext_control(&rtd->card->dapm);
 
 	return 0;
 }
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index a3a13c9..1373b01 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -111,10 +111,9 @@ static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 static int spitz_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->codec;
 
 	/* check the jack status at stream startup */
-	spitz_ext_control(&codec->dapm);
+	spitz_ext_control(&rtd->card->dapm);
 
 	return 0;
 }
-- 
1.8.0
