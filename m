From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] OMAP4: devices: Do not create dmic device if the dtb has been provided
Date: Fri,  2 Dec 2011 11:52:58 +0200
Message-ID: <1322819580-7424-4-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

If dtb is provided of will create the needed devices dynamically so there
is no need to create the platform device for DMIC here.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 35d5dff..d7ca473 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -344,6 +344,10 @@ static void omap_init_dmic(void)
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
 
+	/* If dtb is there, the devices will be created dynamically */
+	if (of_have_populated_dt())
+		return;
+
 	oh = omap_hwmod_lookup("dmic");
 	if (!oh) {
 		printk(KERN_ERR "Could not look up mcpdm hw_mod\n");
-- 
1.7.8.rc4

