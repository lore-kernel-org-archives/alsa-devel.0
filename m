From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Change default
	input map from in2 to in1" to the asoc tree
Date: Wed, 27 Jun 2018 12:32:11 +0100 (BST)
Message-ID: <20180627113211.B697B440070@finisterre.ee.mobilebroadband>
References: <20180624140634.16835-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ACF102679C1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 13:32:13 +0200 (CEST)
In-Reply-To: <20180624140634.16835-3-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Change default input map from in2 to in1

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

>From 10876d24eb40c6bfaa0aabd97e3e143258176c53 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 24 Jun 2018 16:06:27 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Change default input map from in2
 to in1

Further testing on all 6 model x86 tablets with a rt5651 which I have
access to for testing has shown that their single (mono) microphone is
connected to both IN1 *and* IN2.

The previous default mapping of IN2 was based on testing on the same 6
tablets, where the internal mic works fine with a mapping of IN2. But it
works fine too with a mapping of IN1.

This commit changes the default input mapping to to use IN1 instead of
IN2, to match the mapping used for the other mono devices in the DMI quirk
table. So that we need less different mappings.

The same change is made to the Chuwi Vi8 Plus quirks, which is one of the
6 models tested.

This is a preparation patch for simplifying the maps in a follow-up commit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 735b8312e275..910890de38b0 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -90,9 +90,9 @@ struct byt_rt5651_private {
 	struct snd_soc_jack jack;
 };
 
-/* Default: jack-detect on JD1_1, internal mic on in2, headsetmic on in3 */
+/* Default: jack-detect on JD1_1, internal mic on in1, headsetmic on in3 */
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN2_HS_IN3_MAP;
+					BYT_RT5651_IN1_HS_IN3_MAP;
 
 static void log_quirks(struct device *dev)
 {
@@ -392,7 +392,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN2_HS_IN3_MAP),
+					BYT_RT5651_IN1_HS_IN3_MAP),
 	},
 	{
 		/* VIOS LTH17 */
-- 
2.17.1
