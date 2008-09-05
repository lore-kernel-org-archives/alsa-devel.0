From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 14/14] ASoC: Blackfin: Include Blackfin
	architecture support in build
Date: Fri,  5 Sep 2008 15:35:22 +0100
Message-ID: <1220625322-27982-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080905143504.GA27793@rakim.wolfsonmicro.main>
	<1220625322-27982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-11-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-12-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-13-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 79E4A103867
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 16:35:27 +0200 (CEST)
In-Reply-To: <1220625322-27982-13-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/Kconfig  |    1 +
 sound/soc/Makefile |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index f743530..32ac940 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -31,6 +31,7 @@ source "sound/soc/sh/Kconfig"
 source "sound/soc/fsl/Kconfig"
 source "sound/soc/davinci/Kconfig"
 source "sound/soc/omap/Kconfig"
+source "sound/soc/blackfin/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 933a66d..d849349 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -2,4 +2,4 @@ snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/ at32/ at91/ pxa/ s3c24xx/ sh/ fsl/ davinci/
-obj-$(CONFIG_SND_SOC)	+= omap/ au1x/
+obj-$(CONFIG_SND_SOC)	+= omap/ au1x/ blackfin/
-- 
1.5.6.5
