From: Andrea Borgia <andrea@borgia.bo.it>
Subject: [PATCH - SB-0500 1/1] preliminary support for Toshiba
	SB-0500 (remote works)
Date: Mon,  5 Jan 2009 21:28:09 +0100
Message-ID: <1231187289-29641-1-git-send-email-andrea@borgia.bo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <>
References: <>
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
Cc: alsa-devel@alsa-project.org, Andrea Borgia <andrea@borgia.bo.it>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Andrea Borgia <andrea@borgia.bo.it>

diff --git a/usb/usbmixer.c b/usb/usbmixer.c
index a492461..6490a74 100644
--- a/usb/usbmixer.c
+++ b/usb/usbmixer.c
@@ -66,6 +66,7 @@ static const struct rc_config {
 	{ USB_ID(0x041e, 0x3000), 0, 1, 2, 1,  18, 0x0013 }, /* Extigy       */
 	{ USB_ID(0x041e, 0x3020), 2, 1, 6, 6,  18, 0x0013 }, /* Audigy 2 NX  */
 	{ USB_ID(0x041e, 0x3040), 2, 2, 6, 6,  2,  0x6e91 }, /* Live! 24-bit */
+	{ USB_ID(0x041e, 0x3048), 2, 2, 6, 6,  2,  0x6e91 }, /* Toshiba SB0500 */
 };
 
 struct usb_mixer_interface {
@@ -1706,7 +1707,8 @@ static void snd_usb_mixer_memory_change(struct usb_mixer_interface *mixer,
 		break;
 	/* live24ext: 4 = line-in jack */
 	case 3:	/* hp-out jack (may actuate Mute) */
-		if (mixer->chip->usb_id == USB_ID(0x041e, 0x3040))
+		if (mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
+		    mixer->chip->usb_id == USB_ID(0x041e, 0x3048))
 			snd_usb_mixer_notify_id(mixer, mixer->rc_cfg->mute_mixer_id);
 		break;
 	default:
@@ -1957,8 +1959,9 @@ static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
 	int i, err;
 
 	for (i = 0; i < ARRAY_SIZE(snd_audigy2nx_controls); ++i) {
-		if (i > 1 &&  /* Live24ext has 2 LEDs only */
-			mixer->chip->usb_id == USB_ID(0x041e, 0x3040))
+		if (i > 1 && /* Live24ext has 2 LEDs only */
+			(mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
+			 mixer->chip->usb_id == USB_ID(0x041e, 0x3048)))
 			break; 
 		err = snd_ctl_add(mixer->chip->card,
 				  snd_ctl_new1(&snd_audigy2nx_controls[i], mixer));
@@ -1995,7 +1998,8 @@ static void snd_audigy2nx_proc_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "%s jacks\n\n", mixer->chip->card->shortname);
 	if (mixer->chip->usb_id == USB_ID(0x041e, 0x3020))
 		jacks = jacks_audigy2nx;
-	else if (mixer->chip->usb_id == USB_ID(0x041e, 0x3040))
+	else if (mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
+		 mixer->chip->usb_id == USB_ID(0x041e, 0x3048))
 		jacks = jacks_live24ext;
 	else
 		return;
@@ -2045,7 +2049,8 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 		goto _error;
 
 	if (mixer->chip->usb_id == USB_ID(0x041e, 0x3020) ||
-	    mixer->chip->usb_id == USB_ID(0x041e, 0x3040)) {
+	    mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
+	    mixer->chip->usb_id == USB_ID(0x041e, 0x3048)) {
 		struct snd_info_entry *entry;
 
 		if ((err = snd_audigy2nx_controls_create(mixer)) < 0)
diff --git a/usb/usbmixer_maps.c b/usb/usbmixer_maps.c
index d755be0..f41214f 100644
--- a/usb/usbmixer_maps.c
+++ b/usb/usbmixer_maps.c
@@ -285,6 +285,11 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.map = live24ext_map,
 	},
 	{
+		.id = USB_ID(0x041e, 0x3048),
+		.map = audigy2nx_map,
+		.selector_map = audigy2nx_selectors,
+	},
+	{
 		/* Hercules DJ Console (Windows Edition) */
 		.id = USB_ID(0x06f8, 0xb000),
 		.ignore_ctl_error = 1,
-- 
1.5.4.3
