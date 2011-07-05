From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/5] MFD: twl6040: Use resource to provide
	irq number for slaves
Date: Tue, 5 Jul 2011 16:49:31 +0300
Message-ID: <1309873775-17927-2-git-send-email-peter.ujfalusi@ti.com>
References: <1309873775-17927-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id CD30324141
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 15:49:43 +0200 (CEST)
In-Reply-To: <1309873775-17927-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Provide the irq number for slaves via resource on the
platform device.
The irq number configuration is done in the twl6040-core
at probe time, so machine drivers do not need to be
modified.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040-core.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
index cfaedb5..471f489 100644
--- a/drivers/mfd/twl6040-core.c
+++ b/drivers/mfd/twl6040-core.c
@@ -435,6 +435,18 @@ unsigned int twl6040_get_sysclk(struct twl6040 *twl6040)
 }
 EXPORT_SYMBOL(twl6040_get_sysclk);
 
+static struct resource twl6040_vibra_rsrc[] = {
+	{
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static struct resource twl6040_codec_rsrc[] = {
+	{
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
 static int __devinit twl6040_probe(struct platform_device *pdev)
 {
 	struct twl4030_audio_data *pdata = pdev->dev.platform_data;
@@ -499,16 +511,29 @@ static int __devinit twl6040_probe(struct platform_device *pdev)
 	twl6040_set_bits(twl6040, TWL6040_REG_ACCCTL, TWL6040_I2CSEL);
 
 	if (pdata->codec) {
+		int irq = twl6040->irq_base + TWL6040_IRQ_PLUG;
+
 		cell = &twl6040->cells[children];
 		cell->name = "twl6040-codec";
+		twl6040_codec_rsrc[0].start = irq;
+		twl6040_codec_rsrc[0].end = irq;
+		cell->resources = twl6040_codec_rsrc;
+		cell->num_resources = ARRAY_SIZE(twl6040_codec_rsrc);
 		cell->platform_data = pdata->codec;
 		cell->pdata_size = sizeof(*pdata->codec);
 		children++;
 	}
 
 	if (pdata->vibra) {
+		int irq = twl6040->irq_base + TWL6040_IRQ_VIB;
+
 		cell = &twl6040->cells[children];
 		cell->name = "twl6040-vibra";
+		twl6040_vibra_rsrc[0].start = irq;
+		twl6040_vibra_rsrc[0].end = irq;
+		cell->resources = twl6040_vibra_rsrc;
+		cell->num_resources = ARRAY_SIZE(twl6040_vibra_rsrc);
+
 		cell->platform_data = pdata->vibra;
 		cell->pdata_size = sizeof(*pdata->vibra);
 		children++;
-- 
1.7.6
