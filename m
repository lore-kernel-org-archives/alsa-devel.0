From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 3/5] ALSA: snd_usb_caiaq: use strncpy
Date: Sat, 30 May 2009 22:25:21 +0200
Message-ID: <1243715123-16414-3-git-send-email-daniel@caiaq.de>
References: <y> <1243715123-16414-1-git-send-email-daniel@caiaq.de>
	<1243715123-16414-2-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 516D624344
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 22:25:37 +0200 (CEST)
In-Reply-To: <1243715123-16414-2-git-send-email-daniel@caiaq.de>
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
 sound/usb/caiaq/device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 4756b48..d55724a 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -432,8 +432,8 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
 	if (c)
 		*c = '\0';
 
-	strcpy(card->driver, MODNAME);
-	strcpy(card->shortname, dev->product_name);
+	strncpy(card->driver, MODNAME, sizeof(card->driver));
+	strncpy(card->shortname, dev->product_name, sizeof(card->shortname));
 
 	/* replace ' ' with '_' in device shortname */
 	for (c = card->shortname; *c; c++)
-- 
1.6.3.1
