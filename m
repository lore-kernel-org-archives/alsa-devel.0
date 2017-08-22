From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: core: Fix unexpected error at replacing
	user TLV
Date: Tue, 22 Aug 2017 08:20:18 +0200
Message-ID: <20170822062018.29057-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D72C4266D86
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 08:20:21 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2B624AAB9
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 06:20:21 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When user tries to replace the user-defined control TLV, the kernel
checks the change of its content via memcmp().  The problem is that
the kernel passes the return value from memcmp() as is.  memcmp()
gives a non-zero negative value depending on the comparison result,
and this shall be recognized as an error code.

The patch covers that corner-case, return 1 properly for the changed
TLV.

Fixes: 8aa9b586e420 ("[ALSA] Control API - more robust TLV implementation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 3c6be1452e35..4525e127afd9 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1137,7 +1137,7 @@ static int snd_ctl_elem_user_tlv(struct snd_kcontrol *kcontrol,
 		mutex_lock(&ue->card->user_ctl_lock);
 		change = ue->tlv_data_size != size;
 		if (!change)
-			change = memcmp(ue->tlv_data, new_data, size);
+			change = memcmp(ue->tlv_data, new_data, size) != 0;
 		kfree(ue->tlv_data);
 		ue->tlv_data = new_data;
 		ue->tlv_data_size = size;
-- 
2.14.0
