From: Pavel Machek <pavel@suse.cz>
Subject: fix pm_message_t vs. u32 in alsa
Date: Sat, 2 Apr 2005 23:06:07 +0200
Message-ID: <20050402210607.GA1999@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from amd.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3FDE6211
	for <alsa-devel@alsa-project.org>; Sat,  2 Apr 2005 23:06:20 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi!

I thought I'm done with fixing u32 vs. pm_message_t ... unfortunately
that turned out not to be the case as Russel King pointed out. This
fixes last few bits in alsa. [These patches are independend and change
no object code; therefore not numbered].

Please apply,

Signed-off-by: Pavel Machek <pavel@suse.cz>
                                                        Pavel

--- clean-cvs/sound/core/init.c	2005-03-29 13:32:29.000000000 +0200
+++ linux-cvs/sound/core/init.c	2005-03-31 23:54:51.000000000 +0200
@@ -744,7 +744,7 @@
 
 #define SND_GENERIC_NAME	"snd_generic_pm"
 
-static int snd_generic_suspend(struct device *dev, u32 state, u32 level);
+static int snd_generic_suspend(struct device *dev, pm_message_t state, u32 level);
 static int snd_generic_resume(struct device *dev, u32 level);
 
 static struct device_driver snd_generic_driver = {
@@ -800,7 +800,7 @@
 }
 
 /* suspend/resume callbacks for snd_generic platform device */
-static int snd_generic_suspend(struct device *dev, u32 state, u32 level)
+static int snd_generic_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	snd_card_t *card;
 
--- clean-cvs/sound/pci/atiixp_modem.c	2005-03-29 13:32:37.000000000 +0200
+++ linux-cvs/sound/pci/atiixp_modem.c	2005-03-31 23:54:54.000000000 +0200
@@ -1121,7 +1121,7 @@
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
-	pci_set_power_state(chip->pci, 3);
+	pci_set_power_state(chip->pci, PCI_D3hot);
 	pci_disable_device(chip->pci);
 	return 0;
 }
@@ -1132,7 +1132,7 @@
 	int i;
 
 	pci_enable_device(chip->pci);
-	pci_set_power_state(chip->pci, 0);
+	pci_set_power_state(chip->pci, PCI_D0);
 	pci_set_master(chip->pci);
 
 	snd_atiixp_aclink_reset(chip);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
