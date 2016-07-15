From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 26/29] mixer: change code formatting for
	simple_add1()
Date: Fri, 15 Jul 2016 09:23:30 +0900
Message-ID: <1468542213-24880-27-git-send-email-o-takashi@sakamocchi.jp>
References: <1468542213-24880-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0026F266703
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
 src/mixer/simple_none.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/src/mixer/simple_none.c b/src/mixer/simple_none.c
index 3ee1168..1ccccc4 100644
--- a/src/mixer/simple_none.c
+++ b/src/mixer/simple_none.c
@@ -1527,8 +1527,10 @@ static int simple_add1(snd_mixer_class_t *class, const char *name,
 		simple->selem.id = id;
 		simple->selem.ops = &simple_none_ops;
 		err = snd_mixer_elem_new(&melem, SND_MIXER_ELEM_SIMPLE,
-					 get_compare_weight(snd_mixer_selem_id_get_name(simple->selem.id), snd_mixer_selem_id_get_index(simple->selem.id)),
-					 simple, selem_free);
+			get_compare_weight(
+				snd_mixer_selem_id_get_name(simple->selem.id),
+				snd_mixer_selem_id_get_index(simple->selem.id)),
+			simple, selem_free);
 		if (err < 0) {
 			snd_mixer_selem_id_free(id);
 			free(simple);
@@ -1541,11 +1543,12 @@ static int simple_add1(snd_mixer_class_t *class, const char *name,
 	}
 	if (simple->ctls[type].elem) {
 		SNDERR("helem (%s,'%s',%u,%u,%u) appears twice or more",
-				snd_ctl_elem_iface_name(snd_hctl_elem_get_interface(helem)),
-				snd_hctl_elem_get_name(helem),
-				snd_hctl_elem_get_index(helem),
-				snd_hctl_elem_get_device(helem),
-				snd_hctl_elem_get_subdevice(helem));
+		       snd_ctl_elem_iface_name(
+				snd_hctl_elem_get_interface(helem)),
+		       snd_hctl_elem_get_name(helem),
+		       snd_hctl_elem_get_index(helem),
+		       snd_hctl_elem_get_device(helem),
+		       snd_hctl_elem_get_subdevice(helem));
 		err = -EINVAL;
 		goto __error;
 	}
@@ -1560,8 +1563,10 @@ static int simple_add1(snd_mixer_class_t *class, const char *name,
 		simple->ctls[type].max = snd_ctl_elem_info_get_items(info);
 	} else {
 		if (ctype == SND_CTL_ELEM_TYPE_INTEGER) {
-			simple->ctls[type].min = snd_ctl_elem_info_get_min(info);
-			simple->ctls[type].max = snd_ctl_elem_info_get_max(info);
+			simple->ctls[type].min =
+					snd_ctl_elem_info_get_min(info);
+			simple->ctls[type].max =
+					snd_ctl_elem_info_get_max(info);
 		}
 	}
 	switch (type) {
-- 
2.7.4
