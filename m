From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [RESEND PATCH 4/7] ALSA: ppc: keywest: Export I2C module alias information
Date: Tue, 25 Aug 2015 08:31:14 +0200
Message-ID: <1440484277-32675-5-git-send-email-javier@osg.samsung.com>
References: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.com>
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
