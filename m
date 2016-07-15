From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 28/29] mixer: change code formatting for
	simple_event_add()
Date: Fri, 15 Jul 2016 09:23:32 +0900
Message-ID: <1468542213-24880-29-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EA6BC2666ED
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
index 68ab37e..9b0705c 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1616,7 +1616,8 @@ static int simple_event_add(snd_mixer_class_t *class, snd_hctl_elem_t *helem)
 		snd_ctl_elem_info_alloca(&info);
 		err = snd_hctl_elem_info(helem, info);
 		assert(err >= 0);
-		if (snd_ctl_elem_info_get_type(info) != SND_CTL_ELEM_TYPE_ENUMERATED)
+		if (snd_ctl_elem_info_get_type(info) !=
+						SND_CTL_ELEM_TYPE_ENUMERATED)
 			return 0;
 		items = snd_ctl_elem_info_get_items(info);
 		for (k = 0; k < items; ++k) {
@@ -1626,7 +1627,8 @@ static int simple_event_add(snd_mixer_class_t *class, snd_hctl_elem_t *helem)
 			if (err < 0)
 				return err;
 			n = snd_ctl_elem_info_get_item_name(info);
-			err = simple_add1(class, n, helem, CTL_CAPTURE_SOURCE, k);
+			err = simple_add1(class, n, helem, CTL_CAPTURE_SOURCE,
+					  k);
 			if (err < 0)
 				return err;
 		}
-- 
2.7.4
