From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Don't force card bias level to be
	updated
Date: Thu, 23 Aug 2012 18:25:51 +0100
Message-ID: <1345742751-19068-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A58242665D2
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 19:25:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Commit 412312 (ASoC: dapm: Make sure all dapm contexts are updated) means
that any DAPM context being updated will have the bias level automatically
set, including the card. We can't safely do this as the card callbacks are
called for each device context and so the management of the card bias is
more complex. Several multi-component cards rely on this behaviour.

Skip updates during the asynchronous run entirely. We should really do them
in the synchronous section but it's not 100% clear which values to pick as
the different DAPM contexts may have different bias levels.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c1fb6a6..53f69b5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -293,8 +293,9 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 								  level);
 		else
 			dapm->bias_level = level;
-	} else
+	} else if (!card || dapm != &card->dapm) {
 		dapm->bias_level = level;
+	}
 
 	if (ret != 0)
 		goto out;
-- 
1.7.10.4
