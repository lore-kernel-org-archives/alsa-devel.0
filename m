From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: control: TLV data is unavailable at
	initial state of user-defined element set
Date: Thu, 24 Aug 2017 10:46:16 +0900
Message-ID: <20170824014616.28859-4-o-takashi@sakamocchi.jp>
References: <20170824014616.28859-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 87357266D82
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 03:46:45 +0200 (CEST)
In-Reply-To: <20170824014616.28859-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, fulup.arfoll@iot.bzh
List-Id: alsa-devel@alsa-project.org

For user-defined element set, in its initial state, TLV data is not
registered. It's firstly available when any application register it by
an additional operation. However, in current implementation, it's available
in its initial state. As a result, applications get -ENXIO to read it.

This commit controls its readability to manage info flags properly. In an
initial state, elements don't have SND_CTL_ELEM_ACCESS_TLV_READ flag. Once
TLV write operation is executed, they get the flag.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 6ddffe85126f..51d4b4ad3e1d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1118,6 +1118,7 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 	struct user_element *ue = kctl->private_data;
 	unsigned int *container;
 	struct snd_ctl_elem_id id;
+	unsigned int mask = 0;
 	int i;
 	int change;
 
@@ -1136,13 +1137,21 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 		return 0;
 	}
 
+	if (ue->tlv_data == NULL) {
+		/* Now TLV data is available. */
+		for (i = 0; i < kctl->count; ++i)
+			kctl->vd[i].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+		mask = SNDRV_CTL_EVENT_MASK_INFO;
+	}
+
 	kfree(ue->tlv_data);
 	ue->tlv_data = container;
 	ue->tlv_data_size = size;
 
+	mask |= SNDRV_CTL_EVENT_MASK_TLV;
 	for (i = 0; i < kctl->count; ++i) {
 		snd_ctl_build_ioff(&id, kctl, i);
-		snd_ctl_notify(ue->card, SNDRV_CTL_EVENT_MASK_TLV, &id);
+		snd_ctl_notify(ue->card, mask, &id);
 	}
 
 	return change;
@@ -1277,8 +1286,10 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 	access &= (SNDRV_CTL_ELEM_ACCESS_READWRITE |
 		   SNDRV_CTL_ELEM_ACCESS_INACTIVE |
-		   SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE);
-	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE)
+		   SNDRV_CTL_ELEM_ACCESS_TLV_WRITE);
+
+	/* In initial state, nothing is available as TLV container. */
+	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
 		access |= SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
 	access |= SNDRV_CTL_ELEM_ACCESS_USER;
 
@@ -1341,7 +1352,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 		kctl->get = snd_ctl_elem_user_get;
 	if (access & SNDRV_CTL_ELEM_ACCESS_WRITE)
 		kctl->put = snd_ctl_elem_user_put;
-	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE)
+	if (access & SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
 		kctl->tlv.c = snd_ctl_elem_user_tlv;
 
 	/* This function manage to free the instance on failure. */
-- 
2.11.0
