From: Marc Zyngier <maz@misterjones.org>
Subject: [PATCH] Fix pxa2xx-ac97-lib.c compilation
Date: Tue, 14 Oct 2008 10:58:43 +0200
Message-ID: <20081014105843.5d81c024@not-of-this-earth.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inca-roads.misterjones.org (inca-roads.misterjones.org
	[213.251.177.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 543402444A
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 10:59:12 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

[This patch was posted to linux-arm-kernel ML yesterday, and reposted
here in the hope that it will be merged soon]

The last ALSA merge broke pxa2xx-ac97-lib.c, as it brought back
references to cpu_is_pxa21x that Eric Miao removed in commit
0ffcbfd54ea81ca24c0749f55ca4fcf3e2bdc23e:

	[ARM] pxa: make cpu_is_pxa2* macros more consistent

This patch gets rid of those references, and only keeps cpu_is_pxa25x().

Signed-off-by: Marc Zyngier <maz@misterjones.org>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Eric Miao <eric.miao@marvell.com>

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 99026df..34c1d94 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -50,7 +50,7 @@ unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
-	if ((cpu_is_pxa21x() || cpu_is_pxa25x()) && reg == AC97_GPIO_STATUS)
+	if (cpu_is_pxa25x() && reg == AC97_GPIO_STATUS)
 		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
 	else
 		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
@@ -90,7 +90,7 @@ void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec space */
-	if ((cpu_is_pxa21x() || cpu_is_pxa25x()) && reg == AC97_GPIO_STATUS)
+	if (cpu_is_pxa25x() && reg == AC97_GPIO_STATUS)
 		reg_addr = ac97->num ? &SMC_REG_BASE : &PMC_REG_BASE;
 	else
 		reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
@@ -200,7 +200,7 @@ static inline void pxa_ac97_cold_pxa3xx(void)
 bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 {
 #ifdef CONFIG_PXA25x
-	if (cpu_is_pxa21x() || cpu_is_pxa25x())
+	if (cpu_is_pxa25x())
 		pxa_ac97_warm_pxa25x();
 	else
 #endif
@@ -230,7 +230,7 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_warm_reset);
 bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 {
 #ifdef CONFIG_PXA25x
-	if (cpu_is_pxa21x() || cpu_is_pxa25x())
+	if (cpu_is_pxa25x())
 		pxa_ac97_cold_pxa25x();
 	else
 #endif
@@ -301,7 +301,7 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_hw_suspend);
 
 int pxa2xx_ac97_hw_resume(void)
 {
-	if (cpu_is_pxa21x() || cpu_is_pxa25x() || cpu_is_pxa27x()) {
+	if (cpu_is_pxa25x() || cpu_is_pxa27x()) {
 		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
 		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
 		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
@@ -325,7 +325,7 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 	if (ret < 0)
 		goto err;
 
-	if (cpu_is_pxa21x() || cpu_is_pxa25x() || cpu_is_pxa27x()) {
+	if (cpu_is_pxa25x() || cpu_is_pxa27x()) {
 		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
 		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
 		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);

-- 
A rat a day keeps the plague away.
