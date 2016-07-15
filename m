From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 25/29] mixer: remove alloca() from
	set_enum_item_ops()
Date: Fri, 15 Jul 2016 09:23:29 +0900
Message-ID: <1468542213-24880-26-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 69CAB2666C0
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 02:23:41 +0200 (CEST)
In-Reply-To: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
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

Both of alloca() and automatic variables keep storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/mixer/simple_none.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 3362f82..3ee1168 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1363,7 +1363,7 @@ static int set_enum_item_ops(snd_mixer_elem_t *elem,
 			     unsigned int item)
 {
 	selem_none_t *s = snd_mixer_elem_get_private(elem);
-	snd_ctl_elem_value_t *ctl;
+	snd_ctl_elem_value_t ctl = {0};
 	snd_hctl_elem_t *helem;
 	int err;
 	int type;
@@ -1385,13 +1385,12 @@ static int set_enum_item_ops(snd_mixer_elem_t *elem,
 	if (item >= (unsigned int)s->ctls[type].max) {
 		return -EINVAL;
 	}
-	snd_ctl_elem_value_alloca(&ctl);
-	err = snd_hctl_elem_read(helem, ctl);
+	err = snd_hctl_elem_read(helem, &ctl);
 	if (err < 0) {
 		return err;
 	}
-	snd_ctl_elem_value_set_enumerated(ctl, channel, item);
-	return snd_hctl_elem_write(helem, ctl);
+	snd_ctl_elem_value_set_enumerated(&ctl, channel, item);
+	return snd_hctl_elem_write(helem, &ctl);
 }
 
 static struct sm_elem_ops simple_none_ops = {
-- 
2.7.4
