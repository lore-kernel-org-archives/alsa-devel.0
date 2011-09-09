From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ALSA: aoa: Remove obsolete cleanup for clientdata
Date: Fri, 09 Sep 2011 17:49:44 +0800
Message-ID: <1315561784.2831.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Wolfram Sang <w.sang@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The i2c core will clear the clientdata pointer automatically.
We don't have to set the `data' field to NULL in remove() or
if probe() failed anymore.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/aoa/codecs/onyx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 3687a6c..571f668 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -1067,7 +1067,6 @@ static int onyx_i2c_probe(struct i2c_client *client,
 	printk(KERN_DEBUG PFX "created and attached onyx instance\n");
 	return 0;
  fail:
-	i2c_set_clientdata(client, NULL);
 	kfree(onyx);
 	return -ENODEV;
 }
-- 
1.7.4.1
