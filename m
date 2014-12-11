From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 2/2] misc: sram: switch to ioremap_wc from ioremap
Date: Thu, 11 Dec 2014 08:28:46 +0530
Message-ID: <1418266726-12004-2-git-send-email-a.kesavan@samsung.com>
References: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, Will.Deacon@arm.com, heiko@sntech.de, Li.Xiubo@freescale.com, shc_work@mail.ru, p.zabel@pengutronix.de, nicoleotsuka@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, robh+dt@kernel.org, grant.likely@linaro.org, linux-kernel@vger.kernel.org, corbet@lwn.net
Cc: padma.v@samsung.com, alsa-devel@alsa-project.org, shawn.guo@freescale.com, bcousson@baylibre.com, tony@atomide.com, kernel@pengutronix.de, kgene@kernel.org, kesavan.abhilash@gmail.com, pawel.moll@arm.com
List-Id: alsa-devel@alsa-project.org

Currently, the SRAM allocator returns device memory via ioremap.
This causes issues on ARM64 when the internal SoC SRAM allocated by
the generic sram driver is used for audio playback. The destination
buffer address (which is ioremapped SRAM) is not 64-bit aligned for
certain streams (e.g. 44.1k sampling rate). In such cases we get
unhandled alignment faults. Use ioremap_wc in place of ioremap which
gives us normal non-cacheable memory instead of device memory.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
This is based on the discussion about the crash here:
http://www.spinics.net/lists/arm-kernel/msg384647.html

 drivers/misc/sram.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 21181fa..15b4d4e 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -69,12 +69,23 @@ static int sram_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&reserve_list);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	virt_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(virt_base))
-		return PTR_ERR(virt_base);
+	if (!res) {
+		dev_err(&pdev->dev, "found no memory resource\n");
+		return -EINVAL;
+	}
 
 	size = resource_size(res);
 
+	if (!devm_request_mem_region(&pdev->dev,
+			res->start, size, pdev->name)) {
+		dev_err(&pdev->dev, "could not request region for resource\n");
+		return -EBUSY;
+	}
+
+	virt_base = devm_ioremap_wc(&pdev->dev, res->start, size);
+	if (IS_ERR(virt_base))
+		return PTR_ERR(virt_base);
+
 	sram = devm_kzalloc(&pdev->dev, sizeof(*sram), GFP_KERNEL);
 	if (!sram)
 		return -ENOMEM;
-- 
1.7.9.5
