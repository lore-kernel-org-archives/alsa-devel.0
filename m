From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Add PXA2xx AC97 clocks to clock API
Date: Tue, 19 Feb 2008 16:04:15 +0000
Message-ID: <1203437058-7288-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080219160341.GA6387@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D51E10386D
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 17:04:20 +0100 (CET)
In-Reply-To: <20080219160341.GA6387@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric miao <eric.miao@marvell.com>, Russell King <rmk@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/pxa25x.c |    2 ++
 arch/arm/mach-pxa/pxa27x.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 599e53f..f379928 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -129,6 +129,8 @@ static struct clk pxa25x_clks[] = {
 	INIT_CKEN("SSPCLK", NSSP, 3686400, 0, &pxa25x_device_nssp.dev),
 	INIT_CKEN("SSPCLK", ASSP, 3686400, 0, &pxa25x_device_assp.dev),
 
+	INIT_CKEN("AC97CLK",     AC97,     24576000, 0, NULL),
+
 	/*
 	INIT_CKEN("PWMCLK",  PWM0, 3686400,  0, NULL),
 	INIT_CKEN("PWMCLK",  PWM0, 3686400,  0, NULL),
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 46a951c..c186bd1 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -157,6 +157,9 @@ static struct clk pxa27x_clks[] = {
 	INIT_CKEN("SSPCLK", SSP2, 13000000, 0, &pxa27x_device_ssp2.dev),
 	INIT_CKEN("SSPCLK", SSP3, 13000000, 0, &pxa27x_device_ssp3.dev),
 
+	INIT_CKEN("AC97CLK",     AC97,     24576000, 0, NULL),
+	INIT_CKEN("AC97CONFCLK", AC97CONF, 24576000, 0, NULL),
+
 	/*
 	INIT_CKEN("PWMCLK",  PWM0, 13000000, 0, NULL),
 	INIT_CKEN("MSLCLK",  MSL,  48000000, 0, NULL),
-- 
1.5.4.2
