From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] keywest: Get rid of useless i2c_device_name()
	macro
Date: Thu, 14 May 2009 14:37:21 +0200
Message-ID: <20090514143721.2954805e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 11865243D2
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 14:37:33 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

The i2c_device_name() macro is used only once and doesn't have much
value, it hurts redability more than it helps. Get rid of it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 sound/ppc/keywest.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- linux-2.6.30-rc1.orig/sound/ppc/keywest.c	2009-04-10 16:22:08.000000000 +0200
+++ linux-2.6.30-rc1/sound/ppc/keywest.c	2009-04-10 16:25:16.000000000 +0200
@@ -33,10 +33,6 @@
 static struct pmac_keywest *keywest_ctx;
 
 
-#ifndef i2c_device_name
-#define i2c_device_name(x)	((x)->name)
-#endif
-
 static int keywest_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -56,7 +52,7 @@ static int keywest_attach_adapter(struct
 	if (! keywest_ctx)
 		return -EINVAL;
 
-	if (strncmp(i2c_device_name(adapter), "mac-io", 6))
+	if (strncmp(adapter->name, "mac-io", 6))
 		return 0; /* ignored */
 
 	memset(&info, 0, sizeof(struct i2c_board_info));


-- 
Jean Delvare
