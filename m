From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: ml403-ac97cr: Delete an unnecessary
 return statement in snd_ml403_ac97cr_codec_write()
Date: Sat, 11 Nov 2017 14:18:32 +0100
Message-ID: <4ca8d2ff-30ce-2c74-9291-e1b1ffad8141@users.sourceforge.net>
References: <4c38a970-2407-3559-060d-501b8259b3fc@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FB05266A73
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 14:19:08 +0100 (CET)
In-Reply-To: <4c38a970-2407-3559-060d-501b8259b3fc@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 11 Nov 2017 13:57:14 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/drivers/ml403-ac97cr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 12a54bfde1a5..4cf964ea2802 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1060,7 +1060,6 @@ snd_ml403_ac97cr_codec_write(struct snd_ac97 *ac97, unsigned short reg,
 	       reg, val, val);
 #endif
 	mutex_unlock(&ml403_ac97cr->cdc_mutex);
-	return;
 }
 
 static int
-- 
2.15.0
