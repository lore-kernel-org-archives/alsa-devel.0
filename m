From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400,
	RFC 4/6] usb-audio: Fast Track C400 mixer ranges
Date: Sat,  3 Nov 2012 14:40:09 +0100
Message-ID: <1351950011-8915-5-git-send-email-eldad@fogrefinery.com>
References: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 943E92625E2
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2012 14:40:38 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so1459057bku.38
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 06:40:38 -0700 (PDT)
In-Reply-To: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Chris Cavey <chris-alsa@rauros.net>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Add ranges for various Fast Track C400 controls, as observed
while using the vendor's mixer control software (res values
are an estimation).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 9bbc981..5cddc0b 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -800,6 +800,42 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 				  struct snd_kcontrol *kctl)
 {
 	switch (cval->mixer->chip->usb_id) {
+	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
+		if (strcmp(kctl->id.name, "Effect Duration") == 0) {
+			snd_printk(KERN_INFO
+				"usb-audio: set quirk for C400 Effect Duration\n");
+			cval->min = 0x0000;
+			cval->max = 0xffff;
+			cval->res = 0x00e6;
+			break;
+		}
+		if (strcmp(kctl->id.name, "Effect Volume") == 0 ||
+		    strcmp(kctl->id.name, "Effect Feedback Volume") == 0) {
+			snd_printk(KERN_INFO
+				"usb-audio: set quirks for C400 Effect Feedback/Volume\n");
+			cval->min = 0x00;
+			cval->max = 0xff;
+			break;
+		}
+		if (strstr(kctl->id.name, "Effect Return") != NULL) {
+			snd_printk(KERN_INFO
+				"usb-audio: set quirks for C400 %s\n", kctl->id.name);
+			cval->min = 0xb706;
+			cval->max = 0xff7b;
+			cval->res = 0x0073;
+			break;
+		}
+		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
+			(strstr(kctl->id.name, "Effect Send") != NULL)) {
+			snd_printk(KERN_INFO
+				"usb-audio: set quirk for Fast Track C400 %s\n",
+				kctl->id.name);
+			cval->min = 0xb5fb; /* -73 dB = 0xb6ff */
+			cval->max = 0xfcfe;
+			cval->res = 0x0073;
+		}
+		break;
+
 	case USB_ID(0x0763, 0x2081): /* M-Audio Fast Track Ultra 8R */
 	case USB_ID(0x0763, 0x2080): /* M-Audio Fast Track Ultra */
 		if (strcmp(kctl->id.name, "Effect Duration") == 0) {
-- 
1.7.8.6
