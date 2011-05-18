From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 7/8] ALSA: usb-audio: assume valid clock
Date: Wed, 18 May 2011 11:28:44 +0200
Message-ID: <1305710925-3857-8-git-send-email-zonque@gmail.com>
References: <1305710925-3857-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 74649103932
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 11:29:02 +0200 (CEST)
In-Reply-To: <1305710925-3857-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

If the interface can't report a clock's validity, assume that it's
valid.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Vicente Joel <vicentejoel@gmail.com>
---
 sound/usb/clock.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 7754a10..075195e 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -104,6 +104,15 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 	int err;
 	unsigned char data;
 	struct usb_device *dev = chip->dev;
+	struct uac_clock_source_descriptor *cs_desc =
+		snd_usb_find_clock_source(chip->ctrl_intf, source_id);
+
+	if (!cs_desc)
+		return 0;
+
+	/* If a clock source can't tell us whether it's valid, we assume it is */
+	if (!uac2_control_is_readable(cs_desc->bmControls, UAC2_CS_CONTROL_CLOCK_VALID))
+		return 1;
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
@@ -114,7 +123,7 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip, int source_id)
 	if (err < 0) {
 		snd_printk(KERN_WARNING "%s(): cannot get clock validity for id %d\n",
 			   __func__, source_id);
-		return err;
+		return 0;
 	}
 
 	return !!data;
-- 
1.7.5.1
