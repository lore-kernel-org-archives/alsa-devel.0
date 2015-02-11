From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/5] ALSA: control: use dev_dbg() for warning
	to add duplicated controls
Date: Wed, 11 Feb 2015 19:40:10 +0900
Message-ID: <1423651213-19829-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 8684B26262D
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:40:21 +0100 (CET)
In-Reply-To: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When duplicated controls are added, snd module generates message and
the callers receive -EBUSY. The messaging is redundant, especially for
userspace applications because it's caller's fault and callers get
the status code.

This commit change its messaging level to suppress messages in normal
usage.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index d98b990..1edd6c5 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -349,7 +349,7 @@ int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 	down_write(&card->controls_rwsem);
 	if (snd_ctl_find_id(card, &id)) {
 		up_write(&card->controls_rwsem);
-		dev_err(card->dev,
+		dev_dbg(card->dev,
 			"control %i:%i:%i:%s:%i is already present\n",
 			id.iface, id.device, id.subdevice, id.name, id.index);
 		err = -EBUSY;
-- 
2.1.0
