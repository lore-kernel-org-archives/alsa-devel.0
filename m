From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] snd-aoa: enable dual-edge in GPIOs
Date: Tue, 27 Jun 2006 19:39:22 +0200
Message-ID: <1151429962.597.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9B3E26F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 19:39:26 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Apparently some firmware versions forget enabling the dual-edge bit,
snd-powermac did that too and even OSX does sometimes. This should fix
headphone plug detection on those machines.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- a/core/snd-aoa-gpio-feature.c
+++ b/core/snd-aoa-gpio-feature.c
@@ -207,6 +207,17 @@ static void ftr_handle_notify(void *data
 	mutex_unlock(&notif->mutex);
 }
 
+static void gpio_enable_dual_edge(int gpio)
+{
+	int v;
+
+	if (gpio == -1)
+		return;
+	v = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, gpio, 0);
+	v |= 0x80; /* enable dual edge */
+	pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, gpio, v);
+}
+
 static void ftr_gpio_init(struct gpio_runtime *rt)
 {
 	get_gpio("headphone-mute", NULL,
@@ -234,6 +245,10 @@ static void ftr_gpio_init(struct gpio_ru
 				      &linein_detect_gpio,
 				      &linein_detect_gpio_activestate);
 
+	gpio_enable_dual_edge(headphone_detect_gpio);
+	gpio_enable_dual_edge(lineout_detect_gpio);
+	gpio_enable_dual_edge(linein_detect_gpio);
+
 	get_irq(headphone_detect_node, &headphone_detect_irq);
 	get_irq(lineout_detect_node, &lineout_detect_irq);
 	get_irq(linein_detect_node, &linein_detect_irq);



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
