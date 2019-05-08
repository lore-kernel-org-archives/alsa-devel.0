From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: line6: podhd: Rewrite complex timer
	& work combo with a delayed work
Date: Wed,  8 May 2019 16:49:41 +0200
Message-ID: <20190508144943.8139-3-tiwai@suse.de>
References: <20190508144943.8139-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64D31F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 16:49:44 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 17127AEEA
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 14:49:44 +0000 (UTC)
In-Reply-To: <20190508144943.8139-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

POD HD driver had a complex staged startup sequence with both timer
and work.  This patch simplifies it to a single delayed work with a
single stage.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/podhd.c | 73 ++++++++-----------------------------------------
 1 file changed, 11 insertions(+), 62 deletions(-)

diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 5f3c87264e66..be5d15639574 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -22,16 +22,6 @@
 
 #define PODHD_STARTUP_DELAY 500
 
-/*
- * Stages of POD startup procedure
- */
-enum {
-	PODHD_STARTUP_INIT = 1,
-	PODHD_STARTUP_SCHEDULE_WORKQUEUE,
-	PODHD_STARTUP_SETUP,
-	PODHD_STARTUP_LAST = PODHD_STARTUP_SETUP - 1
-};
-
 enum {
 	LINE6_PODHD300,
 	LINE6_PODHD400,
@@ -47,14 +37,8 @@ struct usb_line6_podhd {
 	/* Generic Line 6 USB data */
 	struct usb_line6 line6;
 
-	/* Timer for device initialization */
-	struct timer_list startup_timer;
-
 	/* Work handler for device initialization */
-	struct work_struct startup_work;
-
-	/* Current progress in startup procedure */
-	int startup_progress;
+	struct delayed_work startup_work;
 
 	/* Serial number of device */
 	u32 serial_number;
@@ -158,10 +142,6 @@ static struct line6_pcm_properties podx3_pcm_properties = {
 };
 static struct usb_driver podhd_driver;
 
-static void podhd_startup_start_workqueue(struct timer_list *t);
-static void podhd_startup_workqueue(struct work_struct *work);
-static int podhd_startup_finalize(struct usb_line6_podhd *pod);
-
 static ssize_t serial_number_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -202,26 +182,6 @@ static const struct attribute_group podhd_dev_attr_group = {
  * audio nor bulk interfaces to work.
  */
 
-static void podhd_startup(struct usb_line6_podhd *pod)
-{
-	CHECK_STARTUP_PROGRESS(pod->startup_progress, PODHD_STARTUP_INIT);
-
-	/* delay startup procedure: */
-	line6_start_timer(&pod->startup_timer, PODHD_STARTUP_DELAY,
-		podhd_startup_start_workqueue);
-}
-
-static void podhd_startup_start_workqueue(struct timer_list *t)
-{
-	struct usb_line6_podhd *pod = from_timer(pod, t, startup_timer);
-
-	CHECK_STARTUP_PROGRESS(pod->startup_progress,
-		PODHD_STARTUP_SCHEDULE_WORKQUEUE);
-
-	/* schedule work for global work queue: */
-	schedule_work(&pod->startup_work);
-}
-
 static int podhd_dev_start(struct usb_line6_podhd *pod)
 {
 	int ret;
@@ -272,37 +232,27 @@ static int podhd_dev_start(struct usb_line6_podhd *pod)
 	return ret;
 }
 
-static void podhd_startup_workqueue(struct work_struct *work)
+static void podhd_startup_work(struct work_struct *work)
 {
 	struct usb_line6_podhd *pod =
-	    container_of(work, struct usb_line6_podhd, startup_work);
-
-	CHECK_STARTUP_PROGRESS(pod->startup_progress, PODHD_STARTUP_SETUP);
+		container_of(work, struct usb_line6_podhd, startup_work.work);
+	struct usb_line6 *line6 = &pod->line6;
 
 	podhd_dev_start(pod);
 	line6_read_serial_number(&pod->line6, &pod->serial_number);
-
-	podhd_startup_finalize(pod);
-}
-
-static int podhd_startup_finalize(struct usb_line6_podhd *pod)
-{
-	struct usb_line6 *line6 = &pod->line6;
-
-	/* ALSA audio interface: */
-	return snd_card_register(line6->card);
+	if (snd_card_register(line6->card))
+		dev_err(line6->ifcdev, "Failed to register POD HD card.\n");
 }
 
 static void podhd_disconnect(struct usb_line6 *line6)
 {
 	struct usb_line6_podhd *pod = (struct usb_line6_podhd *)line6;
 
+	cancel_delayed_work_sync(&pod->startup_work);
+
 	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL_INFO) {
 		struct usb_interface *intf;
 
-		del_timer_sync(&pod->startup_timer);
-		cancel_work_sync(&pod->startup_work);
-
 		intf = usb_ifnum_to_if(line6->usbdev,
 					pod->line6.properties->ctrl_if);
 		if (intf)
@@ -322,8 +272,7 @@ static int podhd_init(struct usb_line6 *line6,
 
 	line6->disconnect = podhd_disconnect;
 
-	timer_setup(&pod->startup_timer, NULL, 0);
-	INIT_WORK(&pod->startup_work, podhd_startup_workqueue);
+	INIT_DELAYED_WORK(&pod->startup_work, podhd_startup_work);
 
 	if (pod->line6.properties->capabilities & LINE6_CAP_CONTROL) {
 		/* claim the data interface */
@@ -362,11 +311,11 @@ static int podhd_init(struct usb_line6 *line6,
 
 	if (!(pod->line6.properties->capabilities & LINE6_CAP_CONTROL_INFO)) {
 		/* register USB audio system directly */
-		return podhd_startup_finalize(pod);
+		return snd_card_register(line6->card);
 	}
 
 	/* init device and delay registering */
-	podhd_startup(pod);
+	schedule_delayed_work(&pod->startup_work, PODHD_STARTUP_DELAY);
 	return 0;
 }
 
-- 
2.16.4
