From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v3] ALSA: line6: Claim pod x3 usb data interface
Date: Tue, 29 Nov 2016 22:12:51 +0100
Message-ID: <1480453971-26430-1-git-send-email-dev@andree.sk>
References: <1479556889-17601-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BDCBB266667
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 22:13:25 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id m203so26379752wma.3
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 13:13:25 -0800 (PST)
In-Reply-To: <1479556889-17601-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Userspace apps have to claim USB interfaces before using endpoints in
them (drivers/usb/core/devio.c:checkintf()). It's a lock mechanism so
that two "drivers" don't steal data from each other. Kernel drivers don't
have to claim interfaces to work - but they should, to lock out userspace.

While there, fix line6_properties struct to match checkpatch.pl.

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.h |  9 +++++----
 sound/usb/line6/podhd.c  | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 7e3a3aa..a5c2e9a 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -98,10 +98,11 @@ struct line6_properties {
 
 	int altsetting;
 
-	unsigned ep_ctrl_r;
-	unsigned ep_ctrl_w;
-	unsigned ep_audio_r;
-	unsigned ep_audio_w;
+	unsigned int ctrl_if;
+	unsigned int ep_ctrl_r;
+	unsigned int ep_ctrl_w;
+	unsigned int ep_audio_r;
+	unsigned int ep_audio_w;
 };
 
 /* Capability bits */
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 49cd4a6..6ab23e5 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -153,6 +153,7 @@ static struct line6_pcm_properties podx3_pcm_properties = {
 			    .rats = &podhd_ratden},
 	.bytes_per_channel = 3 /* SNDRV_PCM_FMTBIT_S24_3LE */
 };
+static struct usb_driver podhd_driver;
 
 static void podhd_startup_start_workqueue(unsigned long data);
 static void podhd_startup_workqueue(struct work_struct *work);
@@ -291,8 +292,14 @@ static void podhd_disconnect(struct usb_line6 *line6)
 	struct usb_line6_podhd *pod = (struct usb_line6_podhd *)line6;
 
 	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
+		struct usb_interface *intf;
+
 		del_timer_sync(&pod->startup_timer);
 		cancel_work_sync(&pod->startup_work);
+
+		intf = usb_ifnum_to_if(line6->usbdev,
+					pod->line6.properties->ctrl_if);
+		usb_driver_release_interface(&podhd_driver, intf);
 	}
 }
 
@@ -304,10 +311,27 @@ static int podhd_init(struct usb_line6 *line6,
 {
 	int err;
 	struct usb_line6_podhd *pod = (struct usb_line6_podhd *) line6;
+	struct usb_interface *intf;
 
 	line6->disconnect = podhd_disconnect;
 
 	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
+		/* claim the data interface */
+		intf = usb_ifnum_to_if(line6->usbdev,
+					pod->line6.properties->ctrl_if);
+		if (!intf) {
+			dev_err(pod->line6.ifcdev, "interface %d not found\n",
+				pod->line6.properties->ctrl_if);
+			return -ENODEV;
+		}
+
+		err = usb_driver_claim_interface(&podhd_driver, intf, NULL);
+		if (err != 0) {
+			dev_err(pod->line6.ifcdev, "can't claim interface %d, error %d\n",
+				pod->line6.properties->ctrl_if, err);
+			return err;
+		}
+
 		/* create sysfs entries: */
 		err = snd_card_add_dev_attr(line6->card, &podhd_dev_attr_group);
 		if (err < 0)
@@ -406,6 +430,7 @@ static const struct line6_properties podhd_properties_table[] = {
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
+		.ctrl_if = 1,
 		.ep_audio_r = 0x86,
 		.ep_audio_w = 0x02,
 	},
@@ -417,6 +442,7 @@ static const struct line6_properties podhd_properties_table[] = {
 		.altsetting = 1,
 		.ep_ctrl_r = 0x81,
 		.ep_ctrl_w = 0x01,
+		.ctrl_if = 1,
 		.ep_audio_r = 0x86,
 		.ep_audio_w = 0x02,
 	},
-- 
2.7.4
