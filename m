From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/3] lx6464es: dump MAC in standard form
Date: Wed, 29 May 2013 13:03:21 +0300
Message-ID: <1369821802-2308-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1369821802-2308-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id BD0032619D8
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 12:03:28 +0200 (CEST)
In-Reply-To: <1369821802-2308-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Let's use %pM to print MAC wherever we need it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/lx6464es/lx6464es.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 3230e57..33eb301 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -798,9 +798,7 @@ static int lx_init_dsp(struct lx6464es *chip)
 
 mac_ready:
 	snd_printd(LXP "mac address ready read after: %dms\n", i);
-	snd_printk(LXP "mac address: %02X.%02X.%02X.%02X.%02X.%02X\n",
-		   chip->mac_address[0], chip->mac_address[1], chip->mac_address[2],
-		   chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
+	snd_printk(LXP "mac address: %pM\n", chip->mac_address);
 
 	err = lx_init_get_version_features(chip);
 	if (err)
@@ -1113,9 +1111,7 @@ static int snd_lx6464es_probe(struct pci_dev *pci,
 	sprintf(card->id, "LX6464ES_%02X%02X%02X",
 		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
 
-	sprintf(card->shortname, "LX6464ES %02X.%02X.%02X.%02X.%02X.%02X",
-		chip->mac_address[0], chip->mac_address[1], chip->mac_address[2],
-		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
+	sprintf(card->shortname, "LX6464ES %pM", chip->mac_address);
 
 	sprintf(card->longname, "%s at 0x%lx, 0x%p, irq %i",
 		card->shortname, chip->port_plx,
-- 
1.8.2.rc0.22.gb3600c3
