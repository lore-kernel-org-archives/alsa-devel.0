From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 02/29] mixer: change code formatting for
	elem_read_volume()
Date: Fri, 15 Jul 2016 09:23:06 +0900
Message-ID: <1468542213-24880-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 2D100265873
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 02:23:38 +0200 (CEST)
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
 src/mixer/simple_none.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 1d2112d..a90ee84 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -245,7 +245,9 @@ static int elem_read_volume(selem_none_t *s, int dir, selem_ctl_type_t type)
 		unsigned int idx1 = idx;
 		if (idx >= c->values)
 			idx1 = 0;
-		s->str[dir].vol[idx] = to_user(s, dir, c, snd_ctl_elem_value_get_integer(ctl, idx1));
+		s->str[dir].vol[idx] =
+			to_user(s, dir, c,
+				snd_ctl_elem_value_get_integer(ctl, idx1));
 	}
 	return 0;
 }
-- 
2.7.4
