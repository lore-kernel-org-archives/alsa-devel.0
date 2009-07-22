From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH] Volume control quirk for QuickCam E 3500
Date: Wed, 22 Jul 2009 14:18:33 +0200
Message-ID: <1248265113-9972-1-git-send-email-bug-track@fisher-privat.net>
References: <s5hfxcp0wtx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id D06CE24464
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 14:18:38 +0200 (CEST)
In-Reply-To: <s5hfxcp0wtx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, clemens@ladisch.de, alsa-devel@alsa-project.org
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

- E3500 report cval->max more than it actually can handel, so if you
set 95% capture level it will be silently muted.
- Betwen cval->min and cval-max(real) is 2940 control units,
but real are only 7 with cval->res = 384.
- Alsa can't handel less than 10 controls, so make it more
and set cval->res = 192.

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 sound/usb/usbmixer.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/usb/usbmixer.c b/sound/usb/usbmixer.c
index 5c48199..79e5b6d 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/usbmixer.c
@@ -1000,20 +1000,38 @@ static void build_feature_ctl(struct mixer_build *state, unsigned char *desc,
 		break;
 	}
 
-	/* quirk for UDA1321/N101 */
-	/* note that detection between firmware 2.1.1.7 (N101) and later 2.1.1.21 */
-	/* is not very clear from datasheets */
-	/* I hope that the min value is -15360 for newer firmware --jk */
+	/* volume control quirks */
 	switch (state->chip->usb_id) {
 	case USB_ID(0x0471, 0x0101):
+		break;
 	case USB_ID(0x0471, 0x0104):
+		break;
 	case USB_ID(0x0471, 0x0105):
+		break;
 	case USB_ID(0x0672, 0x1041):
+	/* quirk for UDA1321/N101.
+	 * note that detection between firmware 2.1.1.7 (N101)
+	 * and later 2.1.1.21 is not very clear from datasheets.
+	 * I hope that the min value is -15360 for newer firmware --jk
+	 */
 		if (!strcmp(kctl->id.name, "PCM Playback Volume") &&
 		    cval->min == -15616) {
-			snd_printk(KERN_INFO "using volume control quirk for the UDA1321/N101 chip\n");
+			snd_printk(KERN_INFO
+				 "set volume quirk for UDA1321/N101 chip\n");
 			cval->max = -256;
 		}
+		break;
+
+	case USB_ID(0x046d, 0x09a4):
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			snd_printk(KERN_INFO
+				"set volume quirk for QuickCam E3500\n");
+			cval->min = 6080;
+			cval->max = 8768;
+			cval->res = 192;
+		}
+		break;
+
 	}
 
 	snd_printdd(KERN_INFO "[%d] FU [%s] ch = %d, val = %d/%d/%d\n",
-- 
1.6.3.3
