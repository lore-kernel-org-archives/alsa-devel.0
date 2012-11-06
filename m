From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400, v2,
	RFC 6/8] usb-audio: Fast Track C400 mixer quirks
Date: Tue,  6 Nov 2012 01:30:37 +0100
Message-ID: <1352161839-1455-7-git-send-email-eldad@fogrefinery.com>
References: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 398DF26167D
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 01:33:41 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so2096111bku.38
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2012 16:33:41 -0800 (PST)
In-Reply-To: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch adds a specific mixer quirk for the M-Audio Fast Track C400
and creates volume controls.
This is a hack to accomodate the unit ID semantics used by the device.
I'd appreciate some hints on how to properly implement this because of
the model used by this device (m*n).

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/mixer.c        |    8 ++++++++
 sound/usb/mixer_quirks.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 5cddc0b..2fdfc8a 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -323,6 +323,10 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request, int v
 	int idx = 0, ret, size;
 	__u8 bRequest;
 
+	/* Fast Track C400 Hack */
+	if (cval->mixer->chip->usb_id == USB_ID(0x0763, 0x2030))
+		validx = (validx & 0xff00) | cval->cmask; /* FIXME */
+
 	if (request == UAC_GET_CUR) {
 		bRequest = UAC2_CS_CUR;
 		size = sizeof(__u16);
@@ -432,6 +436,10 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
 	unsigned char buf[2];
 	int idx = 0, val_len, err, timeout = 10;
 
+	/* Fast Track C400 Hack */
+	if (cval->mixer->chip->usb_id == USB_ID(0x0763, 0x2030))
+		validx = (validx & 0xff00) | cval->cmask; /* FIXME */
+
 	if (cval->mixer->protocol == UAC_VERSION_1) {
 		val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
 	} else { /* UAC_VERSION_2 */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 6807b97..f8ff7f6 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1013,6 +1013,48 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 	}
 }
 
+/* M-Audio Fast Track C400 */
+static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
+{
+	char name[64];
+	unsigned int cmask;
+	int out, chan, err;
+
+	const unsigned int id = 0x40;
+	const int val_type = USB_MIXER_S16;
+	const int control = 1;
+
+	for (chan = 0; chan < 10; chan++) {
+		for (out = 0; out < 6; out++) {
+			if (chan < 6) {
+				snprintf(name, sizeof(name),
+					"DOut%d-AOut%d Playback Volume",
+					chan + 1, out + 1);
+			} else {
+				snprintf(name, sizeof(name),
+					"AIn%d-DOut%d Playback Volume",
+					chan - 5, out + 1);
+			}
+			cmask = out + chan * 6; /* FIXME: abuse of cmask. Sorry about that. */
+			err = snd_create_std_mono_ctl(mixer, id, control,
+						cmask, val_type, name,
+						&snd_usb_mixer_vol_tlv);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+static int snd_c400_create_mixer(struct usb_mixer_interface *mixer)
+{
+	int err = 0;
+	err = snd_c400_create_vol_ctls(mixer);
+
+	return err;
+}
+
 /*
  * The mixer units for Ebox-44 are corrupt, and even where they
  * are valid they presents mono controls as L and R channels of
@@ -1115,6 +1157,10 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_ftu_create_mixer(mixer);
 		break;
 
+	case USB_ID(0x0763, 0x2030): /* M-Audio C400 */
+		err = snd_c400_create_mixer(mixer);
+		break;
+
 	case USB_ID(0x0b05, 0x1739):
 	case USB_ID(0x0b05, 0x1743):
 		err = snd_xonar_u1_controls_create(mixer);
-- 
1.7.8.6
