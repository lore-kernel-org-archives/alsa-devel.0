From: Jack Howarth <howarth@bromo.med.uc.edu>
Subject: patch needed for powermac driver in 0.9beta12
Date: Thu, 4 Apr 2002 17:28:46 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204042228.RAA80046@bromo.msbb.uc.edu>
Received: from bromo.msbb.uc.edu (bromo.med.uc.edu [129.137.3.146])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA24901
	for <alsa-devel@alsa-project.org>; Fri, 5 Apr 2002 00:29:47 +0200
Received: (from howarth@localhost)
	by bromo.msbb.uc.edu (SGI-8.9.3/8.9.3) id RAA80046
	for alsa-devel@alsa-project.org; Thu, 4 Apr 2002 17:28:46 -0500 (EST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
    The alsa-driver 0.9beta12 release is unable to build
the snd-powermac driver on ppclinux due to 1) a change in
the api to the snd_power_lock call that wasn't migrated 
into pmac.c and 2) missing includes for linux/delay.h 
in awacs.c and keywest.c which result in unresolved symbols
for udelay and mdelay. The following patch resolved these
issues and the resulting snd-powermac driver loads and 
operates fine. Please add these changes to the next release.
                Jack Howarth
------------------------------------------------------------

diff -uNr alsa-driver-0.9+0beta12-1/alsa-kernel/ppc/awacs.c alsa-driver-0.9+0beta12-1.new/alsa-kernel/ppc/awacs.c
--- alsa-driver-0.9+0beta12-1/alsa-kernel/ppc/awacs.c   Thu Feb 14 12:40:34 2002+++ alsa-driver-0.9+0beta12-1.new/alsa-kernel/ppc/awacs.c       Wed Apr  3 20:27:47 2002
@@ -24,6 +24,7 @@
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include "pmac.h"
 
diff -uNr alsa-driver-0.9+0beta12-1/alsa-kernel/ppc/keywest.c alsa-driver-0.9+0beta12-1.new/alsa-kernel/ppc/keywest.c
--- alsa-driver-0.9+0beta12-1/alsa-kernel/ppc/keywest.c Mon Feb 25 06:50:13 2002+++ alsa-driver-0.9+0beta12-1.new/alsa-kernel/ppc/keywest.c     Wed Apr  3 20:27:04 2002
@@ -26,6 +26,7 @@
 #define __NO_VERSION__
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include "pmac.h"
 
diff -uNr alsa-driver-0.9+0beta12-1/alsa-kernel/ppc/pmac.c alsa-driver-0.9+0beta12-1.new/alsa-kernel/ppc/pmac.c
--- alsa-driver-0.9+0beta12-1/alsa-kernel/ppc/pmac.c    Thu Feb 14 12:40:34 2002+++ alsa-driver-0.9+0beta12-1.new/alsa-kernel/ppc/pmac.c        Wed Apr  3 20:26:13 2002
@@ -1307,7 +1307,7 @@
        unsigned long flags;
        snd_card_t *card = chip->card;
 
-       snd_power_lock(card, can_schedule);
+       snd_power_lock(card);
        if (card->power_state == SNDRV_CTL_POWER_D3hot)
                goto __skip;
 
@@ -1331,7 +1331,7 @@
 {
        snd_card_t *card = chip->card;
 
-       snd_power_lock(card, can_schedule);
+       snd_power_lock(card);
        if (card->power_state == SNDRV_CTL_POWER_D0)
                goto __skip;

-----------------------------------------------------------------------
