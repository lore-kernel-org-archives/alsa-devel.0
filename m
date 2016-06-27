From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] ctl: fix returning zero for
	dimension level 4
Date: Mon, 27 Jun 2016 22:02:57 +0900
Message-ID: <1467032577-7268-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 501D62651D3
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2016 15:03:02 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In ALSA kernel/userspace interfaces, 'struct snd_ctl_elem_info' has a
'dimension' parameter. This parameter consists of an array with four
elements. Each element represents the number of members in corresponding
dimension level to construct matrix.

In current implementation, a get function, 'snd_ctl_elem_info_get_dimension()'
is hardcoded to return zero to level 4, against actual value. This commit fixes
the bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/control/control.c b/src/control/control.c
index d515cff..0cb0105 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -2483,7 +2483,7 @@ int snd_ctl_elem_info_get_dimension(const snd_ctl_elem_info_t *obj, unsigned int
 #endif
 {
 	assert(obj);
-	if (idx >= 3)
+	if (idx > 3)
 		return 0;
 	return obj->dimen.d[idx];
 }
-- 
2.7.4
