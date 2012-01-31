From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Better support for idle_bias_off
	suspend ignores
Date: Tue, 31 Jan 2012 15:49:40 +0000
Message-ID: <1328024980-19949-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 187092438E
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 16:49:44 +0100 (CET)
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

If an idle_bias_off device is in any state other than off then it is still
active for some reason (typically a low power function such as accessory
detection). This wasn't an issue when the feature was implemented as we
always went to _ON for any active function, subsequent power improvements
have changed things.

With the modern way of doing things we should overhaul the infrastructure
to allow devices to explicitly take references for these functions but
that's a much more invasive change and will require driver updates to
deploy, this will bring the framework into line with the existing driver
set before we do that work.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 53fd9d2..09fa8a6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -567,6 +567,17 @@ int snd_soc_suspend(struct device *dev)
 		if (!codec->suspended && codec->driver->suspend) {
 			switch (codec->dapm.bias_level) {
 			case SND_SOC_BIAS_STANDBY:
+				/*
+				 * If the CODEC is capable of idle
+				 * bias off then being in STANDBY
+				 * means it's doing something,
+				 * otherwise fall through.
+				 */
+				if (codec->dapm.idle_bias_off) {
+					dev_dbg(codec->dev,
+						"idle_bias_off CODEC on over suspend\n");
+					break;
+				}
 			case SND_SOC_BIAS_OFF:
 				codec->driver->suspend(codec);
 				codec->suspended = 1;
-- 
1.7.9.rc1
