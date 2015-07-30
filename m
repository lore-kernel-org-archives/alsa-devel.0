From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 13/27] ALSA: ppc: keywest: Export I2C module alias information
Date: Thu, 30 Jul 2015 18:18:38 +0200
Message-ID: <1438273132-20926-14-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So the driver needs to export the I2C table and this
be built into the module or udev won't have the necessary information
to auto load the correct module when the device is added.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 sound/ppc/keywest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 6120a067494a..f644a8c57e0a 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -101,6 +101,7 @@ static const struct i2c_device_id keywest_i2c_id[] = {
 	{ "keywest", 0 },		/* instantiated by us if needed */
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, keywest_i2c_id);
 
 static struct i2c_driver keywest_driver = {
 	.driver = {
-- 
2.4.3
