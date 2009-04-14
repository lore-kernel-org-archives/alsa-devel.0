From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mx31ads: Depend on all the WM8350 core
	dependencies for WM1133-EV1 board
Date: Tue, 14 Apr 2009 13:33:00 +0100
Message-ID: <1239712393-6428-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49E4510384A
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:16 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
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

Otherwise we'd need massive ifdefs in the code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index d623558..194b842 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -19,6 +19,8 @@ config MACH_MX31ADS
 config MACH_MX31ADS_WM1133_EV1
 	bool "Support Wolfson Microelectronics 1133-EV1 module"
 	depends on MACH_MX31ADS
+	depends on MFD_WM8350_I2C
+	depends on REGULATOR_WM8350
 	select MFD_WM8350_CONFIG_MODE_0
 	select MFD_WM8352_CONFIG_MODE_0
 	help
-- 
1.6.2.2
