From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/5] control: initialize element channel values
	according to identification number
Date: Mon, 15 Feb 2016 22:33:09 +0900
Message-ID: <1455543193-28109-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1455543193-28109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A5A5A261560
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 14:33:18 +0100 (CET)
In-Reply-To: <1455543193-28109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In ALSA Ctl core, there're two ways to identify elements. One is by numid.
Another is by name/index. The former way is lighter than the latter way.

In control API, after adding elements by snd_ctl_elem_add_integer() and
snd_ctl_elem_add_integer64(), these functions manage to initialize value
of each channel. When executing this operation, used ID information is
still given by applications. Although, in this time, the element can be
identified according to numid.

This commit uses the numid instead of name/index pair.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 328920d..691b69c 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -292,7 +292,7 @@ int snd_ctl_elem_add_integer(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	if (err < 0)
 		return err;
 	snd_ctl_elem_value_alloca(&val);
-	val->id = *id;
+	val->id = info->id;
 	for (i = 0; i < count; i++)
 		val->value.integer.value[i] = min;
 	err = ctl->ops->element_write(ctl, val);
@@ -330,7 +330,7 @@ int snd_ctl_elem_add_integer64(snd_ctl_t *ctl, const snd_ctl_elem_id_t *id,
 	if (err < 0)
 		return err;
 	snd_ctl_elem_value_alloca(&val);
-	val->id = *id;
+	val->id = info->id;
 	for (i = 0; i < count; i++)
 		val->value.integer64.value[i] = min;
 	err = ctl->ops->element_write(ctl, val);
-- 
2.5.0
