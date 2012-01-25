From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Ignore isolated signal generators
	for power purposes
Date: Wed, 25 Jan 2012 21:28:30 +0000
Message-ID: <1327526910-2072-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CA822433C
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2012 22:28:32 +0100 (CET)
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

A signal generator has no power control itself and so shouldn't cause a
power up of the device.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ff9939c..15c0821 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1435,9 +1435,13 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			/* Supplies and micbiases only bring the
 			 * context up to STANDBY as unless something
 			 * else is active and passing audio they
-			 * generally don't require full power.
+			 * generally don't require full power.  Signal
+			 * generators are virtual pins and have no
+			 * power impact themselves.
 			 */
 			switch (w->id) {
+			case snd_soc_dapm_siggen:
+				break;
 			case snd_soc_dapm_supply:
 			case snd_soc_dapm_regulator_supply:
 			case snd_soc_dapm_micbias:
-- 
1.7.9.rc1
