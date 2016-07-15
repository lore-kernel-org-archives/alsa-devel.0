From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 27/29] mixer: remove alloca() from simple_add1()
Date: Fri, 15 Jul 2016 09:23:31 +0900
Message-ID: <1468542213-24880-28-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 6D7132666C1
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
 src/mixer/simple_none.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 1ccccc4..68ab37e 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1419,18 +1419,17 @@ static int simple_add1(snd_mixer_class_t *class, const char *name,
 	snd_mixer_selem_id_t *id;
 	int new = 0;
 	int err;
-	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_info_t info = {0};
 	selem_none_t *simple;
 	const char *name1;
 	snd_ctl_elem_type_t ctype;
 	unsigned long values;
 
-	snd_ctl_elem_info_alloca(&info);
-	err = snd_hctl_elem_info(helem, info);
+	err = snd_hctl_elem_info(helem, &info);
 	if (err < 0)
 		return err;
-	ctype = snd_ctl_elem_info_get_type(info);
-	values = snd_ctl_elem_info_get_count(info);
+	ctype = snd_ctl_elem_info_get_type(&info);
+	values = snd_ctl_elem_info_get_count(&info);
 	switch (type) {
 	case CTL_SINGLE:
 		if (ctype == SND_CTL_ELEM_TYPE_ENUMERATED)
@@ -1553,20 +1552,20 @@ static int simple_add1(snd_mixer_class_t *class, const char *name,
 		goto __error;
 	}
 	simple->ctls[type].elem = helem;
-	simple->ctls[type].type = snd_ctl_elem_info_get_type(info);
-	simple->ctls[type].inactive = snd_ctl_elem_info_is_inactive(info);
+	simple->ctls[type].type = snd_ctl_elem_info_get_type(&info);
+	simple->ctls[type].inactive = snd_ctl_elem_info_is_inactive(&info);
 	simple->ctls[type].values = values;
 	if ( (type == CTL_GLOBAL_ENUM) ||
 	     (type == CTL_PLAYBACK_ENUM) ||
 	     (type == CTL_CAPTURE_ENUM) ) {
 		simple->ctls[type].min = 0;
-		simple->ctls[type].max = snd_ctl_elem_info_get_items(info);
+		simple->ctls[type].max = snd_ctl_elem_info_get_items(&info);
 	} else {
 		if (ctype == SND_CTL_ELEM_TYPE_INTEGER) {
 			simple->ctls[type].min =
-					snd_ctl_elem_info_get_min(info);
+					snd_ctl_elem_info_get_min(&info);
 			simple->ctls[type].max =
-					snd_ctl_elem_info_get_max(info);
+					snd_ctl_elem_info_get_max(&info);
 		}
 	}
 	switch (type) {
-- 
2.7.4
