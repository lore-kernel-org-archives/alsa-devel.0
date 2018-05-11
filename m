From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add platform-data for Lenovo
	Ideapad Mixx 310" to the asoc tree
Date: Fri, 11 May 2018 03:38:11 +0100 (BST)
Message-ID: <20180511023811.C101E44007A@finisterre.ee.mobilebroadband>
References: <20180428202503.18645-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3517B267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:38:18 +0200 (CEST)
In-Reply-To: <20180428202503.18645-1-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add platform-data for Lenovo Ideapad Mixx 310

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

>From 87927581fc7b42719ba2fe23b690efb289459591 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 28 Apr 2018 22:25:02 +0200
Subject: [PATCH] ASoC: rt5645: Add platform-data for Lenovo Ideapad Mixx 310

The Lenovo Ideapad Mixx 310 has a differential internal analog mic,
add platform-data for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index bc8d829ce45b..70f351c61d41 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3652,6 +3652,11 @@ static const struct rt5645_platform_data asus_t100ha_platform_data = {
 	.inv_jd1_1 = true,
 };
 
+static const struct rt5645_platform_data lenovo_ideapad_miix_310_pdata = {
+	.jd_mode = 3,
+	.in2_diff = true,
+};
+
 static const struct rt5645_platform_data jd_mode3_platform_data = {
 	.jd_mode = 3,
 };
@@ -3735,6 +3740,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&jd_mode3_platform_data,
 	},
+	{
+		.ident = "Lenovo Ideapad Miix 310",
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "80SG"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "MIIX 310-10ICR"),
+		},
+		.driver_data = (void *)&lenovo_ideapad_miix_310_pdata,
+	},
 	{ }
 };
 
-- 
2.17.0
