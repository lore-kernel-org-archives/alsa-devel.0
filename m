From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: 6fire: remove unused variable card
Date: Mon, 16 Oct 2017 13:35:58 +0100
Message-ID: <20171016123558.12928-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Markus Elfring <elfring@users.sourceforge.net>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The pointer card is being assigned a value but it is never used.
Remove this redundant variable. Cleans up clang warning:
Value stored to 'card' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/usb/6fire/chip.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index c7641cb50616..17d5e3ee6d73 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -174,11 +174,9 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 static void usb6fire_chip_disconnect(struct usb_interface *intf)
 {
 	struct sfire_chip *chip;
-	struct snd_card *card;
 
 	chip = usb_get_intfdata(intf);
 	if (chip) { /* if !chip, fw upload has been performed */
-		card = chip->card;
 		chip->intf_count--;
 		if (!chip->intf_count) {
 			mutex_lock(&register_mutex);
-- 
2.14.1
