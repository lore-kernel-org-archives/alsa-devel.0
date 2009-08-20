From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 07/20] OMAP: McBSP: Rename thres sysfs symbols
Date: Thu, 20 Aug 2009 16:18:13 +0300
Message-ID: <1250774306-7581-7-git-send-email-eduardo.valentin__31510.7153299779$1250775243$gmane$org@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch renames the symbols that handles threshold
sysfs properties. This way we can add more sysfs properties
to them.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 0bbc912..ccaa9ae 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1077,24 +1077,24 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
-static const struct attribute *threshold_attrs[] = {
+static const struct attribute *additional_attrs[] = {
 	&dev_attr_max_tx_thres.attr,
 	&dev_attr_max_rx_thres.attr,
 	NULL,
 };
 
-static const struct attribute_group threshold_attr_group = {
-	.attrs = (struct attribute **)threshold_attrs,
+static const struct attribute_group additional_attr_group = {
+	.attrs = (struct attribute **)additional_attrs,
 };
 
-static inline int __devinit omap_thres_add(struct device *dev)
+static inline int __devinit omap_additional_add(struct device *dev)
 {
-	return sysfs_create_group(&dev->kobj, &threshold_attr_group);
+	return sysfs_create_group(&dev->kobj, &additional_attr_group);
 }
 
-static inline void __devexit omap_thres_remove(struct device *dev)
+static inline void __devexit omap_additional_remove(struct device *dev)
 {
-	sysfs_remove_group(&dev->kobj, &threshold_attr_group);
+	sysfs_remove_group(&dev->kobj, &additional_attr_group);
 }
 
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
@@ -1102,9 +1102,9 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 	if (cpu_is_omap34xx()) {
 		mcbsp->max_tx_thres = max_thres(mcbsp);
 		mcbsp->max_rx_thres = max_thres(mcbsp);
-		if (omap_thres_add(mcbsp->dev))
+		if (omap_additional_add(mcbsp->dev))
 			dev_warn(mcbsp->dev,
-				"Unable to create threshold controls\n");
+				"Unable to create additional controls\n");
 	} else {
 		mcbsp->max_tx_thres = -EINVAL;
 		mcbsp->max_rx_thres = -EINVAL;
@@ -1114,7 +1114,7 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 static inline void __devexit omap34xx_device_exit(struct omap_mcbsp *mcbsp)
 {
 	if (cpu_is_omap34xx())
-		omap_thres_remove(mcbsp->dev);
+		omap_additional_remove(mcbsp->dev);
 }
 #else
 static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp) {}
-- 
1.6.2.GIT

