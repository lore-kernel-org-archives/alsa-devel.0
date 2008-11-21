From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/10] ASoC: OMAP: Fix preprocessor filled DAI
	name in McBSP DAI
Date: Fri, 21 Nov 2008 14:48:31 +0000
Message-ID: <1227278913-25313-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081121144734.GA25238@rakim.wolfsonmicro.main>
	<1227278913-25313-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227278913-25313-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84B14244E8
	for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2008 15:48:36 +0100 (CET)
In-Reply-To: <1227278913-25313-7-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6013898..2eeb135 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -454,7 +454,7 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 
 #define OMAP_MCBSP_DAI_BUILDER(link_id)				\
 {								\
-	.name = "omap-mcbsp-dai-(link_id)",			\
+	.name = "omap-mcbsp-dai-"#link_id,			\
 	.id = (link_id),					\
 	.type = SND_SOC_DAI_I2S,				\
 	.playback = {						\
-- 
1.5.6.5
