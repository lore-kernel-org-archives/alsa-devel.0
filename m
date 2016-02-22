From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] control: keep consistent usage of assertion
Date: Mon, 22 Feb 2016 22:13:31 +0900
Message-ID: <1456146811-5596-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 190D62606B8
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 14:13:34 +0100 (CET)
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

In most codes for control APIs, assertions are used to check given
arguments from applications. If the arguments are not expected, the
application is forced to abort. When NDEBUG is defined in the beginning
of the codes, no checks are performed.

Although, in snd_ctl_elem_set_bytes(), assertion is used with condition
statement. There's an intention to check the arguments regardless of
NDEBUG. However, this is not the same fashion in the codes.

This commit applies the same fashion to the function, to keep consistent
usage of assertion.

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
