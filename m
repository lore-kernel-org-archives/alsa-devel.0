From: Guy Chronister <guylovesbritt@gmail.com>
Subject: [PATCH] Fixed typo on ac97_fc_rec_volume_put.
Date: Thu, 24 May 2018 11:05:37 -0500
Message-ID: <20180524160537.1312-1-guylovesbritt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f193.google.com (mail-ot0-f193.google.com
 [74.125.82.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B201926766E
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 18:05:54 +0200 (CEST)
Received: by mail-ot0-f193.google.com with SMTP id g7-v6so2560486otj.11
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 09:05:54 -0700 (PDT)
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
Cc: Guy Chronister <guylovesbritt@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Guy Chronister <guylovesbritt@gmail.com>
---
 sound/pci/oxygen/oxygen_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 4ca12665ff73..64a82688d7fb 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -730,7 +730,7 @@ static int ac97_fp_rec_volume_put(struct snd_kcontrol *ctl,
 	oldreg = oxygen_read_ac97(chip, 1, AC97_REC_GAIN);
 	newreg = oldreg & ~0x0707;
 	newreg = newreg | (value->value.integer.value[0] & 7);
-	newreg = newreg | ((value->value.integer.value[0] & 7) << 8);
+	newreg = newreg | ((value->value.integer.value[1] & 7) << 8);
 	change = newreg != oldreg;
 	if (change)
 		oxygen_write_ac97(chip, 1, AC97_REC_GAIN, newreg);
-- 
2.17.0
