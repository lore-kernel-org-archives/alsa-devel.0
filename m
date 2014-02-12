From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/20] ALSA: aoa: Use SNDRV_DEV_CODEC for AOA
	codec objects
Date: Wed, 12 Feb 2014 11:52:15 +0100
Message-ID: <1392202347-11774-9-git-send-email-tiwai@suse.de>
References: <1392202347-11774-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 04C132651BE
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:52:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CA63DAC5B
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:52:47 +0000 (UTC)
In-Reply-To: <1392202347-11774-1-git-send-email-tiwai@suse.de>
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

... instead of SNDRV_DEV_LOWLEVEL.
No functional change at this point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/aoa/codecs/onyx.c   | 2 +-
 sound/aoa/codecs/tas.c    | 2 +-
 sound/aoa/codecs/toonie.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 4cedc6950d72..f01bffb702bc 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -889,7 +889,7 @@ static int onyx_init_codec(struct aoa_codec *codec)
 		return -ENODEV;
 	}
 
-	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, onyx, &ops)) {
+	if (aoa_snd_device_new(SNDRV_DEV_CODEC, onyx, &ops)) {
 		printk(KERN_ERR PFX "failed to create onyx snd device!\n");
 		return -ENODEV;
 	}
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index c491ae0f749c..cf3c6303b7e3 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -826,7 +826,7 @@ static int tas_init_codec(struct aoa_codec *codec)
 		return -ENODEV;
 	}
 
-	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, tas, &ops)) {
+	if (aoa_snd_device_new(SNDRV_DEV_CODEC, tas, &ops)) {
 		printk(KERN_ERR PFX "failed to create tas snd device!\n");
 		return -ENODEV;
 	}
diff --git a/sound/aoa/codecs/toonie.c b/sound/aoa/codecs/toonie.c
index 69d2cb601f2a..7e8c3417cd85 100644
--- a/sound/aoa/codecs/toonie.c
+++ b/sound/aoa/codecs/toonie.c
@@ -92,7 +92,7 @@ static int toonie_init_codec(struct aoa_codec *codec)
 	if (toonie->codec.connected != 1)
 		return -ENOTCONN;
 
-	if (aoa_snd_device_new(SNDRV_DEV_LOWLEVEL, toonie, &ops)) {
+	if (aoa_snd_device_new(SNDRV_DEV_CODEC, toonie, &ops)) {
 		printk(KERN_ERR PFX "failed to create toonie snd device!\n");
 		return -ENODEV;
 	}
-- 
1.8.5.2
