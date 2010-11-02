From: emailmandar@gmail.com
Subject: [PATCH - snd-usb-audio 1/1] Support for Power/Status
	LED on Creative USB X-Fi S51
Date: Tue,  2 Nov 2010 14:43:19 +0000
Message-ID: <4ccfd3f9.08c08e0a.6411.4671@mx.google.com>
References: <AANLkTimSV=kLdWxWqhQ=vsptZBiyG2JJJ9t9eVQj9vTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <AANLkTimSV=kLdWxWqhQ=vsptZBiyG2JJJ9t9eVQj9vTQ@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mandar Joshi <emailmandar@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Mandar Joshi <emailmandar@gmail.com>

 Sending patch for sound-2.6 tree
 This patch adds support for Power/Status LED on Creative USB X-Fi S51.
 There is just one LED on the device. The LED can either be On or it can be set to Blink. There doesn't
 seem to be a way to switch it off.
 The control message to change LED status is similar to that of audigy2nx except that the index is to be
 set to 0 and value is 1 for Blink and 0 for On.
 The 'Power LED' control in alsamixer when muted will cause the LED to Blink continuously. When unmuted
 the LED will stay On. The Creative driver under Windows sets the LED to blink whenever audio is muted.
 This LED can be treated as the CMSS LED but I figured since there is just one LED, it should be treated
 as the Power LED. Is that alright?
 I've also changed the comment "Usb X-Fi" to "Usb X-Fi S51" as there are other external X-Fi devices from
 Creative like Usb X-Fi Go and Xmod. The volume knob and LED support patch doesn't apply to them.


Signed-off-by: Mandar Joshi <emailmandar@gmail.com>

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 7dae05d..8ed0194 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -60,7 +60,7 @@ static const struct rc_config {
 	{ USB_ID(0x041e, 0x3000), 0, 1, 2, 1,  18, 0x0013 }, /* Extigy       */
 	{ USB_ID(0x041e, 0x3020), 2, 1, 6, 6,  18, 0x0013 }, /* Audigy 2 NX  */
 	{ USB_ID(0x041e, 0x3040), 2, 2, 6, 6,  2,  0x6e91 }, /* Live! 24-bit */
-	{ USB_ID(0x041e, 0x3042), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi */
+	{ USB_ID(0x041e, 0x3042), 0, 1, 1, 1,  1,  0x000d }, /* Usb X-Fi S51 */
 	{ USB_ID(0x041e, 0x3048), 2, 2, 6, 6,  2,  0x6e91 }, /* Toshiba SB0500 */
 };
 
@@ -183,7 +183,13 @@ static int snd_audigy2nx_led_put(struct snd_kcontrol *kcontrol, struct snd_ctl_e
 	if (value > 1)
 		return -EINVAL;
 	changed = value != mixer->audigy2nx_leds[index];
-	err = snd_usb_ctl_msg(mixer->chip->dev,
+	if (mixer->chip->usb_id == USB_ID(0x041e,0x3042))
+		err = snd_usb_ctl_msg(mixer->chip->dev,
+			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      !value, 0, NULL, 0, 100);
+	else
+		err = snd_usb_ctl_msg(mixer->chip->dev,
 			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      value, index + 2, NULL, 0, 100);
@@ -225,8 +231,12 @@ static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
 	int i, err;
 
 	for (i = 0; i < ARRAY_SIZE(snd_audigy2nx_controls); ++i) {
+		/* USB X-Fi S51 doesn't have a CMSS LED */
+		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x3042)) && i == 0)
+			continue;
 		if (i > 1 && /* Live24ext has 2 LEDs only */
 			(mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
+			 mixer->chip->usb_id == USB_ID(0x041e, 0x3042) ||
 			 mixer->chip->usb_id == USB_ID(0x041e, 0x3048)))
 			break; 
 		err = snd_ctl_add(mixer->chip->card,
@@ -365,6 +375,7 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 
 	if (mixer->chip->usb_id == USB_ID(0x041e, 0x3020) ||
 	    mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
+	    mixer->chip->usb_id == USB_ID(0x041e, 0x3042) ||
 	    mixer->chip->usb_id == USB_ID(0x041e, 0x3048)) {
 		if ((err = snd_audigy2nx_controls_create(mixer)) < 0)
 			return err;
-- 
1.7.1
