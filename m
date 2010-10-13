From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: [PATCH 2/3] ASoC: don't register AC97 devices twice
Date: Wed, 13 Oct 2010 11:30:32 +0300
Message-ID: <15e79a86e59b82a36cd8e33490bfebc08dd0103c.1286958072.git.mika.westerberg@iki.fi>
References: <cover.1286958072.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C89A31039F0
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 10:30:29 +0200 (CEST)
Received: by mail-bw0-f51.google.com with SMTP id 18so3567297bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 01:30:29 -0700 (PDT)
In-Reply-To: <cover.1286958072.git.mika.westerberg@iki.fi>
In-Reply-To: <cover.1286958072.git.mika.westerberg@iki.fi>
References: <cover.1286958072.git.mika.westerberg@iki.fi>
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
Cc: Mika Westerberg <mika.westerberg@iki.fi>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

With generic AC97 ASoC glue driver (codec/ac97.c), we get following warning when
the device is registered (slightly stripped the backtrace):

kobject (c5a863e8): tried to init an initialized object, something is seriously
                    wrong.
[<c00254fc>] (unwind_backtrace+0x0/0xec)
[<c014fad0>] (kobject_init+0x38/0x70)
[<c0171e94>] (device_initialize+0x20/0x70)
[<c017267c>] (device_register+0xc/0x18)
[<bf20db70>] (snd_soc_instantiate_cards+0x924/0xacc [snd_soc_core])
[<bf20e0d0>] (snd_soc_register_platform+0x16c/0x198 [snd_soc_core])
[<c0175304>] (platform_drv_probe+0x18/0x1c)
[<c0174454>] (driver_probe_device+0xb0/0x16c)
[<c017456c>] (__driver_attach+0x5c/0x7c)
[<c0173cec>] (bus_for_each_dev+0x48/0x78)
[<c0173600>] (bus_add_driver+0x98/0x214)
[<c0174834>] (driver_register+0xa4/0x130)
[<c001f410>] (do_one_initcall+0xd0/0x1a4)
[<c0062ddc>] (sys_init_module+0x12b0/0x1454)

This happens because the generic AC97 glue driver creates its codec->ac97 via
calling snd_ac97_mixer(). snd_ac97_mixer() provides own version of
snd_device.register which handles the device registration when
snd_card_register() is called.

To avoid registering the AC97 device twice, we add a new flag to the
snd_soc_codec: ac97_created which tells whether the AC97 device was created by
SoC subsystem.

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
I'm not sure whether this is the best solution to the issue. Maybe we could just
check codec->ac97->dev.bus and refuse to register the device again?

 include/sound/soc.h  |    1 +
 sound/soc/soc-core.c |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4fb079e..5c3bce8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -442,6 +442,7 @@ struct snd_soc_codec {
 	unsigned int suspended:1; /* Codec is in suspend PM state */
 	unsigned int probed:1; /* Codec has been probed */
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
+	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int sysfs_registered:1; /* codec has been sysfs registered */
 
 	/* codec IO */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8751efd..7d22b5d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1497,6 +1497,16 @@ static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 	 * for the generic AC97 subsystem.
 	 */
 	if (rtd->codec_dai->driver->ac97_control && !rtd->codec->ac97_registered) {
+		/*
+		 * It is possible that the AC97 device is already registered to
+		 * the device subsystem. This happens when the device is created
+		 * via snd_ac97_mixer(). Currently only SoC codec that does so
+		 * is the generic AC97 glue but others migh emerge.
+		 *
+		 * In those cases we don't try to register the device again.
+		 */
+		if (!rtd->codec->ac97_created)
+			return 0;
 
 		ret = soc_ac97_dev_register(rtd->codec);
 		if (ret < 0) {
@@ -1812,6 +1822,13 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 
 	codec->ac97->bus->ops = ops;
 	codec->ac97->num = num;
+
+	/*
+	 * Mark the AC97 device to be created by us. This way we ensure that the
+	 * device will be registered with the device subsystem later on.
+	 */
+	codec->ac97_created = 1;
+
 	mutex_unlock(&codec->mutex);
 	return 0;
 }
@@ -1832,6 +1849,7 @@ void snd_soc_free_ac97_codec(struct snd_soc_codec *codec)
 	kfree(codec->ac97->bus);
 	kfree(codec->ac97);
 	codec->ac97 = NULL;
+	codec->ac97_created = 0;
 	mutex_unlock(&codec->mutex);
 }
 EXPORT_SYMBOL_GPL(snd_soc_free_ac97_codec);
-- 
1.5.6.5
