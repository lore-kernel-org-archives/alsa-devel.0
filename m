From: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] ALSA: intel8x0: fix a redundant check bug
Date: Tue,  9 Oct 2018 09:35:52 -0500
Message-ID: <1539095754-5609-1-git-send-email-wang6495@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In snd_intel8x0_codec_semaphore(), the parameter 'codec' is firstly
checked to see whether it is greater than 2. If yes, an error code EIO is
returned. Otherwise, 'chip->in_sdin_init' is further checked. If
'chip->in_sdin_init' is not zero, 'codec' is updated immediately with
'chip->codec_isr_bits'. That means, the parameter 'codec' is not used in
this branch. Actually, it is only used in the else branch when
'chip->in_sdin_init' is zero. Thus, the check on the parameter 'codec' is
redundant if 'chip->in_sdin_init' is not zero. This can cause potential
incorrect execution in this function. Suppose the parameter 'codec' is 3,
which is greater than 2, and 'chip->in_sdin_init' is not zero. The current
version of this function will return EIO after the first check because
'codec' is greater than 2. However, since 'codec' will be updated in the
following execution when 'chip->in_sdin_init' is not zero, this check will
be meaningless and the execution should continue, instead of returning the
error code EIO.

This patch avoids the above issue by moving the check on the parameter
'codec' to the else branch of the if statement that checks
'chip->in_sdin_init'.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/pci/intel8x0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 5ee468d..f619e58 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -515,13 +515,13 @@ static int snd_intel8x0_codec_semaphore(struct intel8x0 *chip, unsigned int code
 {
 	int time;
 	
-	if (codec > 2)
-		return -EIO;
 	if (chip->in_sdin_init) {
 		/* we don't know the ready bit assignment at the moment */
 		/* so we check any */
 		codec = chip->codec_isr_bits;
 	} else {
+		if (codec > 2)
+			return -EIO;
 		codec = chip->codec_bit[chip->ac97_sdin[codec]];
 	}
 
-- 
2.7.4
