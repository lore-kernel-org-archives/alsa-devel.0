From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Fix mono controls after conversion
	to support full int masks
Date: Thu, 30 Oct 2008 12:37:08 +0000
Message-ID: <1225370230-7829-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081030123649.GA7682@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27580243C7
	for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 13:37:11 +0100 (CET)
In-Reply-To: <20081030123649.GA7682@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

When ASoC was converted to support full int width masks SOC_SINGLE_VALUE()
omitted the assignment of rshift, causing the control operatins to report
some mono controls as stereo. This happened to work some of the time due
to a confusion between shift and min in snd_soc_info_volsw().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    3 ++-
 sound/soc/soc-core.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a1e0357..5e01898 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -28,7 +28,8 @@
  */
 #define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .shift = xshift, .max = xmax, .invert = xinvert})
+	{.reg = xreg, .shift = xshift, .rshift = xshift, .max = xmax, \
+	.invert = xinvert})
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .max = xmax, .invert = xinvert})
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 462e635..a3adbf0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1462,7 +1462,7 @@ int snd_soc_info_volsw(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int max = mc->max;
-	unsigned int shift = mc->min;
+	unsigned int shift = mc->shift;
 	unsigned int rshift = mc->rshift;
 
 	if (max == 1)
-- 
1.5.6.5
