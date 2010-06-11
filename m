From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/4] ALSA: usb-audio: fix control messages for
	USB_RECIP_INTERFACE
Date: Fri, 11 Jun 2010 15:33:09 +0200
Message-ID: <1276263191-8652-3-git-send-email-daniel@caiaq.de>
References: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9642C1039C7
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 15:33:44 +0200 (CEST)
In-Reply-To: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Control messages directed to an interface must have the interface number
set in the lower 8 bits of wIndex. This wasn't done correctly for some
clock and mixer messages.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Reported-by: Alex Lee <alexlee188@gmail.com>
---
 sound/usb/clock.c  |   12 ++++++++----
 sound/usb/format.c |    6 ++++--
 sound/usb/helper.h |    4 ++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index b7aadd6..b585511 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -103,7 +103,8 @@ static int uac_clock_selector_get_val(struct snd_usb_audio *chip, int selector_i
 	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0),
 			      UAC2_CS_CUR,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
-			      UAC2_CX_CLOCK_SELECTOR << 8, selector_id << 8,
+			      UAC2_CX_CLOCK_SELECTOR << 8,
+			      snd_usb_ctrl_intf(chip) | (selector_id << 8),
 			      &buf, sizeof(buf), 1000);
 
 	if (ret < 0)
@@ -120,7 +121,8 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-			      UAC2_CS_CONTROL_CLOCK_VALID << 8, source_id << 8,
+			      UAC2_CS_CONTROL_CLOCK_VALID << 8,
+			      snd_usb_ctrl_intf(chip) | (source_id << 8),
 			      &data, sizeof(data), 1000);
 
 	if (err < 0) {
@@ -269,7 +271,8 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 	data[3] = rate >> 24;
 	if ((err = snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), UAC2_CS_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-				   UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
+				   UAC2_CS_CONTROL_SAM_FREQ << 8,
+				   snd_usb_ctrl_intf(chip) | (clock << 8),
 				   data, sizeof(data), 1000)) < 0) {
 		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2)\n",
 			   dev->devnum, iface, fmt->altsetting, rate);
@@ -278,7 +281,8 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 
 	if ((err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 				   USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-				   UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
+				   UAC2_CS_CONTROL_SAM_FREQ << 8,
+				   snd_usb_ctrl_intf(chip) | (clock << 8),
 				   data, sizeof(data), 1000)) < 0) {
 		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
 			   dev->devnum, iface, fmt->altsetting);
diff --git a/sound/usb/format.c b/sound/usb/format.c
index df5b29f..8eccf17 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -227,7 +227,8 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	/* get the number of sample rates first by only fetching 2 bytes */
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-			      UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
+			      UAC2_CS_CONTROL_SAM_FREQ << 8,
+			      snd_usb_ctrl_intf(chip) | (clock << 8),
 			      tmp, sizeof(tmp), 1000);
 
 	if (ret < 0) {
@@ -247,7 +248,8 @@ static int parse_audio_format_rates_v2(struct snd_usb_audio *chip,
 	/* now get the full information */
 	ret = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_RANGE,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
-			      UAC2_CS_CONTROL_SAM_FREQ << 8, clock << 8,
+			      UAC2_CS_CONTROL_SAM_FREQ << 8,
+			      snd_usb_ctrl_intf(chip) | (clock << 8),
 			      data, data_size, 1000);
 
 	if (ret < 0) {
diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index a6b0e51..09bd943 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -28,5 +28,9 @@ unsigned char snd_usb_parse_datainterval(struct snd_usb_audio *chip,
 #define snd_usb_get_speed(dev) ((dev)->speed)
 #endif
 
+static inline int snd_usb_ctrl_intf(struct snd_usb_audio *chip)
+{
+	return get_iface_desc(chip->ctrl_intf)->bInterfaceNumber;
+}
 
 #endif /* __USBAUDIO_HELPER_H */
-- 
1.7.1
