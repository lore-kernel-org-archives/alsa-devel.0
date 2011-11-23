From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Cleanup duplicated const
Date: Wed, 23 Nov 2011 14:11:21 +0100
Message-ID: <1322053881-5270-1-git-send-email-lars@metafoo.de>
References: <1322044840-32709-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 75F28103B09
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 14:10:33 +0100 (CET)
In-Reply-To: <1322044840-32709-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Commit 85e7652("ASoC: Constify snd_soc_dai_ops structs") accidentally
introduced a few duplicated consts. This patch cleans it up.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/au1x/i2sc.c       |    2 +-
 sound/soc/codecs/adau1373.c |    2 +-
 sound/soc/codecs/adau1701.c |    2 +-
 sound/soc/codecs/adav80x.c  |    2 +-
 sound/soc/codecs/cs42l73.c  |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index 2d5f755..6bcf48f 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -201,7 +201,7 @@ static int au1xi2s_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const const struct snd_soc_dai_ops au1xi2s_dai_ops = {
+static const struct snd_soc_dai_ops au1xi2s_dai_ops = {
 	.startup	= au1xi2s_startup,
 	.trigger	= au1xi2s_trigger,
 	.hw_params	= au1xi2s_hw_params,
diff --git a/sound/soc/codecs/adau1373.c b/sound/soc/codecs/adau1373.c
index 2e040af..45c6302 100644
--- a/sound/soc/codecs/adau1373.c
+++ b/sound/soc/codecs/adau1373.c
@@ -1042,7 +1042,7 @@ static int adau1373_set_dai_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static const const struct snd_soc_dai_ops adau1373_dai_ops = {
+static const struct snd_soc_dai_ops adau1373_dai_ops = {
 	.hw_params	= adau1373_hw_params,
 	.set_sysclk	= adau1373_set_dai_sysclk,
 	.set_fmt	= adau1373_set_dai_fmt,
diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
index c69bdfe..8b7e1c5 100644
--- a/sound/soc/codecs/adau1701.c
+++ b/sound/soc/codecs/adau1701.c
@@ -427,7 +427,7 @@ static int adau1701_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 #define ADAU1701_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
 
-static const const struct snd_soc_dai_ops adau1701_dai_ops = {
+static const struct snd_soc_dai_ops adau1701_dai_ops = {
 	.set_fmt	= adau1701_set_dai_fmt,
 	.hw_params	= adau1701_hw_params,
 	.digital_mute	= adau1701_digital_mute,
diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index d927feb..f9f0894 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -718,7 +718,7 @@ static void adav80x_dai_shutdown(struct snd_pcm_substream *substream,
 		adav80x->rate = 0;
 }
 
-static const const struct snd_soc_dai_ops adav80x_dai_ops = {
+static const struct snd_soc_dai_ops adav80x_dai_ops = {
 	.set_fmt = adav80x_set_dai_fmt,
 	.hw_params = adav80x_hw_params,
 	.startup = adav80x_dai_startup,
diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 75d80b2..d09578f 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1190,7 +1190,7 @@ static int cs42l73_pcm_startup(struct snd_pcm_substream *substream,
 #define CS42L73_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
 
-static const const struct snd_soc_dai_ops cs42l73_ops = {
+static const struct snd_soc_dai_ops cs42l73_ops = {
 	.startup = cs42l73_pcm_startup,
 	.hw_params = cs42l73_pcm_hw_params,
 	.set_fmt = cs42l73_set_dai_fmt,
-- 
1.7.7.1
