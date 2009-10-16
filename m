From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] Fix possible codec_dai->ops NULL pointer
	problems
Date: Fri, 16 Oct 2009 18:13:38 +0800
Message-ID: <1255688018-1301-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 7755224572
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 12:13:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Barry Song <barry.song@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@gmail.com>

Some codec DAIs like stac9766, wm9712, wm9713, ad1980 don't register themselves
then it loses to the chance to be given a null_dai_ops in snd_soc_register_dai
if they have no ops. When functions like soc_pcm_open, soc_pcm_hw_params etc.
access the ops field in these DAIs, panic will happen.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/soc-core.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fa0da3c..2d190df 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -795,6 +795,9 @@ static int soc_resume(struct device *dev)
 #define soc_resume	NULL
 #endif
 
+static struct snd_soc_dai_ops null_dai_ops = {
+};
+
 static void snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct platform_device *pdev = container_of(card->dev,
@@ -838,6 +841,11 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 			ac97 = 1;
 	}
 
+	for (i = 0; i < card->num_links; i++) {
+		if (!card->dai_link[i].codec_dai->ops)
+			card->dai_link[i].codec_dai->ops = &null_dai_ops;
+	}
+
 	/* If we have AC97 in the system then don't wait for the
 	 * codec.  This will need revisiting if we have to handle
 	 * systems with mixed AC97 and non-AC97 parts.  Only check for
@@ -2332,9 +2340,6 @@ static int snd_soc_unregister_card(struct snd_soc_card *card)
 	return 0;
 }
 
-static struct snd_soc_dai_ops null_dai_ops = {
-};
-
 /**
  * snd_soc_register_dai - Register a DAI with the ASoC core
  *
-- 
1.5.6.3
