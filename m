From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: add fault detect recovery property to DT
	bindings
Date: Wed,  3 Oct 2018 21:32:34 +0200
Message-ID: <20181003193234.5049-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id DFCCA2677F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 21:32:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The driver already has support for setting the FDRB bit in the CONFA
register through platform data, but there was no property to set it
in the device-tree bindings.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/sound/st,sta32x.txt | 3 +++
 sound/soc/codecs/sta32x.c                             | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,sta32x.txt b/Documentation/devicetree/bindings/sound/st,sta32x.txt
index 255de3ae5b2f..ff4a685a4303 100644
--- a/Documentation/devicetree/bindings/sound/st,sta32x.txt
+++ b/Documentation/devicetree/bindings/sound/st,sta32x.txt
@@ -39,6 +39,9 @@ Optional properties:
   -  st,thermal-warning-recover:
 	If present, thermal warning recovery is enabled.
 
+  - st,fault-detect-recovery:
+	If present, fault detect recovery is enabled.
+
   -  st,thermal-warning-adjustment:
 	If present, thermal warning adjustment is enabled.
 
diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index d5035f2f2b2b..22de1593443c 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -1038,6 +1038,8 @@ static int sta32x_probe_dt(struct device *dev, struct sta32x_priv *sta32x)
 	of_property_read_u8(np, "st,ch3-output-mapping",
 			    &pdata->ch3_output_mapping);
 
+	if (of_get_property(np, "st,fault-detect-recovery", NULL))
+		pdata->fault_detect_recovery = 1;
 	if (of_get_property(np, "st,thermal-warning-recovery", NULL))
 		pdata->thermal_warning_recovery = 1;
 	if (of_get_property(np, "st,thermal-warning-adjustment", NULL))
-- 
2.17.1
