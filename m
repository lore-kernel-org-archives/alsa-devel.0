From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] control: correct assertion in
	snd_ctl_elem_set_bytes()
Date: Mon, 22 Feb 2016 01:54:09 +0900
Message-ID: <1456073649-15885-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CD1A260647
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2016 17:54:13 +0100 (CET)
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

The assert(3) aborts running process when expression arguments is
false (zero). Although, the snd_ctl_elem_set_bytes() has return
statement after assert(3). It has meaningless.

This commit corrects the statements.

Fixes: 7893ea238d5a('Added mode argument to open functions where it was missing. First part of CTL documentation')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 328920d..70d168d 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2627,10 +2627,7 @@ void snd_ctl_elem_value_set_byte(snd_ctl_elem_value_t *obj, unsigned int idx, un
 void snd_ctl_elem_set_bytes(snd_ctl_elem_value_t *obj, void *data, size_t size)
 {
 	assert(obj);
-	if (size >= ARRAY_SIZE(obj->value.bytes.data)) {
-		assert(0);
-		return;
-	}
+	assert(size < ARRAY_SIZE(obj->value.bytes.data));
 	memcpy(obj->value.bytes.data, data, size);
 }
 
-- 
2.5.0
