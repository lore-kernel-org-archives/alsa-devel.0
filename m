From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 15/16] ASoC: Ux500: Activate the Ux500
	ASoC-driver
Date: Tue, 13 Mar 2012 16:11:42 +0100
Message-ID: <1331651503-16917-16-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog106.obsmtp.com (eu1sys200aog106.obsmtp.com
	[207.126.144.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 018B4104350
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:29 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch activates the Ux500 ASoC-driver in the
ASoC Kconfig/Makefile.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 sound/soc/Kconfig  |    1 +
 sound/soc/Makefile |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 35e662d..10c66dc 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -45,6 +45,7 @@ source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
+source "sound/soc/ux500/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 9ea8ac8..df87058 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,6 +1,8 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o soc-jack.o soc-cache.o soc-utils.o
 snd-soc-core-objs += soc-pcm.o soc-io.o
 
+CFLAGS_soc-core.o := -DDEBUG
+
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
 obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= atmel/
@@ -22,3 +24,4 @@ obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
+obj-$(CONFIG_SND_SOC)	+= ux500/
-- 
1.7.8.3
