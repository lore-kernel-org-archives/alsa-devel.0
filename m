From: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] ASoC: rockchip: add bindings for spdif controller
Date: Fri,  4 Mar 2016 18:31:54 +0800
Message-ID: <1457087514-1837-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

this patch add compatible for rk3366/rk3368/rk3399 spdif,
these three spdifs share the same type.

Signed-off-by: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 Documentation/devicetree/bindings/sound/rockchip-spdif.txt |  8 ++++++--
 sound/soc/rockchip/rockchip_spdif.c                        | 13 ++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
index e64dbde..1104642 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.txt
@@ -7,8 +7,12 @@ a fibre cable.
 Required properties:
 
 - compatible: should be one of the following:
-   - "rockchip,rk3288-spdif", "rockchip,rk3188-spdif" or
-     "rockchip,rk3066-spdif"
+   - "rockchip,rk3066-spdif"
+   - "rockchip,rk3188-spdif"
+   - "rockchip,rk3288-spdif"
+   - "rockchip,rk3366-spdif"
+   - "rockchip,rk3368-spdif"
+   - "rockchip,rk3399-spdif"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the SPDIF interrupt.
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 5a806da..c589f6f 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -28,6 +28,7 @@ enum rk_spdif_type {
 	RK_SPDIF_RK3066,
 	RK_SPDIF_RK3188,
 	RK_SPDIF_RK3288,
+	RK_SPDIF_RK3366,
 };
 
 #define RK3288_GRF_SOC_CON2 0x24c
@@ -45,11 +46,17 @@ struct rk_spdif_dev {
 
 static const struct of_device_id rk_spdif_match[] = {
 	{ .compatible = "rockchip,rk3066-spdif",
-	  .data = (void *) RK_SPDIF_RK3066 },
+	  .data = (void *)RK_SPDIF_RK3066 },
 	{ .compatible = "rockchip,rk3188-spdif",
-	  .data = (void *) RK_SPDIF_RK3188 },
+	  .data = (void *)RK_SPDIF_RK3188 },
 	{ .compatible = "rockchip,rk3288-spdif",
-	  .data = (void *) RK_SPDIF_RK3288 },
+	  .data = (void *)RK_SPDIF_RK3288 },
+	{ .compatible = "rockchip,rk3366-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
+	{ .compatible = "rockchip,rk3368-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
+	{ .compatible = "rockchip,rk3399-spdif",
+	  .data = (void *)RK_SPDIF_RK3366 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rk_spdif_match);
-- 
1.9.1
