From: ylhuajnu@163.com
Subject: [PATCH] ALSA: ac97: fix device initialization in the
	compat layer
Date: Wed, 15 Aug 2018 20:59:46 +0800
Message-ID: <20180815125946.15451-1-ylhuajnu@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by alsa0.perex.cz (Postfix) with ESMTP id EA3832675DA
 for <alsa-devel@alsa-project.org>; Wed, 15 Aug 2018 15:00:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: Lihua Yao <ylhuajnu@163.com>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr
List-Id: alsa-devel@alsa-project.org

From: Lihua Yao <ylhuajnu@163.com>

ac97->dev is an object of 'struct device' type. It should be initialized
via device_initialize() or device_register().

Fixes: 74426fbff66e ("ALSA: ac97: add an ac97 bus")
Signed-off-by: Lihua Yao <ylhuajnu@163.com>
---
 sound/ac97/snd_ac97_compat.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/ac97/snd_ac97_compat.c b/sound/ac97/snd_ac97_compat.c
index 61544e0d8de4..8bab44f74bb8 100644
--- a/sound/ac97/snd_ac97_compat.c
+++ b/sound/ac97/snd_ac97_compat.c
@@ -15,6 +15,11 @@
 
 #include "ac97_core.h"
 
+static void compat_ac97_release(struct device *dev)
+{
+	kfree(to_ac97_t(dev));
+}
+
 static void compat_ac97_reset(struct snd_ac97 *ac97)
 {
 	struct ac97_codec_device *adev = to_ac97_device(ac97->private_data);
@@ -65,21 +70,31 @@ static struct snd_ac97_bus compat_soc_ac97_bus = {
 struct snd_ac97 *snd_ac97_compat_alloc(struct ac97_codec_device *adev)
 {
 	struct snd_ac97 *ac97;
+	int ret;
 
 	ac97 = kzalloc(sizeof(struct snd_ac97), GFP_KERNEL);
 	if (ac97 == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	ac97->dev = adev->dev;
 	ac97->private_data = adev;
 	ac97->bus = &compat_soc_ac97_bus;
+
+	ac97->dev.parent = &adev->dev;
+	ac97->dev.release = compat_ac97_release;
+	dev_set_name(&ac97->dev, "%s-compat", dev_name(&adev->dev));
+	ret = device_register(&ac97->dev);
+	if (ret) {
+		put_device(&ac97->dev);
+		return ERR_PTR(ret);
+	}
+
 	return ac97;
 }
 EXPORT_SYMBOL_GPL(snd_ac97_compat_alloc);
 
 void snd_ac97_compat_release(struct snd_ac97 *ac97)
 {
-	kfree(ac97);
+	device_unregister(&ac97->dev);
 }
 EXPORT_SYMBOL_GPL(snd_ac97_compat_release);
 
-- 
2.17.1
