From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/5] ALSA: snd_usb_caiaq: give better longname
Date: Sat, 30 May 2009 22:06:19 +0200
Message-ID: <1243713980-25354-4-git-send-email-daniel@caiaq.de>
References: <1243713980-25354-1-git-send-email-daniel@caiaq.de>
	<1243713980-25354-2-git-send-email-daniel@caiaq.de>
	<1243713980-25354-3-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 84714103809
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 22:07:11 +0200 (CEST)
In-Reply-To: <1243713980-25354-3-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The serial number is of no interest in the longname, remove it. This
gives space for the usb patrh information which is more informative.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/device.c |   17 ++++++-----------
 sound/usb/caiaq/device.h |    1 -
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index d55724a..9557c98 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -382,10 +382,10 @@ static int create_card(struct usb_device* usb_dev, struct snd_card **cardp)
 
 static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 {
-	char *c;
+	char *c, usbpath[32];
 	struct usb_device *usb_dev = dev->chip.dev;
 	struct snd_card *card = dev->chip.card;
-	int err, len;
+	int err;
 
 	if (usb_set_interface(usb_dev, 0, 1) != 0) {
 		log("can't set alt interface.\n");
@@ -440,16 +440,11 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 		if (*c == ' ')
 			*c = '_';
 
-	len = snprintf(card->longname, sizeof(card->longname),
-		       "%s %s (serial %s, ",
-		       dev->vendor_name, dev->product_name, dev->serial);
-
-	if (len < sizeof(card->longname) - 2)
-		len += usb_make_path(usb_dev, card->longname + len,
-				     sizeof(card->longname) - len);
+	usb_make_path(usb_dev, usbpath, sizeof(usbpath));
+	snprintf(card->longname, sizeof(card->longname),
+		       "%s %s (%s)",
+		       dev->vendor_name, dev->product_name, usbpath);
 
-	card->longname[len++] = ')';
-	card->longname[len] = '\0';
 	setup_card(dev);
 	return 0;
 }
diff --git a/sound/usb/caiaq/device.h b/sound/usb/caiaq/device.h
index 4cce1ad..ece7351 100644
--- a/sound/usb/caiaq/device.h
+++ b/sound/usb/caiaq/device.h
@@ -81,7 +81,6 @@ struct snd_usb_caiaqdev {
 
 	char vendor_name[CAIAQ_USB_STR_LEN];
 	char product_name[CAIAQ_USB_STR_LEN];
-	char serial[CAIAQ_USB_STR_LEN];
 
 	int n_streams, n_audio_in, n_audio_out;
 	int streaming, first_packet, output_running;
-- 
1.6.3.1
