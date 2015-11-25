From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ALSA: compress: Add procfs info file for
	compressed nodes
Date: Wed, 25 Nov 2015 09:48:37 +0000
Message-ID: <1448444918-29760-2-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1448444918-29760-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 96489261555
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 10:48:43 +0100 (CET)
In-Reply-To: <1448444918-29760-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch implements a procfs info file for compr nodes when
SND_VERBOSE_PROCFS is enabled. This is equivalent to what the PCM
core already does for pcm nodes.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h |  5 +++
 sound/core/compress_offload.c   | 75 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index fa1d055..85c4237 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -152,6 +152,11 @@ struct snd_compr {
 	unsigned int direction;
 	struct mutex lock;
 	int device;
+#ifdef CONFIG_SND_VERBOSE_PROCFS
+	char id[64];
+	struct snd_info_entry *proc_root;
+	struct snd_info_entry *proc_info_entry;
+#endif
 };
 
 /* compress device register APIs */
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index b123c42..d133915 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -40,6 +40,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/initval.h>
+#include <sound/info.h>
 #include <sound/compress_params.h>
 #include <sound/compress_offload.h>
 #include <sound/compress_driver.h>
@@ -891,11 +892,78 @@ static int snd_compress_dev_disconnect(struct snd_device *device)
 	return 0;
 }
 
+#ifdef CONFIG_SND_VERBOSE_PROCFS
+static void snd_compress_proc_info_read(struct snd_info_entry *entry,
+					struct snd_info_buffer *buffer)
+{
+	struct snd_compr *compr = (struct snd_compr *)entry->private_data;
+
+	snd_iprintf(buffer, "card: %d\n", compr->card->number);
+	snd_iprintf(buffer, "device: %d\n", compr->device);
+	snd_iprintf(buffer, "stream: %s\n",
+			compr->direction == SND_COMPRESS_PLAYBACK
+				? "PLAYBACK" : "CAPTURE");
+	snd_iprintf(buffer, "id: %s\n", compr->id);
+}
+
+static int snd_compress_proc_init(struct snd_compr *compr)
+{
+	struct snd_info_entry *entry;
+	char name[16];
+
+	sprintf(name, "compr%i", compr->device);
+	entry = snd_info_create_card_entry(compr->card, name,
+					   compr->card->proc_root);
+	if (!entry)
+		return -ENOMEM;
+	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(entry) < 0) {
+		snd_info_free_entry(entry);
+		return -ENOMEM;
+	}
+	compr->proc_root = entry;
+
+	entry = snd_info_create_card_entry(compr->card, "info",
+					   compr->proc_root);
+	if (entry) {
+		snd_info_set_text_ops(entry, compr,
+				      snd_compress_proc_info_read);
+		if (snd_info_register(entry) < 0) {
+			snd_info_free_entry(entry);
+			entry = NULL;
+		}
+	}
+	compr->proc_info_entry = entry;
+
+	return 0;
+}
+
+static int snd_compress_proc_done(struct snd_compr *compr)
+{
+	snd_info_free_entry(compr->proc_info_entry);
+	compr->proc_info_entry = NULL;
+	snd_info_free_entry(compr->proc_root);
+	compr->proc_root = NULL;
+	return 0;
+}
+#else
+static int snd_compress_proc_init(struct snd_compr *compr)
+{
+	return 0;
+}
+
+static int snd_compress_proc_done(struct snd_compr *compr)
+{
+	return 0
+}
+#endif
+
 static int snd_compress_dev_free(struct snd_device *device)
 {
 	struct snd_compr *compr;
 
 	compr = device->device_data;
+	snd_compress_proc_done(compr);
 	put_device(&compr->dev);
 	return 0;
 }
@@ -915,6 +983,7 @@ int snd_compress_new(struct snd_card *card, int device,
 		.dev_register = snd_compress_dev_register,
 		.dev_disconnect = snd_compress_dev_disconnect,
 	};
+	int ret;
 
 	compr->card = card;
 	compr->device = device;
@@ -923,7 +992,11 @@ int snd_compress_new(struct snd_card *card, int device,
 	snd_device_initialize(&compr->dev, card);
 	dev_set_name(&compr->dev, "comprC%iD%i", card->number, device);
 
-	return snd_device_new(card, SNDRV_DEV_COMPRESS, compr, &ops);
+	ret = snd_device_new(card, SNDRV_DEV_COMPRESS, compr, &ops);
+	if (ret == 0)
+		snd_compress_proc_init(compr);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_compress_new);
 
-- 
1.9.1
