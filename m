From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Don't bring the CODEC up to full
	power for supplies and biases
Date: Mon,  6 Jun 2011 14:41:46 +0100
Message-ID: <1307367706-1325-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307367706-1325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 679122449A
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 15:41:50 +0200 (CEST)
In-Reply-To: <1307367706-1325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

If the only widgets active within a CODEC are supplies and micbiases we
are not passing audio, we are probably just doing microphone detection.
This will not generally require either fully accurate reference voltages
or much power so

If this turns out to be unsuitable for some systems we can provide a
facility to override this decision.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0bbded4..6be6546 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1147,8 +1147,27 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 				power = w->power_check(w);
 			else
 				power = 1;
-			if (power)
-				w->dapm->target_bias_level = SND_SOC_BIAS_ON;
+
+			if (power) {
+				d = w->dapm;
+
+				/* Supplies and micbiases only bring
+				 * the context up to STANDBY as unless
+				 * something else is active and
+				 * passing audio they generally don't
+				 * require full power.
+				 */
+				switch (w->id) {
+				case snd_soc_dapm_supply:
+				case snd_soc_dapm_micbias:
+					if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
+						d->target_bias_level = SND_SOC_BIAS_STANDBY;
+					break;
+				default:
+					d->target_bias_level = SND_SOC_BIAS_ON;
+					break;
+				}
+			}
 
 			if (w->power == power)
 				continue;
-- 
1.7.5.3
