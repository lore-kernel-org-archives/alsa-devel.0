From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Fix early event callback list iteration
Date: Thu, 23 May 2013 00:12:53 +0200
Message-ID: <1369260773-4060-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-050.synserver.de (smtp-out-050.synserver.de
 [212.40.185.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A6BCB2616A6
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 00:10:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The power_list field is used when adding a widget to a power sequence list. Use
the same field when iterating the list using list_for_each_entry, otherwise
we'll see undefined behavior.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 071579b..3507346 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1738,11 +1738,11 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 					&async_domain);
 	async_synchronize_full_domain(&async_domain);
 
-	list_for_each_entry(w, &down_list, list) {
+	list_for_each_entry(w, &down_list, power_list) {
 		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_WILL_PMD);
 	}
 
-	list_for_each_entry(w, &up_list, list) {
+	list_for_each_entry(w, &up_list, power_list) {
 		dapm_seq_check_event(dapm, w, SND_SOC_DAPM_WILL_PMU);
 	}
 
-- 
1.8.2.1
