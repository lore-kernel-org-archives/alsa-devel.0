From: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 04/10] dma-engine: sun4i: Add support for
 Allwinner suniv F1C100s
Date: Mon,  3 Dec 2018 00:23:11 +0300
Message-ID: <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Reply-To: mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDI4VHO5SYLBBWU2SHQAKGQE2KUZCGA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1543782328.git.mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

DMA of Allwinner suniv F1C100s is similar to sun4i. It has 4 NDMA, 4
DDMA channels and endpoints are different. Also F1C100s has reset bit
for DMA in CCU. Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/dma/Kconfig     |  4 ++--
 drivers/dma/sun4i-dma.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index de511db..f8a65d2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -163,8 +163,8 @@ config DMA_SA11X0
 
 config DMA_SUN4I
 	tristate "Allwinner A10 DMA SoCs support"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
-	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
+	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index d267ff9..c0452c9 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -36,7 +36,11 @@
 #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
 #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
 
+#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)	((width) << 24)
+#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)	((width) << 8)
+
 #define SUN4I_MAX_BURST	8
+#define SUNIV_MAX_BURST	4
 
 /** Normal DMA register values **/
 
@@ -44,6 +48,9 @@
 #define SUN4I_NDMA_DRQ_TYPE_SDRAM		0x16
 #define SUN4I_NDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
 
+#define SUNIV_NDMA_DRQ_TYPE_SDRAM		0x11
+#define SUNIV_NDMA_DRQ_TYPE_LIMIT		(0x17 + 1)
+
 /** Normal DMA register layout **/
 
 /* Dedicated DMA source/destination address mode values */
@@ -57,6 +64,9 @@
 #define SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN	BIT(15)
 #define SUN4I_NDMA_CFG_SRC_NON_SECURE		BIT(6)
 
+#define SUNIV_NDMA_CFG_CONT_MODE		BIT(29)
+#define SUNIV_NDMA_CFG_WAIT_STATE(n)		((n) << 26)
+
 /** Dedicated DMA register values **/
 
 /* Dedicated DMA source/destination address mode values */
@@ -69,6 +79,9 @@
 #define SUN4I_DDMA_DRQ_TYPE_SDRAM		0x1
 #define SUN4I_DDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
 
+#define SUNIV_DDMA_DRQ_TYPE_SDRAM		0x1
+#define SUNIV_DDMA_DRQ_TYPE_LIMIT		(0x9 + 1)
+
 /** Dedicated DMA register layout **/
 
 /* Dedicated DMA configuration register layout */
@@ -122,6 +135,11 @@
 #define SUN4I_DMA_NR_MAX_VCHANS						\
 	(SUN4I_NDMA_NR_MAX_VCHANS + SUN4I_DDMA_NR_MAX_VCHANS)
 
+#define SUNIV_NDMA_NR_MAX_CHANNELS	4
+#define SUNIV_DDMA_NR_MAX_CHANNELS	4
+#define SUNIV_NDMA_NR_MAX_VCHANS	(24 * 2 - 1)
+#define SUNIV_DDMA_NR_MAX_VCHANS	10
+
 /* This set of SUN4I_DDMA timing parameters were found experimentally while
  * working with the SPI driver and seem to make it behave correctly */
 #define SUN4I_DDMA_MAGIC_SPI_PARAMETERS \
@@ -236,6 +254,16 @@ static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
 	*p_cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
 }
 
+static void set_dst_data_width_f1c100s(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUNIV_DMA_CFG_DST_DATA_WIDTH(data_width);
+}
+
+static void set_src_data_width_f1c100s(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUNIV_DMA_CFG_SRC_DATA_WIDTH(data_width);
+}
+
 static int convert_burst_a10(u32 maxburst)
 {
 	if (maxburst > 8)
@@ -245,6 +273,15 @@ static int convert_burst_a10(u32 maxburst)
 	return (maxburst >> 2);
 }
 
+static int convert_burst_f1c100s(u32 maxburst)
+{
+	if (maxburst > 4)
+		return -EINVAL;
+
+	/* 1 -> 0, 4 -> 1 */
+	return (maxburst >> 2);
+}
+
 static int convert_buswidth(enum dma_slave_buswidth addr_width)
 {
 	if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
@@ -1364,8 +1401,31 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.has_reset		= false,
 };
 
+static struct sun4i_dma_config suniv_f1c100s_dma_cfg = {
+	.ndma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS,
+	.ndma_nr_max_vchans	= SUNIV_NDMA_NR_MAX_VCHANS,
+
+	.ddma_nr_max_channels	= SUNIV_DDMA_NR_MAX_CHANNELS,
+	.ddma_nr_max_vchans	= SUNIV_DDMA_NR_MAX_VCHANS,
+
+	.dma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS +
+		SUNIV_DDMA_NR_MAX_CHANNELS,
+
+	.set_dst_data_width	= set_dst_data_width_f1c100s,
+	.set_src_data_width	= set_src_data_width_f1c100s,
+	.convert_burst		= convert_burst_f1c100s,
+
+	.ndma_drq_sdram		= SUNIV_NDMA_DRQ_TYPE_SDRAM,
+	.ddma_drq_sdram		= SUNIV_DDMA_DRQ_TYPE_SDRAM,
+
+	.max_burst		= SUNIV_MAX_BURST,
+	.has_reset		= true,
+};
+
 static const struct of_device_id sun4i_dma_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },
+	{ .compatible = "allwinner,suniv-f1c100s-dma",
+		.data = &suniv_f1c100s_dma_cfg },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_dma_match);
-- 
2.7.4
