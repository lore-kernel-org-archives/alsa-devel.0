From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: dapm: check suspend state in
	dapm_dai_check_power()
Date: Mon,  3 Jun 2013 11:36:40 -0600
Message-ID: <1370281000-1120-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 022DB264F0D
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 19:36:49 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Currently, when the system enters suspend with audio playing, since the
DAI widgets are active, the associated CODEC is considered active, and
hence is not transition into a low-power bias state as the system
suspends. This likely causes audio failure after resume, since the CODEC
power has quite possibly been removed during suspend, and the bias level
transitions in the CODEC driver are needed to recover from this. At the
very least, this issue likely causes warnings in the kernel log due to
the CODEC being left on over the suspend transition.

To solve this, modify dapm_dai_check_power() not to consider DAI widgets
active if the system is entering suspend.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-dapm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 3507346..bad545a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1133,7 +1133,7 @@ static int dapm_dai_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	if (w->active)
-		return w->active;
+		return snd_soc_dapm_suspend_check(w);
 
 	return dapm_generic_check_power(w);
 }
-- 
1.7.10.4
