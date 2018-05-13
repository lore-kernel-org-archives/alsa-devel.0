From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/4] ALSA: vmaster: use position offset macro
	of TLV data
Date: Mon, 14 May 2018 07:09:51 +0900
Message-ID: <20180513220953.15118-3-o-takashi@sakamocchi.jp>
References: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id EEB40267673
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 00:10:29 +0200 (CEST)
Received: by mail-pl0-f68.google.com with SMTP id e6-v6so6197616plt.11
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:10:29 -0700 (PDT)
In-Reply-To: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A series of SNDRV_CTL_TLVO_XXX macro was introduced for position offset
of TLV data. This commit applies a code optimization.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/vmaster.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index 9e96186742d0..58fa3f94722a 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -421,13 +421,15 @@ struct snd_kcontrol *snd_ctl_make_virtual_master(char *name,
 	kctl->private_free = master_free;
 
 	/* additional (constant) TLV read */
-	if (tlv &&
-	    (tlv[0] == SNDRV_CTL_TLVT_DB_SCALE ||
-	     tlv[0] == SNDRV_CTL_TLVT_DB_MINMAX ||
-	     tlv[0] == SNDRV_CTL_TLVT_DB_MINMAX_MUTE)) {
-		kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
-		memcpy(master->tlv, tlv, sizeof(master->tlv));
-		kctl->tlv.p = master->tlv;
+	if (tlv) {
+		unsigned int type = tlv[SNDRV_CTL_TLVO_TYPE];
+		if (type == SNDRV_CTL_TLVT_DB_SCALE ||
+		    type == SNDRV_CTL_TLVT_DB_MINMAX ||
+		    type == SNDRV_CTL_TLVT_DB_MINMAX_MUTE) {
+			kctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+			memcpy(master->tlv, tlv, sizeof(master->tlv));
+			kctl->tlv.p = master->tlv;
+		}
 	}
 
 	return kctl;
-- 
2.14.1
