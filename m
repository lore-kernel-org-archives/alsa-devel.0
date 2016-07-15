From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 23/29] mixer: remove alloca() from
	enum_item_name_ops()
Date: Fri, 15 Jul 2016 09:23:27 +0900
Message-ID: <1468542213-24880-24-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 64C462666BD
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
 src/mixer/simple_none.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 0799ceb..ab2b151 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1313,7 +1313,7 @@ static int enum_item_name_ops(snd_mixer_elem_t *elem,
 			      size_t maxlen, char *buf)
 {
 	selem_none_t *s = snd_mixer_elem_get_private(elem);
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 	snd_hctl_elem_t *helem;
 	int type;
 
@@ -1330,11 +1330,10 @@ static int enum_item_name_ops(snd_mixer_elem_t *elem,
 	assert(helem);
 	if (item >= (unsigned int)s->ctls[type].max)
 		return -EINVAL;
-	snd_ctl_elem_info_alloca(&info);
-	snd_hctl_elem_info(helem, info);
-	snd_ctl_elem_info_set_item(info, item);
-	snd_hctl_elem_info(helem, info);
-	strncpy(buf, snd_ctl_elem_info_get_item_name(info), maxlen);
+	snd_hctl_elem_info(helem, &info);
+	snd_ctl_elem_info_set_item(&info, item);
+	snd_hctl_elem_info(helem, &info);
+	strncpy(buf, snd_ctl_elem_info_get_item_name(&info), maxlen);
 	return 0;
 }
 
-- 
2.7.4
