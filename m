From: wbreyha@gmx.net
Subject: [PATCH - usb 1/1] Terratec Aureon 7.1 USB ID added for
	C-Media cm6206 quirks
Date: Thu, 28 Apr 2011 16:18:40 +0200
Message-ID: <1304000320-25970-1-git-send-email-wbreyha@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Wolfgang Breyha <wbreyha@gmx.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Wolfgang Breyha <wbreyha@gmx.net>

Hi!

This patch adds support for the
Terratec Aureon 7.1 USB
which uses a C-Media cm6206 and needs all the quirks already found in the past.

Greetings,
Wolfgang Breyha

Signed-off-by: Wolfgang Breyha <wbreyha@gmx.net>

diff --git a/sound/usb/format.c b/sound/usb/format.c
index 5b792d2..f079b5e 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -176,9 +176,11 @@ static int parse_audio_format_rates_v1(struct snd_usb_audio *chip, struct audiof
 			if (!rate)
 				continue;
 			/* C-Media CM6501 mislabels its 96 kHz altsetting */
+			/* Terratec Aureon 7.1 USB C-Media 6206, too */
 			if (rate == 48000 && nr_rates == 1 &&
 			    (chip->usb_id == USB_ID(0x0d8c, 0x0201) ||
-			     chip->usb_id == USB_ID(0x0d8c, 0x0102)) &&
+			     chip->usb_id == USB_ID(0x0d8c, 0x0102) ||
+			     chip->usb_id == USB_ID(0x0ccd, 0x00b1)) &&
 			    fp->altsetting == 5 && fp->maxpacksize == 392)
 				rate = 96000;
 			/* Creative VF0470 Live Cam reports 16 kHz instead of 8kHz */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 355759b..916b6a4 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -533,6 +533,7 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 
 	case USB_ID(0x0d8c, 0x0102):
 		/* C-Media CM6206 / CM106-Like Sound Device */
+	case USB_ID(0x0ccd, 0x00b1): /* Terratec Aureon 7.1 USB */
 		return snd_usb_cm6206_boot_quirk(dev);
 
 	case USB_ID(0x133e, 0x0815):
-- 
1.7.4.4
