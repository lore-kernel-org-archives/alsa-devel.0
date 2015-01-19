From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/18] ALSA: usb-audio: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:30 +0100
Message-ID: <1421665891-14475-18-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA312606FB
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:37 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3DFC3ADB5
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:36 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 5bfb695547f8..417ebb11cf48 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2292,14 +2292,13 @@ int snd_usbmidi_create(struct snd_card *card,
 	umidi->iface = iface;
 	umidi->quirk = quirk;
 	umidi->usb_protocol_ops = &snd_usbmidi_standard_ops;
-	init_timer(&umidi->error_timer);
 	spin_lock_init(&umidi->disc_lock);
 	init_rwsem(&umidi->disc_rwsem);
 	mutex_init(&umidi->mutex);
 	umidi->usb_id = USB_ID(le16_to_cpu(umidi->dev->descriptor.idVendor),
 			       le16_to_cpu(umidi->dev->descriptor.idProduct));
-	umidi->error_timer.function = snd_usbmidi_error_timer;
-	umidi->error_timer.data = (unsigned long)umidi;
+	setup_timer(&umidi->error_timer, snd_usbmidi_error_timer,
+		    (unsigned long)umidi);
 
 	/* detect the endpoint(s) to use */
 	memset(endpoints, 0, sizeof(endpoints));
-- 
2.2.1
