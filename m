From: miguel.aguilar@ridgerun.com
Subject: [PATCH 4/5] DaVinci: DM365: Voice codec support for
	the DM365 SoC
Date: Thu, 21 Jan 2010 11:41:51 -0600
Message-ID: <1264095711-1385-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 86D8E103879
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 18:41:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, clark.becker@ridgerun.com, nsekhar@ti.com, broonie@opensource.wolfsonmicro.com, diego.dompe@ridgerun.com, nsnehaprabha@ti.com, todd.fischer@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This patch adds the generic Voice Codec support for the DM365 based
platforms.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/dm365.c              |   37 +++++++++++++++++++++++++++-
 arch/arm/mach-davinci/include/mach/dm365.h |    5 ++++
 arch/arm/mach-davinci/include/mach/mux.h   |    2 +
 3 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index c63afc0..b5345d5 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -455,7 +455,7 @@ static struct clk_lookup dm365_clks[] = {
 	CLK(NULL, "timer3", &timer3_clk),
 	CLK(NULL, "usb", &usb_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("voice_codec", NULL, &voicecodec_clk),
+	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
 	CLK("davinci-asp.0", NULL, &asp0_clk),
 	CLK(NULL, "rto", &rto_clk),
 	CLK(NULL, "mjcp", &mjcp_clk),
@@ -606,6 +606,8 @@ INT_CFG(DM365,  INT_NSF_DISABLE,     25,    1,    0,     false)
 
 EVT_CFG(DM365,	EVT2_ASP_TX,         0,     1,    0,     false)
 EVT_CFG(DM365,	EVT3_ASP_RX,         1,     1,    0,     false)
+EVT_CFG(DM365,	EVT2_VC_TX,          0,     1,    1,     false)
+EVT_CFG(DM365,	EVT3_VC_RX,          1,     1,    1,     false)
 #endif
 };
 
@@ -835,6 +837,31 @@ static struct platform_device dm365_asp_device = {
 	.resource	= dm365_asp_resources,
 };
 
+static struct resource dm365_vc_resources[] = {
+	{
+		.start	= DAVINCI_DM365_VC_BASE,
+		.end	= DAVINCI_DM365_VC_BASE + SZ_1K - 1,
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
+static struct platform_device dm365_vc_device = {
+	.name		= "davinci_voicecodec",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dm365_vc_resources),
+	.resource	= dm365_vc_resources,
+};
+
 static struct resource dm365_rtc_resources[] = {
 	{
 		.start = DM365_RTC_BASE,
@@ -991,6 +1018,14 @@ void __init dm365_init_asp(struct snd_platform_data *pdata)
 	platform_device_register(&dm365_asp_device);
 }
 
+void __init dm365_init_vc(struct snd_platform_data *pdata)
+{
+	davinci_cfg_reg(DM365_EVT2_VC_TX);
+	davinci_cfg_reg(DM365_EVT3_VC_RX);
+	dm365_vc_device.dev.platform_data = pdata;
+	platform_device_register(&dm365_vc_device);
+}
+
 void __init dm365_init_ks(struct davinci_ks_platform_data *pdata)
 {
 	dm365_ks_device.dev.platform_data = pdata;
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 3c07a88..57e51eb 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -31,8 +31,13 @@
 
 #define DM365_RTC_BASE			(0x01C69000)
 
+#define DAVINCI_DM365_VC_BASE		(0x01D0C000)
+#define DAVINCI_DMA_VC_TX		2
+#define DAVINCI_DMA_VC_RX		3
+
 void __init dm365_init(void);
 void __init dm365_init_asp(struct snd_platform_data *pdata);
+void __init dm365_init_vc(struct snd_platform_data *pdata);
 void __init dm365_init_ks(struct davinci_ks_platform_data *pdata);
 void __init dm365_init_rtc(void);
 
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 137bfba..2a68c1d 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -327,6 +327,8 @@ enum davinci_dm365_index {
 	/* EDMA event muxing */
 	DM365_EVT2_ASP_TX,
 	DM365_EVT3_ASP_RX,
+	DM365_EVT2_VC_TX,
+	DM365_EVT3_VC_RX,
 	DM365_EVT26_MMC0_RX,
 };
 
-- 
1.6.0.4
