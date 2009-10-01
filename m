From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] sound: Make keywest_driver static
Date: Thu, 1 Oct 2009 18:08:18 +0200
Message-ID: <20091001180818.60bab7ad@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 88AAC244DC
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 18:08:21 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Jean Delvare <khali@linux-fr.org>
Subject: sound: Make keywest_driver static

I can't see any reason for struct i2c_driver keywest_driver to not be
static.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/ppc/keywest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.32-rc1.orig/sound/ppc/keywest.c	2009-10-01 09:45:18.000000000 +0200
+++ linux-2.6.32-rc1/sound/ppc/keywest.c	2009-10-01 18:05:06.000000000 +0200
@@ -93,7 +93,7 @@ static const struct i2c_device_id keywes
 	{ }
 };
 
-struct i2c_driver keywest_driver = {
+static struct i2c_driver keywest_driver = {
 	.driver = {
 		.name = "PMac Keywest Audio",
 	},


-- 
Jean Delvare
