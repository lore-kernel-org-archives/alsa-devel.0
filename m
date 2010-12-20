From: Jassi@alsa-project.org, "Brar <jassisinghbrar"@gmail.com
Subject: [PATCH 05/10] ASoC: SMDK6450: Enable I2S device
Date: Mon, 20 Dec 2010 11:05:51 +0900
Message-ID: <1292810751-30064-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 711541037F2
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 03:27:07 +0100 (CET)
In-Reply-To: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/samsung/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index be09a22..c8aa73e 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -62,7 +62,7 @@ config ASOC_SAMSUNG_JIVE_WM8750
 
 config ASOC_SAMSUNG_SMDK_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK"
-	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440)
+	depends on ASOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDK6440 || MACH_SMDK6450)
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
-- 
1.6.2.5
