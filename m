From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 6/7] ALSA: usb-audio: claim autodetected PCM
 interfaces all at once
Date: Thu, 27 Jun 2013 22:20:13 +0200
Message-ID: <51CC9E7D.60703@ladisch.de>
References: <51CC9D8B.7060601@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 823F4265671
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 22:19:20 +0200 (CEST)
In-Reply-To: <51CC9D8B.7060601@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_card_register() registers all devices newly added since the last
call.  However, the playback/capture streams are handled as one ALSA
device, so the second /dev device will not be registered if the PCM
streams are added in two steps.

QUIRK_AUTODETECT caused the probe callback to be called once for each
interface, which triggered this problem.  Work around this by handling
this like the composite quirk, i.e., autodetecting all other interfaces
that might be used for PCM or MIDI.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/usb/quirks.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 5363bcc..5b01330 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -337,8 +337,7 @@ static int create_auto_midi_quirk(struct snd_usb_audio *chip,

 static int create_autodetect_quirk(struct snd_usb_audio *chip,
 				   struct usb_interface *iface,
-				   struct usb_driver *driver,
-				   const struct snd_usb_audio_quirk *quirk)
+				   struct usb_driver *driver)
 {
 	int err;

@@ -348,6 +347,41 @@ static int create_autodetect_quirk(struct snd_usb_audio *chip,
 	return err;
 }

+static int create_autodetect_quirks(struct snd_usb_audio *chip,
+				    struct usb_interface *iface,
+				    struct usb_driver *driver,
+				    const struct snd_usb_audio_quirk *quirk)
+{
+	int probed_ifnum = get_iface_desc(iface->altsetting)->bInterfaceNumber;
+	int ifcount, ifnum, err;
+
+	err = create_autodetect_quirk(chip, iface, driver);
+	if (err < 0)
+		return err;
+
+	/*
+	 * ALSA PCM playback/capture devices cannot be registered in two steps,
+	 * so we have to claim the other corresponding interface here.
+	 */
+	ifcount = chip->dev->actconfig->desc.bNumInterfaces;
+	for (ifnum = 0; ifnum < ifcount; ifnum++) {
+		if (ifnum == probed_ifnum || quirk->ifnum >= 0)
+			continue;
+		iface = usb_ifnum_to_if(chip->dev, ifnum);
+		if (!iface ||
+		    usb_interface_claimed(iface) ||
+		    get_iface_desc(iface->altsetting)->bInterfaceClass !=
+							USB_CLASS_VENDOR_SPEC)
+			continue;
+
+		err = create_autodetect_quirk(chip, iface, driver);
+		if (err >= 0)
+			usb_driver_claim_interface(driver, iface, (void *)-1L);
+	}
+
+	return 0;
+}
+
 /*
  * Create a stream for an Edirol UA-700/UA-25/UA-4FX interface.
  * The only way to detect the sample rate is by looking at wMaxPacketSize.
@@ -476,7 +510,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
 	static const quirk_func_t quirk_funcs[] = {
 		[QUIRK_IGNORE_INTERFACE] = ignore_interface_quirk,
 		[QUIRK_COMPOSITE] = create_composite_quirk,
-		[QUIRK_AUTODETECT] = create_autodetect_quirk,
+		[QUIRK_AUTODETECT] = create_autodetect_quirks,
 		[QUIRK_MIDI_STANDARD_INTERFACE] = create_any_midi_quirk,
 		[QUIRK_MIDI_FIXED_ENDPOINT] = create_any_midi_quirk,
 		[QUIRK_MIDI_YAMAHA] = create_any_midi_quirk,
