From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001334]: module fails to load because it can't register ac97 bus
Date: Sun, 14 Aug 2005 14:19:54 +0200
Message-ID: <e3f560c9bb4595667850855459355c68@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 311971D7
	for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2005 14:19:55 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1334> 
======================================================================
Reported By:                bdijkstra
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1334
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux
Kernel Version:             2.6.13-rc5-git3-3-default
======================================================================
Date Submitted:             08-14-2005 00:13 CEST
Last Modified:              08-14-2005 14:19 CEST
======================================================================
Summary:                    module fails to load because it can't register ac97
bus
Description: 
The Hercules GameTheater XP card has two codecs of the same type (CS4294).
The cs46xx driver tries to register these two codecs with the same name
with the ac97 bus which then fails.
I have attached the message log of a module load which shows the problem.


======================================================================

----------------------------------------------------------------------
 bdijkstra - 08-14-05 00:21 
----------------------------------------------------------------------
The following patch fixes the problem for me.
It makes the codec name that is registered with the ac97 bus unique
by adding the codec number to the shortname.

Signed-off-by: Bjorge Dijkstra <bjorge@gmx.net>

--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1828,7 +1828,7 @@ static int snd_ac97_dev_register(snd_dev
        ac97->dev.parent = ac97->bus->card->dev;
        ac97->dev.platform_data = ac97;
        ac97->dev.release = ac97_device_release;
-       strncpy(ac97->dev.bus_id, snd_ac97_get_short_name(ac97),
BUS_ID_SIZE);
+       snprintf(ac97->dev.bus_id, BUS_ID_SIZE, "%s-%d",
snd_ac97_get_short_name(ac97), ac97->num);
        if ((err = device_register(&ac97->dev)) < 0) {
                snd_printk(KERN_ERR "Can't register ac97 bus\n");
                ac97->dev.bus = NULL;

----------------------------------------------------------------------
 bdijkstra - 08-14-05 14:19 
----------------------------------------------------------------------
After a good night sleep I realised that someone could have multiple
soundcards with the same codecs on them. And my previous patch probably
still fails in that case. So i present I slightly modified version include
the card number in the device name. I also dropped the codec shortname
from the device name, because some codec names are quite long, at least
longer than BUS_ID_SIZE. Instead I 
opted for a more generic cardX-Y scheme.
This patch applies on top of the previous one.

----

Summary: Make AC97 codec device name more unique


Signed-off-by: Bjorge Dijkstra <bjorge@gmx.net>


diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -1828,7 +1828,7 @@ static int snd_ac97_dev_register(snd_dev
        ac97->dev.parent = ac97->bus->card->dev;
        ac97->dev.platform_data = ac97;
        ac97->dev.release = ac97_device_release;
-       snprintf(ac97->dev.bus_id, BUS_ID_SIZE, "%s-%d",
snd_ac97_get_short_name(ac97), ac97->num);
+       snprintf(ac97->dev.bus_id, BUS_ID_SIZE, "card%d-%d",
ac97->bus->card->number, ac97->num);
        if ((err = device_register(&ac97->dev)) < 0) {
                snd_printk(KERN_ERR "Can't register ac97 bus\n");
                ac97->dev.bus = NULL

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-14-05 00:13 bdijkstra      New Issue                                    
08-14-05 00:13 bdijkstra      File Added: cs46xx-error.log                    
08-14-05 00:13 bdijkstra      Distribution              => SuSE Linux      
08-14-05 00:13 bdijkstra      Kernel Version            =>
2.6.13-rc5-git3-3-default
08-14-05 00:21 bdijkstra      Note Added: 0005812                          
08-14-05 14:19 bdijkstra      Note Added: 0005815                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
