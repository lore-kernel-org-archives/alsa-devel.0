From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 29/29] mixer: remove alloca() from
	simple_event_add()
Date: Fri, 15 Jul 2016 09:23:33 +0900
Message-ID: <1468542213-24880-30-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 70D182666C5
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
 src/mixer/simple_none.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 9b0705c..e129514 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1610,23 +1610,22 @@ static int simple_event_add(snd_mixer_class_t *class, snd_hctl_elem_t *helem)
 	if (snd_hctl_elem_get_interface(helem) != SND_CTL_ELEM_IFACE_MIXER)
 		return 0;
 	if (strcmp(name, "Capture Source") == 0) {
-		snd_ctl_elem_info_t *info;
+		snd_ctl_elem_info_t info = {0};
 		unsigned int k, items;
 		int err;
-		snd_ctl_elem_info_alloca(&info);
-		err = snd_hctl_elem_info(helem, info);
+		err = snd_hctl_elem_info(helem, &info);
 		assert(err >= 0);
-		if (snd_ctl_elem_info_get_type(info) !=
+		if (snd_ctl_elem_info_get_type(&info) !=
 						SND_CTL_ELEM_TYPE_ENUMERATED)
 			return 0;
-		items = snd_ctl_elem_info_get_items(info);
+		items = snd_ctl_elem_info_get_items(&info);
 		for (k = 0; k < items; ++k) {
 			const char *n;
-			snd_ctl_elem_info_set_item(info, k);
-			err = snd_hctl_elem_info(helem, info);
+			snd_ctl_elem_info_set_item(&info, k);
+			err = snd_hctl_elem_info(helem, &info);
 			if (err < 0)
 				return err;
-			n = snd_ctl_elem_info_get_item_name(info);
+			n = snd_ctl_elem_info_get_item_name(&info);
 			err = simple_add1(class, n, helem, CTL_CAPTURE_SOURCE,
 					  k);
 			if (err < 0)
-- 
2.7.4
