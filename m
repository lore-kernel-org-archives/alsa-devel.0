From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/29] mixer: change code formatting for
	elem_write_route()
Date: Fri, 15 Jul 2016 09:23:21 +0900
Message-ID: <1468542213-24880-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 5D48F26659F
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

This commit applies code format according to typical and moderate rule.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/mixer/simple_none.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index cf57ea5..0ebaf5e 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -524,7 +524,8 @@ static int elem_write_route(selem_none_t *s, int dir, selem_ctl_type_t type)
 	for (idx = 0; idx < c->values * c->values; idx++)
 		snd_ctl_elem_value_set_integer(ctl, idx, 0);
 	for (idx = 0; idx < c->values; idx++)
-		snd_ctl_elem_value_set_integer(ctl, idx * c->values + idx, !!(s->str[dir].sw & (1 << idx)));
+		snd_ctl_elem_value_set_integer(ctl, idx * c->values + idx,
+					       !!(s->str[dir].sw & (1 << idx)));
 	if ((err = snd_hctl_elem_write(c->elem, ctl)) < 0)
 		return err;
 	return 0;
-- 
2.7.4
