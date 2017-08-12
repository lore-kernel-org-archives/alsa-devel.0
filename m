From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: mpu401: Delete an error message for
 a failed memory allocation in snd_mpu401_uart_new()
Date: Sat, 12 Aug 2017 21:11:36 +0200
Message-ID: <3d183343-50cf-1683-fade-1dbbee33dfba@users.sourceforge.net>
References: <47947226-bd09-5d15-c0d2-a9f4a659e1b4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D319126701A
 for <alsa-devel@alsa-project.org>; Sat, 12 Aug 2017 21:12:12 +0200 (CEST)
In-Reply-To: <47947226-bd09-5d15-c0d2-a9f4a659e1b4@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 12 Aug 2017 20:20:11 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/drivers/mpu401/mpu401_uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 3a7c317ae012..cc347386fc2b 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -545,7 +545,6 @@ int snd_mpu401_uart_new(struct snd_card *card, int device,
 		return err;
 	mpu = kzalloc(sizeof(*mpu), GFP_KERNEL);
 	if (mpu == NULL) {
-		snd_printk(KERN_ERR "mpu401_uart: cannot allocate\n");
 		snd_device_free(card, rmidi);
 		return -ENOMEM;
 	}
-- 
2.14.0
