From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, PATCH RFC,
	v4 08/10] usb-audio: Fast Track C400 mixer ranges
Date: Wed, 28 Nov 2012 23:55:39 +0100
Message-ID: <1354143341-1623-9-git-send-email-eldad@fogrefinery.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3D0264F4A
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 23:56:08 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5643893bkc.38
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 14:56:08 -0800 (PST)
In-Reply-To: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: Grant Diffey <gdiffey@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Add ranges for various Fast Track C400 controls, as observed
while using the vendor's mixer control software (res values
are an estimation).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 4eacbe2..feed500 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -806,6 +806,33 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 				  struct snd_kcontrol *kctl)
 {
 	switch (cval->mixer->chip->usb_id) {
+	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
+		if (strcmp(kctl->id.name, "Effect Duration") == 0) {
+			cval->min = 0x0000;
+			cval->max = 0xffff;
+			cval->res = 0x00e6;
+			break;
+		}
+		if (strcmp(kctl->id.name, "Effect Volume") == 0 ||
+		    strcmp(kctl->id.name, "Effect Feedback Volume") == 0) {
+			cval->min = 0x00;
+			cval->max = 0xff;
+			break;
+		}
+		if (strstr(kctl->id.name, "Effect Return") != NULL) {
+			cval->min = 0xb706;
+			cval->max = 0xff7b;
+			cval->res = 0x0073;
+			break;
+		}
+		if ((strstr(kctl->id.name, "Playback Volume") != NULL) ||
+			(strstr(kctl->id.name, "Effect Send") != NULL)) {
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
