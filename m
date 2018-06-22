From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 2/2] ALSA: ac97: add codecs devicetree
	binding
Date: Fri, 22 Jun 2018 21:28:34 +0200
Message-ID: <20180622192834.7797-2-robert.jarzmik@free.fr>
References: <20180622192834.7797-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr
 [80.12.242.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 8090B266D4C
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 21:29:48 +0200 (CEST)
In-Reply-To: <20180622192834.7797-1-robert.jarzmik@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add a devicetree binding for codecs. This is especially useful if the
AC97 bitclk clock is provided by the codec, as it has to be described in
the devicetree description for the ac97 bus code to aquire it.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: handle of_put_node() in codec removal
---
 sound/ac97/bus.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 31f858eceffc..7a0dfca03a57 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -13,6 +13,7 @@
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -68,6 +69,27 @@ ac97_codec_find(struct ac97_controller *ac97_ctrl, unsigned int codec_num)
 	return ac97_ctrl->codecs[codec_num];
 }
 
+static struct device_node *
+ac97_of_get_child_device(struct ac97_controller *ac97_ctrl, int idx,
+			 unsigned int vendor_id)
+{
+	struct device_node *node;
+	u32 reg;
+	char compat[] = "ac97,0000,0000";
+
+	snprintf(compat, sizeof(compat), "ac97,%04x,%04x",
+		 vendor_id >> 16, vendor_id & 0xffff);
+
+	for_each_child_of_node(ac97_ctrl->parent->of_node, node) {
+		if ((idx != of_property_read_u32(node, "reg", &reg)) ||
+		    !of_device_is_compatible(node, compat))
+			continue;
+		return of_node_get(node);
+	}
+
+	return NULL;
+}
+
 static void ac97_codec_release(struct device *dev)
 {
 	struct ac97_codec_device *adev;
@@ -76,6 +98,7 @@ static void ac97_codec_release(struct device *dev)
 	adev = to_ac97_device(dev);
 	ac97_ctrl = adev->ac97_ctrl;
 	ac97_ctrl->codecs[adev->num] = NULL;
+	of_node_put(dev->of_node);
 	kfree(adev);
 }
 
@@ -98,6 +121,8 @@ static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
 
 	device_initialize(&codec->dev);
 	dev_set_name(&codec->dev, "%s:%u", dev_name(ac97_ctrl->parent), idx);
+	codec->dev.of_node = ac97_of_get_child_device(ac97_ctrl, idx,
+						      vendor_id);
 
 	ret = device_add(&codec->dev);
 	if (ret)
@@ -105,6 +130,7 @@ static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
 
 	return 0;
 err_free_codec:
+	of_node_put(codec->dev.of_node);
 	put_device(&codec->dev);
 	kfree(codec);
 	ac97_ctrl->codecs[idx] = NULL;
-- 
2.11.0
