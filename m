From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 2/3] ALSA: control: queue TLV event for
	all of elements in an user-defined set
Date: Tue, 22 Aug 2017 08:42:21 +0900
Message-ID: <20170821234222.25556-3-o-takashi@sakamocchi.jp>
References: <20170821234222.25556-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id AD607266DAB
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 01:42:32 +0200 (CEST)
In-Reply-To: <20170821234222.25556-1-o-takashi@sakamocchi.jp>
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

In a design of user-defined element set, applications allow to change TLV
data on the set. This operation doesn't only affects to a target element,
but also to elements in the set.

This commit generates TLV event for all of elements in the set when the TLV
data is changed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index bbcf4833ad1c..b8d2fa465a9d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1117,6 +1117,8 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 {
 	struct user_element *ue = kctl->private_data;
 	unsigned int *container;
+	struct snd_ctl_elem_id id;
+	int i;
 	int change;
 
 	if (size > 1024 * 128)	/* sane value */
@@ -1138,7 +1140,10 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 	ue->tlv_data = container;
 	ue->tlv_data_size = size;
 
-	snd_ctl_notify(ue->card, SNDRV_CTL_EVENT_MASK_TLV, &kctl->id);
+	for (i = 0; i < kctl->count; ++i) {
+		snd_ctl_build_ioff(&id, kctl, i);
+		snd_ctl_notify(ue->card, SNDRV_CTL_EVENT_MASK_TLV, &id);
+	}
 
 	return change;
 }
-- 
2.11.0
