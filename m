From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emu10k1: Fix forgotten user-copy
	conversion in init code
Date: Fri, 18 Aug 2017 11:01:14 +0200
Message-ID: <20170818090114.16749-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 69001267276
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 11:01:17 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B89B9AC40
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 09:01:16 +0000 (UTC)
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

The commit d42fe63d5839 ("ALSA: emu10k1: Get rid of set_fs() usage")
converted the user-space copy hack with set_fs() to the direct
memcpy(), but one place was forgotten.  This resulted in the error
from snd_emu10k1_init_efx(), eventually failed to load the driver.
Fix the missing piece.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196687
Fixes: d42fe63d5839 ("ALSA: emu10k1: Get rid of set_fs() usage")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emufx.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index dc585959ca32..a2b56b188be4 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -698,10 +698,18 @@ static int copy_gctl(struct snd_emu10k1 *emu,
 {
 	struct snd_emu10k1_fx8010_control_old_gpr __user *octl;
 
-	if (emu->support_tlv)
-		return copy_from_user(gctl, &_gctl[idx], sizeof(*gctl));
+	if (emu->support_tlv) {
+		if (in_kernel)
+			memcpy(gctl, (void *)&_gctl[idx], sizeof(*gctl));
+		else if (copy_from_user(gctl, &_gctl[idx], sizeof(*gctl)))
+			return -EFAULT;
+		return 0;
+	}
+
 	octl = (struct snd_emu10k1_fx8010_control_old_gpr __user *)_gctl;
-	if (copy_from_user(gctl, &octl[idx], sizeof(*octl)))
+	if (in_kernel)
+		memcpy(gctl, (void *)&octl[idx], sizeof(*octl));
+	else if (copy_from_user(gctl, &octl[idx], sizeof(*octl)))
 		return -EFAULT;
 	gctl->tlv = NULL;
 	return 0;
-- 
2.14.1
