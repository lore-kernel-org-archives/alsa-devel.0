From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Correct regulator bypass error
	messages
Date: Tue, 18 Feb 2014 16:05:27 +0000
Message-ID: <1392739527-27392-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFA0E2651D2
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 17:13:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The error messages for bypassing/unbypassing a regulator appear to be
swapped round, this patch corrects these.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c2d751..7e10be8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1219,7 +1219,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			ret = regulator_allow_bypass(w->regulator, false);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
-					 "ASoC: Failed to bypass %s: %d\n",
+					 "ASoC: Failed to unbypass %s: %d\n",
 					 w->name, ret);
 		}
 
@@ -1229,7 +1229,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			ret = regulator_allow_bypass(w->regulator, true);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
-					 "ASoC: Failed to unbypass %s: %d\n",
+					 "ASoC: Failed to bypass %s: %d\n",
 					 w->name, ret);
 		}
 
@@ -3249,7 +3249,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			ret = regulator_allow_bypass(w->regulator, true);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
-					 "ASoC: Failed to unbypass %s: %d\n",
+					 "ASoC: Failed to bypass %s: %d\n",
 					 w->name, ret);
 		}
 		break;
-- 
1.7.2.5
