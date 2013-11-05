From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: mips/ad1843: Use WARN_ON() instead
	of BUG_ON()
Date: Tue,  5 Nov 2013 18:10:42 +0100
Message-ID: <1383671443-13707-5-git-send-email-tiwai@suse.de>
References: <1383671443-13707-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 19379265117
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:47 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E20F0A67F6
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:46 +0100 (CET)
In-Reply-To: <1383671443-13707-1-git-send-email-tiwai@suse.de>
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

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/mips/ad1843.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/mips/ad1843.c b/sound/mips/ad1843.c
index c624510ec374..586907500ca5 100644
--- a/sound/mips/ad1843.c
+++ b/sound/mips/ad1843.c
@@ -276,7 +276,7 @@ static void ad1843_write_multi(struct snd_ad1843 *ad1843, int argcount, ...)
 		if (reg == -1)
 			reg = fp->reg;
 		else
-			BUG_ON(reg != fp->reg);
+			WARN_ON(reg != fp->reg);
 		m = ((1 << fp->nbits) - 1) << fp->lo_bit;
 		mask |= m;
 		bits |= (value << fp->lo_bit) & m;
-- 
1.8.4.2
