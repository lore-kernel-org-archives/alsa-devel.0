From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 07/10] pcm: use new APIs to add a control
	element set for softvol plugin
Date: Sun, 12 Jun 2016 17:16:08 +0900
Message-ID: <1465719371-27721-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 036242607F7
 for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2016 10:16:19 +0200 (CEST)
In-Reply-To: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
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

In previous commit, some APIs to add a single element are deprecated.

This commit replaces the usage of the old APIs with new APIs.

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
