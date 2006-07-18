From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/5] aoa: feature gpio layer: fix IRQ access
Date: Tue, 18 Jul 2006 19:28:42 +0200
Message-ID: <17869.7719159119$1153248223@news.gmane.org>
References: <20060718172841.046446000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F7C3244
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:43:23 +0200 (MEST)
Content-Disposition: inline; filename=aoa-get-irq-fix.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The IRQ rework caused some hiccups here, in some cases we call
get_irq without a device node. This patch makes it catch that
case and return NO_IRQ when it happens, along with changing the
place where the irq is checked to check for NO_IRQ instead of -1.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/core/snd-aoa-gpio-feature.c	2006-07-16 22:10:02.467630929 +0200
+++ linux-2.6-fetch/sound/aoa/core/snd-aoa-gpio-feature.c	2006-07-16 22:13:41.891630929 +0200
@@ -112,7 +112,10 @@ static struct device_node *get_gpio(char
 
 static void get_irq(struct device_node * np, int *irqptr)
 {
-	*irqptr = irq_of_parse_and_map(np, 0);
+	if (np)
+		*irqptr = irq_of_parse_and_map(np, 0);
+	else
+		*irqptr = NO_IRQ;
 }
 
 /* 0x4 is outenable, 0x1 is out, thus 4 or 5 */
@@ -322,7 +325,7 @@ static int ftr_set_notify(struct gpio_ru
 		return -EINVAL;
 	}
 
-	if (irq == -1)
+	if (irq == NO_IRQ)
 		return -ENODEV;
 
 	mutex_lock(&notif->mutex);

--


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
