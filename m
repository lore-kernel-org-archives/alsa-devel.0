From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: line6: Drop interface argument from
	private_init and disconnect callbacks
Date: Mon, 26 Jan 2015 13:48:41 +0100
Message-ID: <1422276523-14336-2-git-send-email-tiwai@suse.de>
References: <1422276523-14336-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DD84C26054F
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 13:48:44 +0100 (CET)
In-Reply-To: <1422276523-14336-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The interface argument is used just for retrieving the assigned
device, which can be already found in line6->ifcdev.  Drop them from
the callbacks.  Also, pass the usb id to private_init so that the
driver can deal with it there.  This is a preliminary work for the
further cleanup to move the whole allocation into driver.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c   |  9 +++++----
 sound/usb/line6/driver.h   |  6 ++++--
 sound/usb/line6/pod.c      | 14 +++++++-------
 sound/usb/line6/podhd.c    |  6 +++---
 sound/usb/line6/toneport.c | 14 +++++++-------
 sound/usb/line6/variax.c   | 12 +++++-------
 6 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 4d2d233d0505..e2fbff05c1b1 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -488,9 +488,10 @@ static int line6_init_cap_control(struct usb_line6 *line6)
 	Probe USB device.
 */
 int line6_probe(struct usb_interface *interface,
+		const struct usb_device_id *id,
 		struct usb_line6 *line6,
 		const struct line6_properties *properties,
-		int (*private_init)(struct usb_interface *, struct usb_line6 *))
+		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id))
 {
 	struct usb_device *usbdev = interface_to_usbdev(interface);
 	struct snd_card *card;
@@ -552,7 +553,7 @@ int line6_probe(struct usb_interface *interface,
 	}
 
 	/* initialize device data based on device: */
-	ret = private_init(interface, line6);
+	ret = private_init(line6, id);
 	if (ret < 0)
 		goto error;
 
@@ -565,7 +566,7 @@ int line6_probe(struct usb_interface *interface,
 
  error:
 	if (line6->disconnect)
-		line6->disconnect(interface);
+		line6->disconnect(line6);
 	snd_card_free(card);
 	return ret;
 }
@@ -592,7 +593,7 @@ void line6_disconnect(struct usb_interface *interface)
 	if (line6->line6pcm)
 		line6_pcm_disconnect(line6->line6pcm);
 	if (line6->disconnect)
-		line6->disconnect(interface);
+		line6->disconnect(line6);
 
 	dev_info(&interface->dev, "Line 6 %s now disconnected\n",
 		 line6->properties->name);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index a6c0b2f08ba8..4dc6c28e8224 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -157,7 +157,7 @@ struct usb_line6 {
 	int message_length;
 
 	void (*process_message)(struct usb_line6 *);
-	void (*disconnect)(struct usb_interface *);
+	void (*disconnect)(struct usb_line6 *line6);
 };
 
 extern char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1,
@@ -180,9 +180,11 @@ extern int line6_write_data(struct usb_line6 *line6, int address, void *data,
 			    size_t datalen);
 
 int line6_probe(struct usb_interface *interface,
+		const struct usb_device_id *id,
 		struct usb_line6 *line6,
 		const struct line6_properties *properties,
-		int (*private_init)(struct usb_interface *, struct usb_line6 *));
+		int (*private_init)(struct usb_line6 *, const struct usb_device_id *id));
+
 void line6_disconnect(struct usb_interface *interface);
 
 #ifdef CONFIG_PM
diff --git a/sound/usb/line6/pod.c b/sound/usb/line6/pod.c
index 26ecf26a33ec..d1e952fbcae7 100644
--- a/sound/usb/line6/pod.c
+++ b/sound/usb/line6/pod.c
@@ -399,10 +399,10 @@ static struct snd_kcontrol_new pod_control_monitor = {
 /*
 	POD device disconnected.
 */
-static void line6_pod_disconnect(struct usb_interface *interface)
+static void line6_pod_disconnect(struct usb_line6 *line6)
 {
-	struct usb_line6_pod *pod = usb_get_intfdata(interface);
-	struct device *dev = &interface->dev;
+	struct usb_line6_pod *pod = (struct usb_line6_pod *)line6;
+	struct device *dev = line6->ifcdev;
 
 	/* remove sysfs entries: */
 	device_remove_file(dev, &dev_attr_device_id);
@@ -435,8 +435,8 @@ static int pod_create_files2(struct device *dev)
 /*
 	 Try to init POD device.
 */
-static int pod_init(struct usb_interface *interface,
-		    struct usb_line6 *line6)
+static int pod_init(struct usb_line6 *line6,
+		    const struct usb_device_id *id)
 {
 	int err;
 	struct usb_line6_pod *pod = (struct usb_line6_pod *) line6;
@@ -448,7 +448,7 @@ static int pod_init(struct usb_interface *interface,
 	INIT_WORK(&pod->startup_work, pod_startup4);
 
 	/* create sysfs entries: */
-	err = pod_create_files2(&interface->dev);
+	err = pod_create_files2(line6->ifcdev);
 	if (err < 0)
 		return err;
 
@@ -596,7 +596,7 @@ static int pod_probe(struct usb_interface *interface,
 	pod = kzalloc(sizeof(*pod), GFP_KERNEL);
 	if (!pod)
 		return -ENODEV;
-	return line6_probe(interface, &pod->line6,
+	return line6_probe(interface, id, &pod->line6,
 			   &pod_properties_table[id->driver_info],
 			   pod_init);
 }
diff --git a/sound/usb/line6/podhd.c b/sound/usb/line6/podhd.c
index 59abbd92624e..21d7edcfa272 100644
--- a/sound/usb/line6/podhd.c
+++ b/sound/usb/line6/podhd.c
@@ -87,8 +87,8 @@ static struct line6_pcm_properties podhd_pcm_properties = {
 /*
 	Try to init POD HD device.
 */
-static int podhd_init(struct usb_interface *interface,
-		      struct usb_line6 *line6)
+static int podhd_init(struct usb_line6 *line6,
+		      const struct usb_device_id *id)
 {
 	int err;
 
@@ -182,7 +182,7 @@ static int podhd_probe(struct usb_interface *interface,
 	podhd = kzalloc(sizeof(*podhd), GFP_KERNEL);
 	if (!podhd)
 		return -ENODEV;
-	return line6_probe(interface, &podhd->line6,
+	return line6_probe(interface, id, &podhd->line6,
 			   &podhd_properties_table[id->driver_info],
 			   podhd_init);
 }
diff --git a/sound/usb/line6/toneport.c b/sound/usb/line6/toneport.c
index 9a769463f7bf..8e7020df0d10 100644
--- a/sound/usb/line6/toneport.c
+++ b/sound/usb/line6/toneport.c
@@ -387,11 +387,11 @@ static void toneport_setup(struct usb_line6_toneport *toneport)
 /*
 	Toneport device disconnected.
 */
-static void line6_toneport_disconnect(struct usb_interface *interface)
+static void line6_toneport_disconnect(struct usb_line6 *line6)
 {
-	struct usb_line6_toneport *toneport;
+	struct usb_line6_toneport *toneport =
+		(struct usb_line6_toneport *)line6;
 
-	toneport = usb_get_intfdata(interface);
 	del_timer_sync(&toneport->timer);
 
 	if (toneport_has_led(toneport->type))
@@ -402,12 +402,13 @@ static void line6_toneport_disconnect(struct usb_interface *interface)
 /*
 	 Try to init Toneport device.
 */
-static int toneport_init(struct usb_interface *interface,
-			 struct usb_line6 *line6)
+static int toneport_init(struct usb_line6 *line6,
+			 const struct usb_device_id *id)
 {
 	int err;
 	struct usb_line6_toneport *toneport =  (struct usb_line6_toneport *) line6;
 
+	toneport->type = id->driver_info;
 	setup_timer(&toneport->timer, toneport_start_pcm,
 		    (unsigned long)toneport);
 
@@ -562,8 +563,7 @@ static int toneport_probe(struct usb_interface *interface,
 	toneport = kzalloc(sizeof(*toneport), GFP_KERNEL);
 	if (!toneport)
 		return -ENODEV;
-	toneport->type = id->driver_info;
-	return line6_probe(interface, &toneport->line6,
+	return line6_probe(interface, id, &toneport->line6,
 			   &toneport_properties_table[id->driver_info],
 			   toneport_init);
 }
diff --git a/sound/usb/line6/variax.c b/sound/usb/line6/variax.c
index cd3adeffde02..ba6e85eed2ba 100644
--- a/sound/usb/line6/variax.c
+++ b/sound/usb/line6/variax.c
@@ -210,11 +210,9 @@ static void line6_variax_process_message(struct usb_line6 *line6)
 /*
 	Variax destructor.
 */
-static void line6_variax_disconnect(struct usb_interface *interface)
+static void line6_variax_disconnect(struct usb_line6 *line6)
 {
-	struct usb_line6_variax *variax;
-
-	variax = usb_get_intfdata(interface);
+	struct usb_line6_variax *variax = (struct usb_line6_variax *)line6;
 
 	del_timer(&variax->startup_timer1);
 	del_timer(&variax->startup_timer2);
@@ -226,8 +224,8 @@ static void line6_variax_disconnect(struct usb_interface *interface)
 /*
 	 Try to init workbench device.
 */
-static int variax_init(struct usb_interface *interface,
-		       struct usb_line6 *line6)
+static int variax_init(struct usb_line6 *line6,
+		       const struct usb_device_id *id)
 {
 	struct usb_line6_variax *variax = (struct usb_line6_variax *) line6;
 	int err;
@@ -303,7 +301,7 @@ static int variax_probe(struct usb_interface *interface,
 	variax = kzalloc(sizeof(*variax), GFP_KERNEL);
 	if (!variax)
 		return -ENODEV;
-	return line6_probe(interface, &variax->line6,
+	return line6_probe(interface, id, &variax->line6,
 			   &variax_properties_table[id->driver_info],
 			   variax_init);
 }
-- 
2.2.2
