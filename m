From: miguel.aguilar@ridgerun.com
Subject: [PATCH 3/4] DaVinci: DM365: Add resources for voice
	codec and platform device for VCIF
Date: Tue, 22 Sep 2009 13:30:03 -0600
Message-ID: <1253647803-32633-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id BBF52103870
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 21:30:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
Cc: santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

1) Add the resources needed by the CQ0093 voice codec.
2) Add platform device for the voice codec interface.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/dm365.c              |   46 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/dm365.h |    5 +++
 arch/arm/mach-davinci/include/mach/mux.h   |    2 +
 3 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 2674438..80dc35b 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -605,6 +605,8 @@ INT_CFG(DM365,  INT_IMX1_DISABLE,    24,    1,    0,     false)
 INT_CFG(DM365,  INT_NSF_ENABLE,      25,    1,    1,     false)
 INT_CFG(DM365,  INT_NSF_DISABLE,     25,    1,    0,     false)
 
+EVT_CFG(DM365,	EVT2_VC_TX,          0,     1,    1,     false)
+EVT_CFG(DM365,	EVT3_VC_RX,          1,     1,    1,     false)
 EVT_CFG(DM365,	EVT2_ASP_TX,         0,     1,    0,     false)
 EVT_CFG(DM365,	EVT3_ASP_RX,         1,     1,    0,     false)
 #endif
@@ -835,6 +837,42 @@ static struct platform_device dm365_asp_device = {
 	.resource	= dm365_asp_resources,
 };
 
+static struct resource dm365_vcif_resources[] = {
+	/* The first are of Voice Codec registers before 0x80 belongs to VCIF */
+	{
+		.start	= DAVINCI_DM365_VC_BASE,
+		.end	= DAVINCI_DM365_VC_BASE + (SZ_1K>>4) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= DAVINCI_DMA_VC_TX,
+		.end	= DAVINCI_DMA_VC_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.start	= DAVINCI_DMA_VC_RX,
+		.end	= DAVINCI_DMA_VC_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device dm365_vcif_device = {
+	.name		= "voice_codec",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dm365_vcif_resources),
+	.resource	= dm365_vcif_resources,
+};
+
+struct resource cq93vc_resources[] = {
+	/* The base address for the Voice Codec registers is shifted by 0x80 */
+	{
+		.start	= DAVINCI_DM365_VC_BASE + 0x80,
+		.end	= DAVINCI_DM365_VC_BASE + 0x80 + (SZ_1K>>3) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+EXPORT_SYMBOL_GPL(cq93vc_resources);
+
 static struct map_desc dm365_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -950,6 +988,14 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
 	platform_device_register(&dm365_asp_device);
 }
 
+void __init dm365_init_vcif(struct snd_platform_data *pdata)
+{
+	davinci_cfg_reg(DM365_EVT2_VC_TX);
+	davinci_cfg_reg(DM365_EVT3_VC_RX);
+	dm365_vcif_device.dev.platform_data = pdata;
+	platform_device_register(&dm365_vcif_device);
+}
+
 void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 2291c0d..b78ec55 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -25,7 +25,12 @@
 #define DM365_EMAC_MDIO_OFFSET		(0x4000)
 #define DM365_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
+#define DAVINCI_DM365_VC_BASE		(0x01D0C000)
+#define DAVINCI_DMA_VC_TX		2
+#define DAVINCI_DMA_VC_RX		3
+
 void __init dm365_init(void);
 void __init dm365_init_asp(struct snd_platform_data *pdata);
+void __init dm365_init_vcif(struct snd_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM365_H */
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 7732832..b01b5c4 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -311,6 +311,8 @@ enum davinci_dm365_index {
 	DM365_INT_NSF_DISABLE,
 
 	/* EDMA event muxing */
+	DM365_EVT2_VC_TX,
+	DM365_EVT3_VC_RX,
 	DM365_EVT2_ASP_TX,
 	DM365_EVT3_ASP_RX,
 	DM365_EVT26_MMC0_RX,
-- 
1.6.0.4
