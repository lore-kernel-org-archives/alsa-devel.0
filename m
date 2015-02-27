From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 9/9] ALSA: hda - Drop codec driver module
	refcounting
Date: Fri, 27 Feb 2015 23:55:44 +0100
Message-ID: <1425077744-4553-10-git-send-email-tiwai@suse.de>
References: <1425077744-4553-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD142651D1
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 23:55:47 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 99029AC77
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 22:55:46 +0000 (UTC)
In-Reply-To: <1425077744-4553-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since we have a full safe control of codec driver bind/unbind, we can
lower the safety bar -- the module refcount from the controller
driver.  This have always annoyed some people because it interferes
rmmod in the order of lsmod (due to the reversed dependency).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_bind.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index ba1adbf0f85f..529aec82d3b2 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -91,7 +91,6 @@ static int codec_refresh_name(struct hda_codec *codec, const char *name)
 static int hda_codec_driver_probe(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
-	struct module *owner = dev->driver->owner;
 	int err;
 
 	if (WARN_ON(!codec->preset))
@@ -101,35 +100,27 @@ static int hda_codec_driver_probe(struct device *dev)
 	if (err < 0)
 		goto error;
 
-	if (!try_module_get(owner)) {
-		err = -EINVAL;
-		goto error;
-	}
-
 	err = snd_hda_regmap_init(codec);
 	if (err < 0)
 		goto error;
 	err = codec->preset->patch(codec);
 	if (err < 0)
-		goto error_module;
+		goto error;
 
 	err = snd_hda_codec_build_pcms(codec);
 	if (err < 0)
-		goto error_module;
+		goto error;
 	err = snd_hda_codec_build_controls(codec);
 	if (err < 0)
-		goto error_module;
+		goto error;
 	if (codec->card->registered) {
 		err = snd_card_register(codec->card);
 		if (err < 0)
-			goto error_module;
+			goto error;
 	}
 
 	return 0;
 
- error_module:
-	module_put(owner);
-
  error:
 	snd_hda_codec_cleanup_for_unbind(codec);
 	snd_hda_regmap_exit(codec);
@@ -144,7 +135,6 @@ static int hda_codec_driver_remove(struct device *dev)
 		codec->patch_ops.free(codec);
 	snd_hda_codec_cleanup_for_unbind(codec);
 	snd_hda_regmap_exit(codec);
-	module_put(dev->driver->owner);
 	return 0;
 }
 
-- 
2.3.0
