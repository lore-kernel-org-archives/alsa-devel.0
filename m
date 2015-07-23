From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: ac97: Add helper function to reset the
	AC97 device" to the asoc tree
Date: Thu, 23 Jul 2015 17:34:11 +0100
Message-ID: <E1ZIJRj-0001RI-Kl@debutante>
References: <1437508386-13828-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 084E5265864
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 18:34:18 +0200 (CEST)
In-Reply-To: <1437508386-13828-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: ac97: Add helper function to reset the AC97 device

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5f1d980ee9b6353f18765bfa6774a5a08d6cb944 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 21:53:00 +0200
Subject: [PATCH] ALSA: ac97: Add helper function to reset the AC97 device

There is currently a lot of code duplication in ASoC drivers regarding the
reset handling of devices. This patch introduces a new generic reset
function in the generic AC'97 framework that can be used to replace most
the custom reset functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/ac97_codec.h |  2 ++
 sound/ac97_bus.c           | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 0e9d75b49bed..74bc85473b58 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -584,6 +584,8 @@ static inline int snd_ac97_update_power(struct snd_ac97 *ac97, int reg,
 void snd_ac97_suspend(struct snd_ac97 *ac97);
 void snd_ac97_resume(struct snd_ac97 *ac97);
 #endif
+int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
+	unsigned int id_mask);
 
 /* quirk types */
 enum {
diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index 2b50cbe6aca9..55791a0b3943 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -18,6 +18,68 @@
 #include <sound/ac97_codec.h>
 
 /*
+ * snd_ac97_check_id() - Reads and checks the vendor ID of the device
+ * @ac97: The AC97 device to check
+ * @id: The ID to compare to
+ * @id_mask: Mask that is applied to the device ID before comparing to @id
+ *
+ * If @id is 0 this function returns true if the read device vendor ID is
+ * a valid ID. If @id is non 0 this functions returns true if @id
+ * matches the read vendor ID. Otherwise the function returns false.
+ */
+static bool snd_ac97_check_id(struct snd_ac97 *ac97, unsigned int id,
+	unsigned int id_mask)
+{
+	ac97->id = ac97->bus->ops->read(ac97, AC97_VENDOR_ID1) << 16;
+	ac97->id |= ac97->bus->ops->read(ac97, AC97_VENDOR_ID2);
+
+	if (ac97->id == 0x0 || ac97->id == 0xffffffff)
+		return false;
+
+	if (id != 0 && id != (ac97->id & id_mask))
+		return false;
+
+	return true;
+}
+
+/**
+ * snd_ac97_reset() - Reset AC'97 device
+ * @ac97: The AC'97 device to reset
+ * @try_warm: Try a warm reset first
+ * @id: Expected device vendor ID
+ * @id_mask: Mask that is applied to the device ID before comparing to @id
+ *
+ * This function resets the AC'97 device. If @try_warm is true the function
+ * first performs a warm reset. If the warm reset is successful the function
+ * returns 1. Otherwise or if @try_warm is false the function issues cold reset
+ * followed by a warm reset. If this is successful the function returns 0,
+ * otherwise a negative error code. If @id is 0 any valid device ID will be
+ * accepted, otherwise only the ID that matches @id and @id_mask is accepted.
+ */
+int snd_ac97_reset(struct snd_ac97 *ac97, bool try_warm, unsigned int id,
+	unsigned int id_mask)
+{
+	struct snd_ac97_bus_ops *ops = ac97->bus->ops;
+
+	if (try_warm && ops->warm_reset) {
+		ops->warm_reset(ac97);
+		if (snd_ac97_check_id(ac97, id, id_mask))
+			return 1;
+	}
+
+	if (ops->reset)
+		ops->reset(ac97);
+	if (ops->warm_reset)
+		ops->warm_reset(ac97);
+
+	if (snd_ac97_check_id(ac97, id, id_mask))
+		return 0;
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(snd_ac97_reset);
+
+/*
  * Let drivers decide whether they want to support given codec from their
  * probe method. Drivers have direct access to the struct snd_ac97
  * structure and may  decide based on the id field amongst other things.
-- 
2.1.4
