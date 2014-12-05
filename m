From: Alexander Stein <alexanders83@web.de>
Subject: [PATCH 2/2] ALSA: sound/atmel/ac97c.c: Fix device
	index for pcm
Date: Fri,  5 Dec 2014 15:42:54 +0100
Message-ID: <1417790574-13919-2-git-send-email-alexanders83@web.de>
References: <1417790574-13919-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C0632605D9
 for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2014 15:43:07 +0100 (CET)
In-Reply-To: <1417790574-13919-1-git-send-email-alexanders83@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Alexander Stein <alexanders83@web.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

chip->pdev->id is -1 by default. This is an invalid index resulting in
device file names like /dev/snd/pcmC0D-1p.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
 sound/atmel/ac97c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index ff2f743..fa283d3 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -776,7 +776,7 @@ static int atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
 			return err;
 	}
 	retval = snd_pcm_new(chip->card, chip->card->shortname,
-			chip->pdev->id, playback, capture, &pcm);
+			0, playback, capture, &pcm);
 	if (retval)
 		return retval;
 
-- 
2.2.0
