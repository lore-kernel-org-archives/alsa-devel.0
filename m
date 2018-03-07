From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Actually honor the
	DMIC_EN quirk if specified" to the asoc tree
Date: Wed, 07 Mar 2018 14:22:37 +0000
Message-ID: <E1etZxl-0002qr-T2@debutante>
References: <20180304143610.21125-13-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AF6D2673A4
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:22:43 +0100 (CET)
In-Reply-To: <20180304143610.21125-13-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Actually honor the DMIC_EN quirk if specified

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c2f26938d2a456dcf429385617e58cfd510a64a8 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:00 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Actually honor the DMIC_EN quirk
 if specified

Before this commit it was possible to set the DMIC_EN quirk in the machine
driver, but it would never be passed to the codec driver so it was a nop.

This commit adds code to actually pass the quirk to the codec driver.

Since the DMIC_EN quirk was ignored before, this commit removes it from
the default quirk settings, to avoid this causing an unexpected functional
change. If we really want the DMIC_EN behavior anywhere it should be
specifically enabled by follow up commits.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 499e405e591b..a874bba3aec0 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -57,8 +57,8 @@ enum {
 #define BYT_RT5651_MCLK_EN		BIT(17)
 #define BYT_RT5651_MCLK_25MHZ		BIT(18)
 
-/* jack-detect-source + terminating empty entry */
-#define MAX_NO_PROPS 2
+/* jack-detect-source + dmic-en + terminating empty entry */
+#define MAX_NO_PROPS 3
 
 struct byt_rt5651_private {
 	struct clk *mclk;
@@ -66,7 +66,6 @@ struct byt_rt5651_private {
 };
 
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DMIC_MAP |
-					BYT_RT5651_DMIC_EN |
 					BYT_RT5651_MCLK_EN;
 
 static void log_quirks(struct device *dev)
@@ -327,6 +326,9 @@ static int byt_rt5651_add_codec_device_props(const char *i2c_dev_name)
 	props[cnt++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
 				BYT_RT5651_JDSRC(byt_rt5651_quirk));
 
+	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
+		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,dmic-en");
+
 	ret = device_add_properties(i2c_dev, props);
 	put_device(i2c_dev);
 
-- 
2.16.2
