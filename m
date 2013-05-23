From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] MIPS: jz4740: Register jz4740 DMA device
Date: Thu, 23 May 2013 22:36:25 +0200
Message-ID: <1369341387-19147-5-git-send-email-lars@metafoo.de>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-103.synserver.de (smtp-out-103.synserver.de
 [212.40.185.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 95BCF26508D
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 22:34:09 +0200 (CEST)
In-Reply-To: <1369341387-19147-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Register a device for the newly added jz4740 dmaengine driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/include/asm/mach-jz4740/platform.h |  1 +
 arch/mips/jz4740/board-qi_lb60.c             |  1 +
 arch/mips/jz4740/platform.c                  | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/mips/include/asm/mach-jz4740/platform.h b/arch/mips/include/asm/mach-jz4740/platform.h
index 72cfebd..05988c2 100644
--- a/arch/mips/include/asm/mach-jz4740/platform.h
+++ b/arch/mips/include/asm/mach-jz4740/platform.h
@@ -32,6 +32,7 @@ extern struct platform_device jz4740_codec_device;
 extern struct platform_device jz4740_adc_device;
 extern struct platform_device jz4740_wdt_device;
 extern struct platform_device jz4740_pwm_device;
+extern struct platform_device jz4740_dma_device;
 
 void jz4740_serial_device_register(void);
 
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index be2b3de..8a5ec0e 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -438,6 +438,7 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_rtc_device,
 	&jz4740_adc_device,
 	&jz4740_pwm_device,
+	&jz4740_dma_device,
 	&qi_lb60_gpio_keys,
 	&qi_lb60_pwm_beeper,
 	&qi_lb60_charger_device,
diff --git a/arch/mips/jz4740/platform.c b/arch/mips/jz4740/platform.c
index e9348fd..35a9d8c 100644
--- a/arch/mips/jz4740/platform.c
+++ b/arch/mips/jz4740/platform.c
@@ -329,3 +329,24 @@ struct platform_device jz4740_pwm_device = {
 	.name = "jz4740-pwm",
 	.id   = -1,
 };
+
+/* DMA */
+static struct resource jz4740_dma_resources[] = {
+	{
+		.start	= JZ4740_DMAC_BASE_ADDR,
+		.end	= JZ4740_DMAC_BASE_ADDR + 0x400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= JZ4740_IRQ_DMAC,
+		.end	= JZ4740_IRQ_DMAC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device jz4740_dma_device = {
+	.name	= "jz4740-dma",
+	.id	= -1,
+	.num_resources = ARRAY_SIZE(jz4740_dma_resources),
+	.resource      = jz4740_dma_resources,
+};
-- 
1.8.2.1
