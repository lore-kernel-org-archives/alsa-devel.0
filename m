From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Force all DAPM contexts into the same
	bias state
Date: Fri,  8 Apr 2011 09:44:54 +0900
Message-ID: <1302223494-27267-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C77182436B
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 02:44:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 0001-ASoC-Force-all-DAPM-contexts-into-the-same-bias-stat.patch@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently we allow all DAPM contexts to determine their own bias level.
While this should in general work in most situations and will deliver the
lowest possible power it causes problems for our integration with the
card bias level as we're calling the card bias level functions for each
DAPM context even though they're card wide but don't say which CODEC
we're calling for. Mitigate against this by forcing everything to be in
the same state.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b193a95..14dbba7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1101,6 +1101,15 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
+	/* Force all contexts in the card to the same bias state */
+	power = 0;
+	list_for_each_entry(d, &card->dapm_list, list)
+		if (d->dev_power)
+			power = 1;
+	list_for_each_entry(d, &card->dapm_list, list)
+		d->dev_power = power;
+
+
 	/* Run all the bias changes in parallel */
 	list_for_each_entry(d, &dapm->card->dapm_list, list)
 		async_schedule_domain(dapm_pre_sequence_async, d,
-- 
1.7.4.1
