From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/6] [ALSA] portman2x4 - NULL check
Date: Thu,  7 Jan 2016 12:45:49 +0530
Message-ID: <1452150951-1571-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452150951-1571-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

Instead of checking var == NULL, the kernel coding style recommends
writing it as !var.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/drivers/portman2x4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 65b0650..985cf67 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -105,7 +105,7 @@ static int portman_create(struct snd_card *card,
 	*rchip = NULL;
 
 	pm = kzalloc(sizeof(struct portman), GFP_KERNEL);
-	if (pm == NULL)
+	if (!pm)
 		return -ENOMEM;
 
 	/* Init chip specific data */
@@ -764,7 +764,7 @@ static int snd_portman_probe(struct platform_device *pdev)
 					 snd_portman_interrupt, /* ISR */
 					 PARPORT_DEV_EXCL,      /* flags */
 					 (void *)card);         /* private */
-	if (pardev == NULL) {
+	if (!pardev) {
 		snd_printd("Cannot register pardevice\n");
 		err = -EIO;
 		goto __err;
-- 
1.9.1
