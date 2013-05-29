From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/3] lx6464es: use %*phN to print small buffer
	in hex form
Date: Wed, 29 May 2013 13:03:22 +0300
Message-ID: <1369821802-2308-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1369821802-2308-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D02D261A03
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 12:03:47 +0200 (CEST)
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/lx6464es/lx6464es.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 33eb301..7ad98f8 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1108,8 +1108,7 @@ static int snd_lx6464es_probe(struct pci_dev *pci,
 	}
 
 	strcpy(card->driver, "LX6464ES");
-	sprintf(card->id, "LX6464ES_%02X%02X%02X",
-		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
+	sprintf(card->id, "LX6464ES_%3phN", chip->mac_address + 3);
 
 	sprintf(card->shortname, "LX6464ES %pM", chip->mac_address);
 
-- 
1.8.2.rc0.22.gb3600c3
