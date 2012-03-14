From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: pcm: Constify the list in
	snd_pcm_hw_constraint_list
Date: Wed, 14 Mar 2012 19:48:43 +0000
Message-ID: <1331754523-13173-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4575103B2F
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 20:48:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allows the constraint lists to be declared const by drivers which seems
reasonable; there's plenty of other constification we could do if we were
being complete but this was easy and quick.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/pcm.h  |    5 +++--
 sound/core/pcm_lib.c |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 1d58d79..0d11128 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -264,7 +264,7 @@ struct snd_pcm_hw_constraint_ratdens {
 
 struct snd_pcm_hw_constraint_list {
 	unsigned int count;
-	unsigned int *list;
+	const unsigned int *list;
 	unsigned int mask;
 };
 
@@ -785,7 +785,8 @@ void snd_interval_muldivk(const struct snd_interval *a, const struct snd_interva
 			  unsigned int k, struct snd_interval *c);
 void snd_interval_mulkdiv(const struct snd_interval *a, unsigned int k,
 			  const struct snd_interval *b, struct snd_interval *c);
-int snd_interval_list(struct snd_interval *i, unsigned int count, unsigned int *list, unsigned int mask);
+int snd_interval_list(struct snd_interval *i, unsigned int count,
+		      const unsigned int *list, unsigned int mask);
 int snd_interval_ratnum(struct snd_interval *i,
 			unsigned int rats_count, struct snd_ratnum *rats,
 			unsigned int *nump, unsigned int *denp);
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 3420bd3..4d18941 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1029,7 +1029,8 @@ static int snd_interval_ratden(struct snd_interval *i,
  *
  * Returns non-zero if the value is changed, zero if not changed.
  */
-int snd_interval_list(struct snd_interval *i, unsigned int count, unsigned int *list, unsigned int mask)
+int snd_interval_list(struct snd_interval *i, unsigned int count,
+		      const unsigned int *list, unsigned int mask)
 {
         unsigned int k;
 	struct snd_interval list_range;
-- 
1.7.9.1
