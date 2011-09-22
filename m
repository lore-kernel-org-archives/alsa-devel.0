From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 1/2] fm801: Fix double free in case of error in
 tuner detection
Date: Thu, 22 Sep 2011 14:38:58 +0100
Message-ID: <1316698738.4122.30.camel@deadeye>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id 6012524654
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 15:39:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hor Jiun Shyong <jiunshyong@gmail.com>, alsa-devel@alsa-project.org, Dan Carpenter <error27@gmail.com>, 641946@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

Commit 9676001559fce06e37c7dc230ab275f605556176
("ALSA: fm801: add error handling if auto-detect fails") added
incorrect error handling.

Once we have successfully called snd_device_new(), the cleanup
function fm801_free() will automatically be called by snd_card_free()
and we must *not* also call fm801_free() directly.

Reported-by: Hor Jiun Shyong <jiunshyong@gmail.com>
References: http://bugs.debian.org/641946
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Cc: stable@kernel.org [v3.0+]
---
 sound/pci/fm801.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index a7ec703..0dd8963 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1236,7 +1236,6 @@ static int __devinit snd_fm801_create(struct snd_card *card,
 	    (tea575x_tuner & TUNER_TYPE_MASK) < 4) {
 		if (snd_tea575x_init(&chip->tea)) {
 			snd_printk(KERN_ERR "TEA575x radio not found\n");
-			snd_fm801_free(chip);
 			return -ENODEV;
 		}
 	} else if ((tea575x_tuner & TUNER_TYPE_MASK) == 0) {
@@ -1251,7 +1250,6 @@ static int __devinit snd_fm801_create(struct snd_card *card,
 		}
 		if (tea575x_tuner == 4) {
 			snd_printk(KERN_ERR "TEA575x radio not found\n");
-			snd_fm801_free(chip);
 			return -ENODEV;
 		}
 	}
-- 
1.7.5.4
