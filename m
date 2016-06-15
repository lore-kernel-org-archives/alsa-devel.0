From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/9] pcm: use new APIs to add a control element
	set for softvol plugin
Date: Wed, 15 Jun 2016 23:57:42 +0900
Message-ID: <1466002665-30048-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 180222668BE
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:57:53 +0200 (CEST)
In-Reply-To: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
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

In previous commit, some APIs to add a single element are discouraged to
continue using.

This commit replaces usage of the old APIs with new APIs.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_softvol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 5492db8..459ff8e 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -670,10 +670,11 @@ static int add_user_ctl(snd_pcm_softvol_t *svol, snd_ctl_elem_info_t *cinfo, int
 	unsigned int def_val;
 	
 	if (svol->max_val == 1)
-		err = snd_ctl_elem_add_boolean(svol->ctl, &cinfo->id, count);
+		err = snd_ctl_elem_add_boolean_set(svol->ctl, &cinfo->id, 1,
+						   count);
 	else
-		err = snd_ctl_elem_add_integer(svol->ctl, &cinfo->id, count,
-					       0, svol->max_val, 0);
+		err = snd_ctl_elem_add_integer_set(svol->ctl, &cinfo->id, 1,
+						   count, 0, svol->max_val, 0);
 	if (err < 0)
 		return err;
 	if (svol->max_val == 1)
-- 
2.7.4
