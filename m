From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add post-CODEC bias level callback for
	machine driver
Date: Sat,  4 Dec 2010 12:49:17 +0000
Message-ID: <1291466957-30982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B71802452B
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2010 13:49:32 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently the machine driver can only do bias level configuration before
the CODEC bias level is brought up. This means that the machine cannot do
any configuration which depends on the CODEC bias level being maintained.
Provide a post-CODEC callback which allows the machine driver to do things
like enable the FLL on a CODEC which is brought down to BIAS_OFF when idle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-dapm.c |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0eea08e..4abc2f8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -632,6 +632,8 @@ struct snd_soc_card {
 	/* callbacks */
 	int (*set_bias_level)(struct snd_soc_card *,
 			      enum snd_soc_bias_level level);
+	int (*set_bias_level_post)(struct snd_soc_card *,
+				   enum snd_soc_bias_level level);
 
 	long pmdown_time;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6a29d59..9af2d8a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -162,6 +162,10 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_card *card,
 		else
 			dapm->bias_level = level;
 	}
+	if (ret == 0) {
+		if (card && card->set_bias_level_post)
+			ret = card->set_bias_level_post(card, level);
+	}
 
 	trace_snd_soc_bias_level_done(card, level);
 
-- 
1.7.2.3
