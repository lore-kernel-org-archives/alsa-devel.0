From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: aloop: Fix inconsistent format due
	to incomplete rule
Date: Fri,  5 Jan 2018 16:54:27 +0100
Message-ID: <20180105155428.14621-3-tiwai@suse.de>
References: <20180105155428.14621-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4137E267A55
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 16:54:31 +0100 (CET)
In-Reply-To: <20180105155428.14621-1-tiwai@suse.de>
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
Cc: Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

The extra hw constraint rule for the formats the aloop driver
introduced has a slight flaw, where it doesn't return a positive value
when the mask got changed.  It came from the fact that it's basically
a copy&paste from snd_hw_constraint_mask64().  The original code is
supposed to be a single-shot and it modifies the mask bits only once
and never after, while what we need for aloop is the dynamic hw rule
that limits the mask bits.

This difference results in the inconsistent state, as the hw_refine
doesn't apply the dependencies fully.  The worse and surprisingly
result is that it causes a crash in OSS emulation when multiple
full-duplex reads/writes are performed concurrently (I leave why it
triggers Oops to readers as a homework).

For fixing this, replace a few open-codes with the standard
snd_mask_*() macros.

Reported-by: syzbot+3902b5220e8ca27889ca@syzkaller.appspotmail.com
Fixes: b1c73fc8e697 ("ALSA: snd-aloop: Fix hw_params restrictions and checking")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 8b6a39cb7f06..006521db487d 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -39,6 +39,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/info.h>
 #include <sound/initval.h>
 
@@ -622,14 +623,12 @@ static int rule_format(struct snd_pcm_hw_params *params,
 {
 
 	struct snd_pcm_hardware *hw = rule->private;
-	struct snd_mask *maskp = hw_param_mask(params, rule->var);
+	struct snd_mask m;
 
-	maskp->bits[0] &= (u_int32_t)hw->formats;
-	maskp->bits[1] &= (u_int32_t)(hw->formats >> 32);
-	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX-64) / 8); /* clear rest */
-	if (! maskp->bits[0] && ! maskp->bits[1])
-		return -EINVAL;
-	return 0;
+	snd_mask_none(&m);
+	m.bits[0] = (u_int32_t)hw->formats;
+	m.bits[1] = (u_int32_t)(hw->formats >> 32);
+	return snd_mask_refine(hw_param_mask(params, rule->var), &m);
 }
 
 static int rule_rate(struct snd_pcm_hw_params *params,
-- 
2.15.1
