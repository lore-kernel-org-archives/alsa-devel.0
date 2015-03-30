From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/8] ASoC: Remove suspend_bias_level from DAPM
	context struct
Date: Mon, 30 Mar 2015 21:04:50 +0200
Message-ID: <1427742293-8588-6-git-send-email-lars@metafoo.de>
References: <1427742293-8588-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-247.synserver.de (smtp-out-247.synserver.de
 [212.40.185.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AFB82605BB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 21:04:54 +0200 (CEST)
In-Reply-To: <1427742293-8588-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The only two users of the suspend_bias_level field were two rather old
drivers which weren't exactly doing things by the book. Those drivers have
been updated and field is now unused and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  1 -
 sound/soc/soc-core.c     | 10 ++--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 0be5816..2e5f0ce 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -588,7 +588,6 @@ struct snd_soc_dapm_update {
 /* DAPM context */
 struct snd_soc_dapm_context {
 	enum snd_soc_bias_level bias_level;
-	enum snd_soc_bias_level suspend_bias_level;
 	struct delayed_work delayed_work;
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 	/* Go to BIAS_OFF in suspend if the DAPM context is idle */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 76bfff2..2801578 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -595,15 +595,9 @@ int snd_soc_suspend(struct device *dev)
 			cpu_dai->driver->suspend(cpu_dai);
 	}
 
-	/* close any waiting streams and save state */
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai **codec_dais = card->rtd[i].codec_dais;
+	/* close any waiting streams */
+	for (i = 0; i < card->num_rtd; i++)
 		flush_delayed_work(&card->rtd[i].delayed_work);
-		for (j = 0; j < card->rtd[i].num_codecs; j++) {
-			codec_dais[j]->codec->dapm.suspend_bias_level =
-					codec_dais[j]->codec->dapm.bias_level;
-		}
-	}
 
 	for (i = 0; i < card->num_rtd; i++) {
 
-- 
1.8.0
