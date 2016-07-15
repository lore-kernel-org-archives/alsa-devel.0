From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 19/29] mixer: change code formatting for
	selem_write_main()
Date: Fri, 15 Jul 2016 09:23:23 +0900
Message-ID: <1468542213-24880-20-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 5D7B7266687
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
 src/mixer/simple_none.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index d0e8963..10b878e 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -588,8 +588,10 @@ static int selem_write_main(snd_mixer_elem_t *elem)
 			return err;
 	}
 	if (s->ctls[CTL_GLOBAL_SWITCH].elem) {
-		if (s->ctls[CTL_PLAYBACK_SWITCH].elem && s->ctls[CTL_CAPTURE_SWITCH].elem)
-			err = elem_write_switch_constant(s, CTL_GLOBAL_SWITCH, 1);
+		if (s->ctls[CTL_PLAYBACK_SWITCH].elem &&
+					s->ctls[CTL_CAPTURE_SWITCH].elem)
+			err = elem_write_switch_constant(s, CTL_GLOBAL_SWITCH,
+							 1);
 		else
 			err = elem_write_switch(s, SM_PLAY, CTL_GLOBAL_SWITCH);
 		if (err < 0)
@@ -633,7 +635,8 @@ static int selem_write_main(snd_mixer_elem_t *elem)
 			return err;
 		for (idx = 0; idx < c->values; idx++) {
 			if (s->str[SM_CAPT].sw & (1 << idx))
-				snd_ctl_elem_value_set_enumerated(ctl, idx, s->capture_item);
+				snd_ctl_elem_value_set_enumerated(ctl,
+							idx, s->capture_item);
 		}
 		if ((err = snd_hctl_elem_write(c->elem, ctl)) < 0)
 			return err;
-- 
2.7.4
