From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/34] pcm: remove alloca() from
	snd_pcm_query_chmaps_from_hw()
Date: Thu, 14 Jul 2016 23:07:31 +0900
Message-ID: <1468505271-5769-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1468505271-5769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 780042659AF
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 16:08:08 +0200 (CEST)
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
 src/pcm/pcm_hw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 864d5fa..e7a2393 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1094,7 +1094,7 @@ snd_pcm_query_chmaps_from_hw(int card, int dev, int subdev,
 			     snd_pcm_stream_t stream)
 {
 	snd_ctl_t *ctl;
-	snd_ctl_elem_id_t *id;
+	snd_ctl_elem_id_t id = {0};
 	unsigned int tlv[2048], *start;
 	snd_pcm_chmap_query_t **map;
 	int i, ret, nums;
@@ -1105,9 +1105,8 @@ snd_pcm_query_chmaps_from_hw(int card, int dev, int subdev,
 		return NULL;
 	}
 
-	snd_ctl_elem_id_alloca(&id);
-	__fill_chmap_ctl_id(id, dev, subdev, stream);
-	ret = snd_ctl_elem_tlv_read(ctl, id, tlv, sizeof(tlv));
+	__fill_chmap_ctl_id(&id, dev, subdev, stream);
+	ret = snd_ctl_elem_tlv_read(ctl, &id, tlv, sizeof(tlv));
 	snd_ctl_close(ctl);
 	if (ret < 0) {
 		SYSMSG("Cannot read Channel Map TLV\n");
-- 
2.7.4
