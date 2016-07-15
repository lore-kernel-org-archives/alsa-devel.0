From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/29] mixer: change code formatting for
	elem_write_enum()
Date: Fri, 15 Jul 2016 09:23:19 +0900
Message-ID: <1468542213-24880-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 55749265D3C
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
 src/mixer/simple_none.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 13666b5..5ae94d9 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -538,7 +538,8 @@ static int elem_write_enum(selem_none_t *s)
 	int type;
 	selem_ctl_t *c;
 	type = CTL_GLOBAL_ENUM;
-	if ( (s->selem.caps & (SM_CAP_CENUM | SM_CAP_PENUM) ) == (SM_CAP_CENUM | SM_CAP_PENUM) )
+	if ((s->selem.caps & (SM_CAP_CENUM | SM_CAP_PENUM)) ==
+						(SM_CAP_CENUM | SM_CAP_PENUM))
 		type = CTL_GLOBAL_ENUM;
 	else if (s->selem.caps & SM_CAP_PENUM)
 		type = CTL_PLAYBACK_ENUM;
@@ -549,7 +550,8 @@ static int elem_write_enum(selem_none_t *s)
 	if ((err = snd_hctl_elem_read(c->elem, ctl)) < 0)
 		return err;
 	for (idx = 0; idx < c->values; idx++)
-		snd_ctl_elem_value_set_enumerated(ctl, idx, (unsigned int)s->str[0].vol[idx]);
+		snd_ctl_elem_value_set_enumerated(ctl, idx,
+					(unsigned int)s->str[0].vol[idx]);
 	if ((err = snd_hctl_elem_write(c->elem, ctl)) < 0)
 		return err;
 	return 0;
-- 
2.7.4
