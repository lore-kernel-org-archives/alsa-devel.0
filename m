From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/2] ASoC: Blackfin AD1836/AD1938 machine
	drivers: require SPI master
Date: Tue,  6 Oct 2009 01:51:51 -0400
Message-ID: <1254808311-3594-2-git-send-email-vapier@gentoo.org>
References: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 31EED1038BB
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 07:52:04 +0200 (CEST)
In-Reply-To: <1254808311-3594-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Since these drivers rely on a SPI master and fail if the SPI functions
aren't present, make sure the Kconfig reflects this dependency.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index 97f1a25..b91e234 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -43,7 +43,7 @@ config SND_BF5XX_TDM
 
 config SND_BF5XX_SOC_AD1836
 	tristate "SoC AD1836 Audio support for BF5xx"
-	depends on SND_BF5XX_TDM
+	depends on SND_BF5XX_TDM && SPI_MASTER
 	select SND_BF5XX_SOC_TDM
 	select SND_SOC_AD1836
 	help
@@ -51,7 +51,7 @@ config SND_BF5XX_SOC_AD1836
 
 config SND_BF5XX_SOC_AD1938
 	tristate "SoC AD1938 Audio support for Blackfin"
-	depends on SND_BF5XX_TDM
+	depends on SND_BF5XX_TDM && SPI_MASTER
 	select SND_BF5XX_SOC_TDM
 	select SND_SOC_AD1938
 	help
-- 
1.6.5.rc2
