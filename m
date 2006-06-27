From: Paul Collins <paul@briny.ondioline.org>
Subject: snd-aoa: headphone detection fix
Date: Tue, 27 Jun 2006 20:00:40 +1000
Message-ID: <87d5cuhq9j.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C47FD267
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 12:06:20 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: johannes@sipsolutions.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Johannes,

I took a look at tumbler.c and after it requests the headphone or
lineout detection IRQ it sets a bit in the associated GPIO register.
I added some code to snd-aoa to do something similar and now I get
interrupts both on plug and unplug.  Three each time, in fact.
(I don't remember if this used to happen with snd-powermac.)

I also set the same bit in the linein-detect register on the
assumption that it is handled in the same way.  I have only been able
to test headphone detection here on my PowerBook5,4 though.

Signed-off-by: Paul Collins <paul@ondioline.org>

diff --git a/sound/aoa/core/snd-aoa-gpio-feature.c b/sound/aoa/core/snd-aoa-gpio-feature.c
index 2c6eb77..fa0606e 100644
--- a/sound/aoa/core/snd-aoa-gpio-feature.c
+++ b/sound/aoa/core/snd-aoa-gpio-feature.c
@@ -289,6 +289,7 @@ static int ftr_set_notify(struct gpio_ru
 	struct gpio_notification *notif;
 	notify_func_t old;
 	int irq;
+	int gpio = -1;
 	char *name;
 	int err = -EBUSY;
 
@@ -297,16 +298,19 @@ static int ftr_set_notify(struct gpio_ru
 		notif = &rt->headphone_notify;
 		name = "headphone-detect";
 		irq = headphone_detect_irq;
+		gpio = headphone_detect_gpio;
 		break;
 	case AOA_NOTIFY_LINE_IN:
 		notif = &rt->line_in_notify;
 		name = "linein-detect";
 		irq = linein_detect_irq;
+		gpio = linein_detect_gpio;
 		break;
 	case AOA_NOTIFY_LINE_OUT:
 		notif = &rt->line_out_notify;
 		name = "lineout-detect";
 		irq = lineout_detect_irq;
+		gpio = lineout_detect_gpio;
 		break;
 	default:
 		return -EINVAL;
@@ -337,6 +341,14 @@ static int ftr_set_notify(struct gpio_ru
 		err = request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
 		if (err)
 			goto out_unlock;
+
+		/* Activate status interrupts. */
+		if (gpio > -1) {
+			int v;
+			v = pmac_call_feature(PMAC_FTR_READ_GPIO, NULL, gpio, 0);
+			v |= 0x80;
+			pmac_call_feature(PMAC_FTR_WRITE_GPIO, NULL, gpio, v);
+		}
 	}
 
 	notif->notify = notify;

-- 
Paul Collins
Melbourne, Australia

Dag vijandelijk luchtschip de huismeester is dood

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
