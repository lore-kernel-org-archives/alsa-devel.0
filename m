From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 030/493] ASoC: max98088: remove use of
	__devexit_p
Date: Mon, 19 Nov 2012 13:19:39 -0500
Message-ID: <1353349642-3677-30-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viridian.itc.virginia.edu (viridian.itc.virginia.edu
 [128.143.12.139])
 by alsa0.perex.cz (Postfix) with ESMTP id A4BB3261731
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 19:27:25 +0100 (CET)
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed, remove it.

Also fix the indentation for the initialization of the
max98088_i2c_driver struct to make chkpatch happy.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: alsa-devel@alsa-project.org 
---
 sound/soc/codecs/max98088.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 3264a51..b858264 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -2098,13 +2098,13 @@ static const struct i2c_device_id max98088_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, max98088_i2c_id);
 
 static struct i2c_driver max98088_i2c_driver = {
-       .driver = {
-               .name = "max98088",
-               .owner = THIS_MODULE,
-       },
-       .probe  = max98088_i2c_probe,
-       .remove = __devexit_p(max98088_i2c_remove),
-       .id_table = max98088_i2c_id,
+	.driver = {
+		.name = "max98088",
+		.owner = THIS_MODULE,
+	},
+	.probe  = max98088_i2c_probe,
+	.remove = max98088_i2c_remove,
+	.id_table = max98088_i2c_id,
 };
 
 module_i2c_driver(max98088_i2c_driver);
-- 
1.8.0
