From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 12/29] mixer: change code formatting for
	elem_write_switch()
Date: Fri, 15 Jul 2016 09:23:16 +0900
Message-ID: <1468542213-24880-13-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id A52A5265AE8
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 02:23:40 +0200 (CEST)
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
index ee9f84a..d0e800e 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -491,7 +491,8 @@ static int elem_write_switch(selem_none_t *s, int dir, selem_ctl_type_t type)
 	if ((err = snd_hctl_elem_read(c->elem, ctl)) < 0)
 		return err;
 	for (idx = 0; idx < c->values; idx++)
-		snd_ctl_elem_value_set_integer(ctl, idx, !!(s->str[dir].sw & (1 << idx)));
+		snd_ctl_elem_value_set_integer(ctl, idx,
+					!!(s->str[dir].sw & (1 << idx)));
 	if ((err = snd_hctl_elem_write(c->elem, ctl)) < 0)
 		return err;
 	return 0;
-- 
2.7.4
