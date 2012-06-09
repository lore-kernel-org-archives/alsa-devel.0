From: Mark Hills <mark@pogo.org.uk>
Subject: [PATCH 2/2] usb-audio: Convert table to preferred C99
	format
Date: Sat,  9 Jun 2012 13:16:39 +0100
Message-ID: <1339244199-14749-2-git-send-email-mark@pogo.org.uk>
References: <alpine.LNX.2.01.1206091310410.13043@stax.localdomain>
	<1339244199-14749-1-git-send-email-mark@pogo.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1339244199-14749-1-git-send-email-mark@pogo.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
 sound/usb/mixer_quirks.c |   74 +++++++++++++++++++++++++++++++++++++++------
 1 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ce7d96f..690000d 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -967,19 +967,73 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
  * stereo. So we provide a good mixer here.
  */
 struct std_mono_table ebox44_table[] = {
-	{ 4, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Headphone Playback Switch", NULL },
-	{ 4, 2, 0x1, USB_MIXER_S16, "Headphone A Mix Playback Volume", NULL },
-	{ 4, 2, 0x2, USB_MIXER_S16, "Headphone B Mix Playback Volume", NULL },
+	{
+		.unitid = 4,
+		.control = 1,
+		.cmask = 0x0,
+		.val_type = USB_MIXER_INV_BOOLEAN,
+		.name = "Headphone Playback Switch"
+	},
+	{
+		.unitid = 4,
+		.control = 2,
+		.cmask = 0x1,
+		.val_type = USB_MIXER_S16,
+		.name = "Headphone A Mix Playback Volume"
+	},
+	{
+		.unitid = 4,
+		.control = 2,
+		.cmask = 0x2,
+		.val_type = USB_MIXER_S16,
+		.name = "Headphone B Mix Playback Volume"
+	},
 
-	{ 7, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Output Playback Switch", NULL },
-	{ 7, 2, 0x1, USB_MIXER_S16, "Output A Playback Volume", NULL },
-	{ 7, 2, 0x2, USB_MIXER_S16, "Output B Playback Volume", NULL },
+	{
+		.unitid = 7,
+		.control = 1,
+		.cmask = 0x0,
+		.val_type = USB_MIXER_INV_BOOLEAN,
+		.name = "Output Playback Switch"
+	},
+	{
+		.unitid = 7,
+		.control = 2,
+		.cmask = 0x1,
+		.val_type = USB_MIXER_S16,
+		.name = "Output A Playback Volume"
+	},
+	{
+		.unitid = 7,
+		.control = 2,
+		.cmask = 0x2,
+		.val_type = USB_MIXER_S16,
+		.name = "Output B Playback Volume"
+	},
 
-	{ 10, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Input Capture Switch", NULL },
-	{ 10, 2, 0x1, USB_MIXER_S16, "Input A Capture Volume", NULL },
-	{ 10, 2, 0x2, USB_MIXER_S16, "Input B Capture Volume", NULL },
+	{
+		.unitid = 10,
+		.control = 1,
+		.cmask = 0x0,
+		.val_type = USB_MIXER_INV_BOOLEAN,
+		.name = "Input Capture Switch"
+	},
+	{
+		.unitid = 10,
+		.control = 2,
+		.cmask = 0x1,
+		.val_type = USB_MIXER_S16,
+		.name = "Input A Capture Volume"
+	},
+	{
+		.unitid = 10,
+		.control = 2,
+		.cmask = 0x2,
+		.val_type = USB_MIXER_S16,
+		.name = "Input B Capture Volume"
+	},
 
-	{ }
+	{}
 };
 
 int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
-- 
1.7.4.4
