From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 5/5] ALSA: snd_usb_caiaq: bump version number
Date: Sat, 30 May 2009 22:06:20 +0200
Message-ID: <1243713980-25354-5-git-send-email-daniel@caiaq.de>
References: <1243713980-25354-1-git-send-email-daniel@caiaq.de>
	<1243713980-25354-2-git-send-email-daniel@caiaq.de>
	<1243713980-25354-3-git-send-email-daniel@caiaq.de>
	<1243713980-25354-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E336103815
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 22:07:14 +0200 (CEST)
In-Reply-To: <1243713980-25354-4-git-send-email-daniel@caiaq.de>
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/caiaq/device.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 9557c98..24355f5 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,7 +35,7 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.14");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.15");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
@@ -424,14 +424,6 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	usb_string(usb_dev, usb_dev->descriptor.iProduct,
 		   dev->product_name, CAIAQ_USB_STR_LEN);
 
-	usb_string(usb_dev, usb_dev->descriptor.iSerialNumber,
-		   dev->serial, CAIAQ_USB_STR_LEN);
-
-	/* terminate serial string at first white space occurence */
-	c = strchr(dev->serial, ' ');
-	if (c)
-		*c = '\0';
-
 	strncpy(card->driver, MODNAME, sizeof(card->driver));
 	strncpy(card->shortname, dev->product_name, sizeof(card->shortname));
 
-- 
1.6.3.1
