From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 20/29] mixer: remove alloca() from
	selem_write_main()
Date: Fri, 15 Jul 2016 09:23:24 +0900
Message-ID: <1468542213-24880-21-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id DD8CB2666D6
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
index 10b878e..4bd231c 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -628,17 +628,16 @@ static int selem_write_main(snd_mixer_elem_t *elem)
 			return err;
 	}
 	if (s->ctls[CTL_CAPTURE_SOURCE].elem) {
-		snd_ctl_elem_value_t *ctl;
+		snd_ctl_elem_value_t ctl = {0};
 		selem_ctl_t *c = &s->ctls[CTL_CAPTURE_SOURCE];
-		snd_ctl_elem_value_alloca(&ctl);
-		if ((err = snd_hctl_elem_read(c->elem, ctl)) < 0)
+		if ((err = snd_hctl_elem_read(c->elem, &ctl)) < 0)
 			return err;
 		for (idx = 0; idx < c->values; idx++) {
 			if (s->str[SM_CAPT].sw & (1 << idx))
-				snd_ctl_elem_value_set_enumerated(ctl,
+				snd_ctl_elem_value_set_enumerated(&ctl,
 							idx, s->capture_item);
 		}
-		if ((err = snd_hctl_elem_write(c->elem, ctl)) < 0)
+		if ((err = snd_hctl_elem_write(c->elem, &ctl)) < 0)
 			return err;
 		/* update the element, don't remove */
 		err = selem_read(elem);
-- 
2.7.4
