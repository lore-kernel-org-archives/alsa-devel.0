From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Don't actually write registers for
	caps overwrites
Date: Wed, 10 Jun 2015 10:34:46 +0200
Message-ID: <1433925286-5482-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D17E26072A
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 10:34:53 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C4CB8ADD0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 08:34:52 +0000 (UTC)
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

Along with the transition to regmap for managing the cached parameter
reads, the caps overwrite was also moved to regmap cache.  The cache
change itself works, but it still tries to write the non-existing verb
(the HDA parameter is read-only) wrongly.  It's harmless in most
cases, but some chips are picky and may result in the codec
communication stall.

This patch avoids it just by adding the missing flag check in
reg_write ops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_regmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 7371e0c3926f..c4f5e61d4404 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -265,6 +265,9 @@ static int hda_reg_write(void *context, unsigned int reg, unsigned int val)
 	unsigned int verb;
 	int i, bytes, err;
 
+	if (codec->caps_overwriting)
+		return 0;
+
 	reg &= ~0x00080000U; /* drop GET bit */
 	reg |= (codec->addr << 28);
 	verb = get_verb(reg);
-- 
2.4.3
