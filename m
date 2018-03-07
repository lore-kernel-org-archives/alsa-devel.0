From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Add quirk for the
	VIOS LTH17 laptop" to the asoc tree
Date: Wed, 07 Mar 2018 14:21:53 +0000
Message-ID: <E1etZx3-0002hV-IZ@debutante>
References: <20180225104713.4745-31-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 55469267048
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:21:58 +0100 (CET)
In-Reply-To: <20180225104713.4745-31-hdegoede@redhat.com>
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

   ASoC: Intel: bytcr_rt5651: Add quirk for the VIOS LTH17 laptop

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

>From f9877eb598d5bd2e6d9b4dc28068b66c464d1e5f Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:08 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Add quirk for the VIOS LTH17
 laptop

Add a quirk setting up jack-detect and input routing for the
VIOS LTH17 laptop.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 103c4b0e6505..d5a3d48294d2 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -393,6 +393,19 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_OVCD_SF_0P75 |
 					BYT_RT5651_IN2_HS_IN3_MAP),
 	},
+	{
+		/* VIOS LTH17 */
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "VIOS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LTH17"),
+		},
+		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVCD_TH_2000UA |
+					BYT_RT5651_OVCD_SF_1P0 |
+					BYT_RT5651_IN1_IN2_MAP),
+	},
 	{}
 };
 
-- 
2.16.2
