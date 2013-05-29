From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/3] lx6464es: remove useles
	pci_set_drvdata(pdev, NULL)
Date: Wed, 29 May 2013 13:03:20 +0300
Message-ID: <1369821802-2308-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 749A72619E3
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 12:03:51 +0200 (CEST)
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

The driver core handles this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/lx6464es/lx6464es.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 298bc9b..3230e57 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1139,7 +1139,6 @@ out_free:
 static void snd_lx6464es_remove(struct pci_dev *pci)
 {
 	snd_card_free(pci_get_drvdata(pci));
-	pci_set_drvdata(pci, NULL);
 }
 
 
-- 
1.8.2.rc0.22.gb3600c3
