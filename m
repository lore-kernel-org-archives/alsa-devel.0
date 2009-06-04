From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] ALSA: Add missing __devexit_p() markers
Date: Thu, 4 Jun 2009 10:46:43 +0200
Message-ID: <20090604104643.443fbe52@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id CD0891037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:46:52 +0200 (CEST)
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
Cc: Kyle McMartin <kyle@mcmartin.ca>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

3 ISA sound drivers lack their __devexit_p() markers, which would
cause build failures when the kernel is built without hotplug support.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/es1688/es1688.c  |    2 +-
 sound/isa/gus/gusextreme.c |    2 +-
 sound/parisc/harmony.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.30-rc8.orig/sound/isa/es1688/es1688.c	2009-04-08 08:54:02.000000000 +0200
+++ linux-2.6.30-rc8/sound/isa/es1688/es1688.c	2009-06-04 10:37:06.000000000 +0200
@@ -193,7 +193,7 @@ static int __devexit snd_es1688_remove(s
 static struct isa_driver snd_es1688_driver = {
 	.match		= snd_es1688_match,
 	.probe		= snd_es1688_probe,
-	.remove		= snd_es1688_remove,
+	.remove		= __devexit_p(snd_es1688_remove),
 #if 0	/* FIXME */
 	.suspend	= snd_es1688_suspend,
 	.resume		= snd_es1688_resume,
--- linux-2.6.30-rc8.orig/sound/isa/gus/gusextreme.c	2009-04-08 08:54:02.000000000 +0200
+++ linux-2.6.30-rc8/sound/isa/gus/gusextreme.c	2009-06-04 10:37:13.000000000 +0200
@@ -348,7 +348,7 @@ static int __devexit snd_gusextreme_remo
 static struct isa_driver snd_gusextreme_driver = {
 	.match		= snd_gusextreme_match,
 	.probe		= snd_gusextreme_probe,
-	.remove		= snd_gusextreme_remove,
+	.remove		= __devexit_p(snd_gusextreme_remove),
 #if 0	/* FIXME */
 	.suspend	= snd_gusextreme_suspend,
 	.resume		= snd_gusextreme_resume,
--- linux-2.6.30-rc8.orig/sound/parisc/harmony.c	2009-04-08 08:54:03.000000000 +0200
+++ linux-2.6.30-rc8/sound/parisc/harmony.c	2009-06-04 10:37:25.000000000 +0200
@@ -1020,7 +1020,7 @@ static struct parisc_driver snd_harmony_
 	.name = "harmony",
 	.id_table = snd_harmony_devtable,
 	.probe = snd_harmony_probe,
-	.remove = snd_harmony_remove,
+	.remove = __devexit_p(snd_harmony_remove),
 };
 
 static int __init 


-- 
Jean Delvare
