From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Don't force bias on ground referenced
	devices
Date: Thu, 22 Sep 2011 11:12:14 +0100
Message-ID: <1316686334-5058-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2D2D103B01
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 12:12:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Currently we force all devices in the system to be at the same bias level.
This is due to concerns about power or pop/click impacts from either
ramping VMID or mismatching VMID on the analogue I/O lines between
connected devices but does mean we power devices up more often than we
really need to.

If a device flags idle_bias_off this will usually mean that it's either
all digital or ground referenced (in which case the idle and powered bias
levels are identical) so this concern does not apply and we can save some
power by leaving it off when not needed itself.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6cac045..2bde6b0c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1319,13 +1319,16 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		}
 	}
 
-	/* Force all contexts in the card to the same bias state */
+	/* Force all contexts in the card to the same bias state if
+	 * they're not ground referenced.
+	 */
 	bias = SND_SOC_BIAS_OFF;
 	list_for_each_entry(d, &card->dapm_list, list)
 		if (d->target_bias_level > bias)
 			bias = d->target_bias_level;
 	list_for_each_entry(d, &card->dapm_list, list)
-		d->target_bias_level = bias;
+		if (!d->idle_bias_off)
+			d->target_bias_level = bias;
 
 	trace_snd_soc_dapm_walk_done(card);
 
-- 
1.7.6.3
