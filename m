From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH] ctl: fix a test for user-defined
	element set in a point of dimension
Date: Thu,  7 Jul 2016 23:22:21 +0900
Message-ID: <1467901341-11363-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 8A546265262
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 16:22:26 +0200 (CEST)
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

Currently, this test program has a bug related to dimension information.
When testing an element set with byte type, the program adds 512 members
to an element. This is a maximum number permitted for this type.

On the other hand, dimension information of the elements consists of
[8, 4, 8, 4]. Calculated members in the multi-dimensional matrix is 1024.
This should be less than 512.

This commit fixes the bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 test/user-ctl-element-set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/user-ctl-element-set.c b/test/user-ctl-element-set.c
index c346e03..0481300 100644
--- a/test/user-ctl-element-set.c
+++ b/test/user-ctl-element-set.c
@@ -513,7 +513,7 @@ int main(void)
 			trial.dimension[0] = 8;
 			trial.dimension[1] = 4;
 			trial.dimension[2] = 8;
-			trial.dimension[3] = 4;
+			trial.dimension[3] = 2;
 			trial.add_elem_set = add_bytes_elem_set;
 			trial.check_elem_props = NULL;
 			trial.change_elem_members = change_bytes_elem_members;
-- 
2.7.4
