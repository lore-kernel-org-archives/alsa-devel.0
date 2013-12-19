From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Add a quirk for Plantronics
	Gamecom 780
Date: Thu, 19 Dec 2013 14:35:04 +0100
Message-ID: <1387460104-26626-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EF8C265475
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 14:35:05 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 050BBABC7
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 13:35:05 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Plantronics Gamecom 780 headset has a firmware problem, and when the
FU 0x09 volume is changed, it results in either too loud or silence
except for a very narrow range.  This patch provides a workaround,
ignoring the node, initialize the volume in a sane value and keep
untouched.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=65251
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer_maps.c | 10 ++++++++++
 sound/usb/quirks.c     | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index cc2dd1f0decb..32af6b741ef5 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -322,6 +322,12 @@ static struct usbmix_name_map hercules_usb51_map[] = {
 	{ 0 }				/* terminator */
 };
 
+/* Plantronics Gamecom 780 has a broken volume control, better to disable it */
+static struct usbmix_name_map gamecom780_map[] = {
+	{ 9, NULL }, /* FU, speaker out */
+	{}
+};
+
 /*
  * Control map entries
  */
@@ -358,6 +364,10 @@ static struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x046d, 0x09a4),
 		.ignore_ctl_error = 1,
 	},
+	{	/* Plantronics GameCom 780 */
+		.id = USB_ID(0x047f, 0xc010),
+		.map = gamecom780_map,
+	},
 	{
 		/* Hercules DJ Console (Windows Edition) */
 		.id = USB_ID(0x06f8, 0xb000),
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0df9ede99dfd..ede753685491 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -660,6 +660,18 @@ static int snd_usb_cm6206_boot_quirk(struct usb_device *dev)
 	return err;
 }
 
+/* quirk for Plantronics GameCom 780 with CM6302 chip */
+static int snd_usb_gamecon780_boot_quirk(struct usb_device *dev)
+{
+	/* set the initial volume and don't change; other values are either
+	 * too loud or silent due to firmware bug (bko#65251)
+	 */
+	u8 buf[2] = { 0x74, 0xdc };
+	return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			UAC_FU_VOLUME << 8, 9 << 8, buf, 2);
+}
+
 /*
  * Novation Twitch DJ controller
  */
@@ -986,6 +998,8 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
 		return snd_usb_nativeinstruments_boot_quirk(dev);
 	case USB_ID(0x0763, 0x2012):  /* M-Audio Fast Track Pro USB */
 		return snd_usb_fasttrackpro_boot_quirk(dev);
+	case USB_ID(0x047f, 0xc010): /* Plantronics Gamecom 780 */
+		return snd_usb_gamecon780_boot_quirk(dev);
 	}
 
 	return 0;
-- 
1.8.5
