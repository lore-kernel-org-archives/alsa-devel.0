From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/29] mixer: remove alloca() from
	elem_read_route()
Date: Fri, 15 Jul 2016 09:23:09 +0900
Message-ID: <1468542213-24880-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 8CDB926590B
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

Both of alloca() and automatic variables keep storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/mixer/simple_none.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 65b7b7b..c3ce427 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -271,18 +271,17 @@ static int elem_read_switch(selem_none_t *s, int dir, selem_ctl_type_t type)
 
 static int elem_read_route(selem_none_t *s, int dir, selem_ctl_type_t type)
 {
-	snd_ctl_elem_value_t *ctl;
+	snd_ctl_elem_value_t ctl = {0};
 	unsigned int idx;
 	int err;
 	selem_ctl_t *c = &s->ctls[type];
-	snd_ctl_elem_value_alloca(&ctl);
-	if ((err = snd_hctl_elem_read(c->elem, ctl)) < 0)
+	if ((err = snd_hctl_elem_read(c->elem, &ctl)) < 0)
 		return err;
 	for (idx = 0; idx < s->str[dir].channels; idx++) {
 		unsigned int idx1 = idx;
 		if (idx >= c->values)
 			idx1 = 0;
-		if (!snd_ctl_elem_value_get_integer(ctl,
+		if (!snd_ctl_elem_value_get_integer(&ctl,
 						    idx1 * c->values + idx1))
 			s->str[dir].sw &= ~(1 << idx);
 	}
-- 
2.7.4
