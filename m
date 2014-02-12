From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/20] usb: gadget: Use SNDRV_DEV_CARD for card
	objects
Date: Wed, 12 Feb 2014 11:52:25 +0100
Message-ID: <1392202347-11774-19-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BF822651B7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E4E75AC91
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

... instead of SNDRV_DEV_LOWLEVEL.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/f_midi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_midi.c b/drivers/usb/gadget/f_midi.c
index 807b31c0edc3..f7f79bb99c7e 100644
--- a/drivers/usb/gadget/f_midi.c
+++ b/drivers/usb/gadget/f_midi.c
@@ -672,7 +672,7 @@ static int f_midi_register_card(struct f_midi *midi)
 	}
 	midi->card = card;
 
-	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, midi, &ops);
+	err = snd_device_new(card, SNDRV_DEV_CARD, midi, &ops);
 	if (err < 0) {
 		ERROR(midi, "snd_device_new() failed: error %d\n", err);
 		goto fail;
-- 
1.8.5.2
