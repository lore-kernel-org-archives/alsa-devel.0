From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: pcm: Make constraints lists const
Date: Thu,  5 Jul 2012 12:15:01 +0100
Message-ID: <1341486901-3651-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAFA710450A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 13:15:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

They aren't modified by the core so the drivers can declare them const.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/pcm.h  |    2 +-
 sound/core/pcm_lib.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e7afcc9..c75c0d1 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -810,7 +810,7 @@ int snd_pcm_hw_constraint_integer(struct snd_pcm_runtime *runtime, snd_pcm_hw_pa
 int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime, 
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var,
-			       struct snd_pcm_hw_constraint_list *l);
+			       const struct snd_pcm_hw_constraint_list *l);
 int snd_pcm_hw_constraint_ratnums(struct snd_pcm_runtime *runtime, 
 				  unsigned int cond,
 				  snd_pcm_hw_param_t var,
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 8f312fa6..8659bc5 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1253,7 +1253,7 @@ int snd_pcm_hw_constraint_list(struct snd_pcm_runtime *runtime,
 			       struct snd_pcm_hw_constraint_list *l)
 {
 	return snd_pcm_hw_rule_add(runtime, cond, var,
-				   snd_pcm_hw_rule_list, l,
+				   snd_pcm_hw_rule_list, (void *)l,
 				   var, -1);
 }
 
-- 
1.7.10
