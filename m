From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] snd-aoa: not experimental
Date: Tue, 27 Jun 2006 19:36:03 +0200
Message-ID: <1151429763.597.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5EE226F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 19:36:08 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The dependencies in the soundbus Kconfig were wrong, it isn't
experimental any more.

This patch fixes that and makes it select SND_PCM too instead of
depending on it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

diff --git a/soundbus/Kconfig b/soundbus/Kconfig
index d532d27..bf0f85e 100644
--- a/soundbus/Kconfig
+++ b/soundbus/Kconfig
@@ -1,6 +1,7 @@
 config SND_AOA_SOUNDBUS
 	tristate "Apple Soundbus support"
-	depends on SOUND && SND_PCM && EXPERIMENTAL
+	depends on SOUND
+	select SND_PCM
 	---help---
 	This option enables the generic driver for the soundbus
 	support on Apple machines.



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
