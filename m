From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Fix dependency on AC97_BUS
Date: Tue, 16 Sep 2008 13:49:30 +0100
Message-ID: <1221569372-15516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080916124851.GA15445@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC51D2440F
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Sep 2008 14:49:33 +0200 (CEST)
In-Reply-To: <20080916124851.GA15445@rakim.wolfsonmicro.main>
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

When built with AC97 support the ASoC core depends on AC97_BUS so force
it to be available Kconfig.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 32ac940..4dfda66 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -5,6 +5,7 @@
 menuconfig SND_SOC
 	tristate "ALSA for SoC audio support"
 	select SND_PCM
+	select AC97_BUS if SND_SOC_AC97_BUS
 	---help---
 
 	  If you want ASoC support, you should say Y here and also to the
-- 
1.5.6.5
