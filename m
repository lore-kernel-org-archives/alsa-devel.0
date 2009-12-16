From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix build of DA7210
Date: Wed, 16 Dec 2009 20:57:32 +0000
Message-ID: <1260997052-15510-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F25422449D
	for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2009 21:57:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Mark Brown <broonie@finisterre.wolfsonmicro.main>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@finisterre.wolfsonmicro.main>

DAC_VOICE_EN was not defined - looks to have been overly enthusiastically
deleted from a previous revision of the patch, pull the value from v1.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/da7210.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index 14f5f34..fbf3ab4 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -81,6 +81,9 @@
 #define DA7210_ADC_L_EN			(1 << 3)
 #define DA7210_ADC_R_EN			(1 << 7)
 
+/* DAC_HPF fields */
+#define DA7210_DAC_VOICE_EN		(1 << 7)
+
 /* DAC_SEL bit fields */
 #define DA7210_DAC_L_SRC_DAI_L		(4 << 0)
 #define DA7210_DAC_L_EN			(1 << 3)
-- 
1.6.5.4
