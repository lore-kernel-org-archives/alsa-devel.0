From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ALSA: aoa: Convert onyx and tas codec drivers
 to module_i2c_driver
Date: Fri, 27 Jan 2012 15:23:51 +0800
Message-ID: <1327649031.3758.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 63FAD24525
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 08:24:06 +0100 (CET)
Received: by ggm4 with SMTP id 4so724355ggm.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 23:24:03 -0800 (PST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

This patch converts onyx and tas codec drivers to use the module_i2c_driver()
macro which makes the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/aoa/codecs/onyx.c |   13 +------------
 sound/aoa/codecs/tas.c  |   13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 762af68..270790d 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -1132,15 +1132,4 @@ static struct i2c_driver onyx_driver = {
 	.id_table = onyx_i2c_id,
 };
 
-static int __init onyx_init(void)
-{
-	return i2c_add_driver(&onyx_driver);
-}
-
-static void __exit onyx_exit(void)
-{
-	i2c_del_driver(&onyx_driver);
-}
-
-module_init(onyx_init);
-module_exit(onyx_exit);
+module_i2c_driver(onyx_driver);
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index fd2188c..8e63d1f 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -1026,15 +1026,4 @@ static struct i2c_driver tas_driver = {
 	.id_table = tas_i2c_id,
 };
 
-static int __init tas_init(void)
-{
-	return i2c_add_driver(&tas_driver);
-}
-
-static void __exit tas_exit(void)
-{
-	i2c_del_driver(&tas_driver);
-}
-
-module_init(tas_init);
-module_exit(tas_exit);
+module_i2c_driver(tas_driver);
-- 
1.7.5.4
