From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH v3] us122l: add snd_us122l_free()
Date: Mon, 20 Apr 2009 13:01:21 +0200
Message-ID: <200904201301.22375.fzu@wemgehoertderstaat.de>
References: <200904171456.25980.fzu@wemgehoertderstaat.de>
	<s5hws9jv2a6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout5.freenet.de (mout5.freenet.de [195.4.92.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D74B243C8
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 13:01:29 +0200 (CEST)
In-Reply-To: <s5hws9jv2a6.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Use it to clean up snd_us122l_card_used[].

Without patch unplugging of an US122L soundcard didn't reset the
corresponding element of snd_us122l_card_used[] to 0.
The (SNDRV_CARDS + 1)th plugging in did not result in creating the soundcard
device anymore.
Index values supplied with the modprobe command line were not used correctly
anymore after the first unplugging of an US122L.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: stable@kernel.org
---
 sound/usb/usx2y/us122l.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 012ff1f..a5aae9d 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -474,6 +474,14 @@ static bool us122l_create_card(struct snd_card *card)
 	return true;
 }
 
+static void snd_us122l_free(struct snd_card *card)
+{
+	struct us122l	*us122l = US122L(card);
+	int		index = us122l->chip.index;
+	if (index >= 0  &&  index < SNDRV_CARDS)
+		snd_us122l_card_used[index] = 0;
+}
+
 static int usx2y_create_card(struct usb_device *device, struct snd_card **cardp)
 {
 	int		dev;
@@ -490,7 +498,7 @@ static int usx2y_create_card(struct usb_device *device, struct snd_card **cardp)
 	if (err < 0)
 		return err;
 	snd_us122l_card_used[US122L(card)->chip.index = dev] = 1;
-
+	card->private_free = snd_us122l_free;
 	US122L(card)->chip.dev = device;
 	US122L(card)->chip.card = card;
 	mutex_init(&US122L(card)->mutex);
@@ -584,7 +592,7 @@ static void snd_us122l_disconnect(struct usb_interface *intf)
 	}
 
 	usb_put_intf(intf);
-	usb_put_dev(US122L(card)->chip.dev);
+	usb_put_dev(us122l->chip.dev);
 
 	while (atomic_read(&us122l->mmap_count))
 		msleep(500);
-- 
1.6.0.6
