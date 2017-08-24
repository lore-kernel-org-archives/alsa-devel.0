From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] ALSA: control: delegate TLV eventing to
	each driver
Date: Thu, 24 Aug 2017 10:46:14 +0900
Message-ID: <20170824014616.28859-2-o-takashi@sakamocchi.jp>
References: <20170824014616.28859-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 84EA7266BED
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

In a design of ALSA control core, a set of elements is represented by
'struct snd_kcontrol' to share common attributes. The set of elements
shares TLV (Type-Length-Value) data, too.

On the other hand, in ALSA control interface/protocol for applications,
a TLV operation is committed to an element. Totally, the operation can
have sub-effect to the other elements in the set. For example, TLV_WRITE
operation is expected to change TLV data, which returns to applications.
Applications attempt to change the TLV data per element, but in the above
design, they can effect to elements in the same set.

As a default, ALSA control core has no implementation except for TLV_READ
operation. Thus, the above design looks to have no issue. However, in
kernel APIs of ALSA control component, developers can program a handler
for any request of the TLV operation. Therefore, for elements in a set
which has the handler, applications can commit TLV_WRITE and TLV_COMMAND
requests.

For the above scenario, ALSA control core assist notification. When the
handler returns positive value, the core queueing an event for a requested
element. However, this includes design defects that the event is not
queued for the other element in a set. Actually, developers can program
the handlers to keep per-element TLV data, but it depends on each driver.

As of v4.13-rc6, there's no driver in tree to utilize the notification,
except for user-defined element set. This commit delegates the notification
into each driver to prevent developers from the design defects.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index de976a8c0177..d6a8502da828 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1138,6 +1138,8 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 	ue->tlv_data = container;
 	ue->tlv_data_size = size;
 
+	snd_ctl_notify(ue->card, SNDRV_CTL_EVENT_MASK_TLV, &kctl->id);
+
 	return change;
 }
 
@@ -1423,7 +1425,6 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 	};
 	struct snd_kcontrol_volatile *vd = &kctl->vd[snd_ctl_get_ioff(kctl, id)];
 	int i;
-	int err;
 
 	/* Check support of the request for this element. */
 	for (i = 0; i < ARRAY_SIZE(pairs); ++i) {
@@ -1440,14 +1441,7 @@ static int call_tlv_handler(struct snd_ctl_file *file, int op_flag,
 	if (vd->owner != NULL && vd->owner != file)
 		return -EPERM;
 
-	err = kctl->tlv.c(kctl, op_flag, size, buf);
-	if (err < 0)
-		return err;
-
-	if (err > 0)
-		snd_ctl_notify(file->card, SNDRV_CTL_EVENT_MASK_TLV, id);
-
-	return 0;
+	return kctl->tlv.c(kctl, op_flag, size, buf);
 }
 
 static int read_tlv_buf(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id,
-- 
2.11.0
