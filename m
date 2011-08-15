From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] Blackfin: bf537: Stamp: Register ASoC
	EVAL-ADAU1373 board driver
Date: Mon, 15 Aug 2011 20:15:24 +0200
Message-ID: <1313432124-22591-4-git-send-email-lars@metafoo.de>
References: <1313432124-22591-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-020.synserver.de (smtp-out-020.synserver.de
	[212.40.185.20]) by alsa0.perex.cz (Postfix) with SMTP id 7D423246F8
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 20:17:43 +0200 (CEST)
In-Reply-To: <1313432124-22591-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, Mike Frysinger <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mike Frysinger <vapier@gentoo.org>
---
 arch/blackfin/mach-bf537/boards/stamp.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 4037043..6662c37 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -2674,6 +2674,13 @@ static struct platform_device iio_gpio_trigger = {
 };
 #endif
 
+#if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1373) || \
+	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1373_MODULE)
+static struct platform_device bf5xx_adau1373_device = {
+	.name = "bfin-eval-adau1373",
+};
+#endif
+
 #if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1701) || \
 	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1701_MODULE)
 static struct platform_device bf5xx_adau1701_device = {
@@ -2842,6 +2849,11 @@ static struct platform_device *stamp_devices[] __initdata = {
 	&iio_gpio_trigger,
 #endif
 
+#if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1373) || \
+	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1373_MODULE)
+	&bf5xx_adau1373_device,
+#endif
+
 #if defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1701) || \
 	defined(CONFIG_SND_SOC_BFIN_EVAL_ADAU1701_MODULE)
 	&bf5xx_adau1701_device,
-- 
1.7.2.5
