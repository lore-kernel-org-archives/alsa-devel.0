From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/5] aoa: platform function gpio: ignore errors
	from	functions that dont exist
Date: Tue, 18 Jul 2006 19:28:45 +0200
Message-ID: <4994.78769856996$1153248226@news.gmane.org>
References: <20060718172841.046446000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A3DC1247
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:43:24 +0200 (MEST)
Content-Disposition: inline;
	filename=snd-aoa-dont-warn-if-gpio-doesnt-exist.patch
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

Sometimes we simply want to turn off or on everything, and when recently a
warning was added when a certain platform function can't be called, this
triggered all the time in those cases. This patch shows the warning only if
the error was different from the function not existing.

The alternative would be to not even try calling the function when it
doesn't exist by first checking which exist and then only calling those that
do, but that adds complexity that isn't necessary.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-07-18 19:24:30.273476868 +0200
+++ linux-2.6-fetch/sound/aoa/core/snd-aoa-gpio-pmf.c	2006-07-18 19:24:55.103476868 +0200
@@ -18,7 +18,7 @@ static void pmf_gpio_set_##name(struct g
 							\
 	if (unlikely(!rt)) return;				\
 	rc = pmf_call_function(rt->node, #name "-mute", &args);	\
-	if (rc)							\
+	if (rc && rc != -ENODEV)				\
 		printk(KERN_WARNING "pmf_gpio_set_" #name	\
 		" failed, rc: %d\n", rc);			\
 	rt->implementation_private &= ~(1<<bit);		\

--


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
