From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/5] ALSA: pcm: snd_interval_step: drop the min
	parameter
Date: Sun, 07 Sep 2014 21:43:07 +0200
Message-ID: <540CB54B.8080701@ladisch.de>
References: <540CB520.50909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E5A4F261622
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 21:42:18 +0200 (CEST)
In-Reply-To: <540CB520.50909@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The min parameter was not used by any caller.  And if it were used,
underflows in the calculations could lead to incorrect results.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/core/pcm_lib.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 9acc77e..6fd5e1c 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1113,16 +1113,16 @@ int snd_interval_list(struct snd_interval *i, unsigned int count,

 EXPORT_SYMBOL(snd_interval_list);

-static int snd_interval_step(struct snd_interval *i, unsigned int min, unsigned int step)
+static int snd_interval_step(struct snd_interval *i, unsigned int step)
 {
 	unsigned int n;
 	int changed = 0;
-	n = (i->min - min) % step;
+	n = i->min % step;
 	if (n != 0 || i->openmin) {
 		i->min += step - n;
 		changed = 1;
 	}
-	n = (i->max - min) % step;
+	n = i->max % step;
 	if (n != 0 || i->openmax) {
 		i->max -= n;
 		changed = 1;
@@ -1427,7 +1427,7 @@ static int snd_pcm_hw_rule_step(struct snd_pcm_hw_params *params,
 				struct snd_pcm_hw_rule *rule)
 {
 	unsigned long step = (unsigned long) rule->private;
-	return snd_interval_step(hw_param_interval(params, rule->var), 0, step);
+	return snd_interval_step(hw_param_interval(params, rule->var), step);
 }

 /**
