From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ALSA: aoa: Remove obsolete cleanup for clientdata
Date: Fri, 09 Sep 2011 19:04:45 +0800
Message-ID: <1315566285.2453.1.camel@phoenix>
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

Also remove a unneeded NULL checking for kfree.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
---
 sound/aoa/codecs/onyx.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 3687a6c..762af68 100644
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
@@ -1112,8 +1111,7 @@ static int onyx_i2c_remove(struct i2c_client *client)
 
 	aoa_codec_unregister(&onyx->codec);
 	of_node_put(onyx->codec.node);
-	if (onyx->codec_info)
-		kfree(onyx->codec_info);
+	kfree(onyx->codec_info);
 	kfree(onyx);
 	return 0;
 }
-- 
1.7.4.1
