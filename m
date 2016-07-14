From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 15/34] pcm: remove alloca() from
	snd_pcm_hw_get_chmap()
Date: Thu, 14 Jul 2016 23:07:32 +0900
Message-ID: <1468505271-5769-16-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id AB0C8265A73
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:09 +0200 (CEST)
In-Reply-To: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Both of alloca() and automatic variables keeps storages on stack, while
the former generates more instructions than the latter. It's better to use
the latter if the size of storage is computable at pre-compile or compile
time; i.e. just for structures.

This commit obsolete usages of alloca() with automatic variables.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/pcm/pcm_hw.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index e7a2393..20c233b 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1206,8 +1206,8 @@ static snd_pcm_chmap_t *snd_pcm_hw_get_chmap(snd_pcm_t *pcm)
 	snd_pcm_hw_t *hw = pcm->private_data;
 	snd_pcm_chmap_t *map;
 	snd_ctl_t *ctl;
-	snd_ctl_elem_id_t *id;
-	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_id_t id = {0};
+	snd_ctl_elem_value_t val = {0};
 	unsigned int i;
 	int ret;
 
@@ -1241,11 +1241,9 @@ static snd_pcm_chmap_t *snd_pcm_hw_get_chmap(snd_pcm_t *pcm)
 		chmap_caps_set_error(hw, CHMAP_CTL_GET);
 		return NULL;
 	}
-	snd_ctl_elem_value_alloca(&val);
-	snd_ctl_elem_id_alloca(&id);
-	fill_chmap_ctl_id(pcm, id);
-	snd_ctl_elem_value_set_id(val, id);
-	ret = snd_ctl_elem_read(ctl, val);
+	fill_chmap_ctl_id(pcm, &id);
+	snd_ctl_elem_value_set_id(&val, &id);
+	ret = snd_ctl_elem_read(ctl, &val);
 	snd_ctl_close(ctl);
 	if (ret < 0) {
 		free(map);
@@ -1254,7 +1252,7 @@ static snd_pcm_chmap_t *snd_pcm_hw_get_chmap(snd_pcm_t *pcm)
 		return NULL;
 	}
 	for (i = 0; i < pcm->channels; i++)
-		map->pos[i] = snd_ctl_elem_value_get_integer(val, i);
+		map->pos[i] = snd_ctl_elem_value_get_integer(&val, i);
 	chmap_caps_set_ok(hw, CHMAP_CTL_GET);
 	return map;
 }
-- 
2.7.4
