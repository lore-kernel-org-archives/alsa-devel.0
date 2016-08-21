From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] ALSA: usb-audio: rmove print for failure of
	kmalloc
Date: Sun, 21 Aug 2016 10:17:36 +0800
Message-ID: <1471745856-30083-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 712AB2654CE
 for <alsa-devel@alsa-project.org>; Sun, 21 Aug 2016 04:22:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

kmalloc already print similar error once failing to alloc
enough memory, so let's remove this dump here.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 sound/usb/format.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 789d19e..2c44386 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -176,10 +176,8 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 		int r, idx;
 
 		fp->rate_table = kmalloc(sizeof(int) * nr_rates, GFP_KERNEL);
-		if (fp->rate_table == NULL) {
-			usb_audio_err(chip, "cannot malloc\n");
+		if (fp->rate_table == NULL)
 			return -ENOMEM;
-		}
 
 		fp->nr_rates = 0;
 		fp->rate_min = fp->rate_max = 0;
-- 
2.3.7
