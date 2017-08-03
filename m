From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/5] ALSA: control: code refactoring for TLV
	request handler to user element set
Date: Thu,  3 Aug 2017 20:20:44 +0900
Message-ID: <20170803112044.17138-6-o-takashi@sakamocchi.jp>
References: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3A326266FC9
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 13:20:52 +0200 (CEST)
In-Reply-To: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

User-defined element set registers own handler to get callbacks from TLV
ioctl handler. In the handler, execution path bifurcates depending on
requests from user space. At write request, container in given buffer is
registered to the element set, or replaced old TLV data. At the read
request, the registered data is copied to user space. The command request
is not allowed.  In current implementation, function of the handler
includes codes for the two cases.

This commit adds two helper functions for these cases so that readers can
easily get the above design.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 76 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index d8caf3745dea..1d411b83f758 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1114,43 +1114,59 @@ static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 	return change;
 }
 
-static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
-				 int op_flag,
-				 unsigned int size,
-				 unsigned int __user *tlv)
+static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
+			    unsigned int size)
 {
-	struct user_element *ue = kcontrol->private_data;
+	struct user_element *ue = kctl->private_data;
+	unsigned int *container;
+	int change;
 
-	if (op_flag == SNDRV_CTL_TLV_OP_WRITE) {
-		int change;
-		void *new_data;
+	if (size > 1024 * 128)	/* sane value */
+		return -EINVAL;
 
-		if (size > 1024 * 128)	/* sane value */
-			return -EINVAL;
+	container = memdup_user(buf, size);
+	if (IS_ERR(container))
+		return PTR_ERR(container);
 
-		new_data = memdup_user(tlv, size);
-		if (IS_ERR(new_data))
-			return PTR_ERR(new_data);
-		change = ue->tlv_data_size != size;
-		if (!change)
-			change = memcmp(ue->tlv_data, new_data, size);
-		kfree(ue->tlv_data);
-		ue->tlv_data = new_data;
-		ue->tlv_data_size = size;
-
-		return change;
-	} else {
-		if (!ue->tlv_data_size || !ue->tlv_data)
-			return -ENXIO;
+	change = ue->tlv_data_size != size;
+	if (!change)
+		change = memcmp(ue->tlv_data, container, size);
+	if (!change) {
+		kfree(container);
+		return 0;
+	}
 
-		if (size < ue->tlv_data_size)
-			return -ENOSPC;
+	kfree(ue->tlv_data);
+	ue->tlv_data = container;
+	ue->tlv_data_size = size;
 
-		if (copy_to_user(tlv, ue->tlv_data, ue->tlv_data_size))
-			return -EFAULT;
+	return change;
+}
 
-		return 0;
-	}
+static int read_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
+			 unsigned int size)
+{
+	struct user_element *ue = kctl->private_data;
+
+	if (ue->tlv_data_size == 0 || ue->tlv_data == NULL)
+		return -ENXIO;
+
+	if (size < ue->tlv_data_size)
+		return -ENOSPC;
+
+	if (copy_to_user(buf, ue->tlv_data, ue->tlv_data_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kctl, int op_flag,
+				 unsigned int size, unsigned int __user *buf)
+{
+	if (op_flag == SNDRV_CTL_TLV_OP_WRITE)
+		return replace_user_tlv(kctl, buf, size);
+	else
+		return read_user_tlv(kctl, buf, size);
 }
 
 static int snd_ctl_elem_init_enum_names(struct user_element *ue)
-- 
2.11.0
