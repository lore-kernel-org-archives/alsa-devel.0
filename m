From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 06/18] ASoC: Allow use of resource from the
	platform device for S3C IISv2
Date: Tue,  5 May 2009 11:02:19 +0100
Message-ID: <1241517751-2634-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090505100123.GB2050@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09E0F24523
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 12:02:35 +0200 (CEST)
In-Reply-To: <20090505100123.GB2050@rakim.wolfsonmicro.main>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/s3c-i2s-v2.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 34142c8..cb85498 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -580,6 +580,24 @@ int s3c_i2sv2_probe(struct platform_device *pdev,
 	/* record our i2s structure for later use in the callbacks */
 	dai->private_data = i2s;
 
+	if (!base) {
+		struct resource *res = platform_get_resource(pdev,
+							     IORESOURCE_MEM,
+							     0);
+		if (!res) {
+			dev_err(dev, "Unable to get register resource\n");
+			return -ENXIO;
+		}
+
+		if (!request_mem_region(res->start, resource_size(res),
+					"s3c64xx-i2s-v4")) {
+			dev_err(dev, "Unable to request register region\n");
+			return -EBUSY;
+		}
+
+		base = res->start;
+	}
+
 	i2s->regs = ioremap(base, 0x100);
 	if (i2s->regs == NULL) {
 		dev_err(dev, "cannot ioremap registers\n");
-- 
1.6.2.4
