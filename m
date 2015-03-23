From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: ak411x: simplify snd_ak4113_create() a bit
Date: Mon, 23 Mar 2015 12:34:46 +0300
Message-ID: <20150323093445.GA558@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

"err" is always a negative error code here, so there is no point in
checking.  Removing the check silences a static checker warning and
makes the code a bit more clear.  Also we don't need to initialize "err".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/i2c/other/ak4113.c b/sound/i2c/other/ak4113.c
index 8884488..2183e9e 100644
--- a/sound/i2c/other/ak4113.c
+++ b/sound/i2c/other/ak4113.c
@@ -73,7 +73,7 @@ int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
 		void *private_data, struct ak4113 **r_ak4113)
 {
 	struct ak4113 *chip;
-	int err = 0;
+	int err;
 	unsigned char reg;
 	static struct snd_device_ops ops = {
 		.dev_free =     snd_ak4113_dev_free,
@@ -109,7 +109,7 @@ int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
 
 __fail:
 	snd_ak4113_free(chip);
-	return err < 0 ? err : -EIO;
+	return err;
 }
 EXPORT_SYMBOL_GPL(snd_ak4113_create);
 
