From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add jack detection workaround
	for MINIX Z83-4 based devices" to the asoc tree
Date: Thu, 31 Aug 2017 10:30:13 +0100
Message-ID: <E1dnLnh-0004eI-KZ@debutante>
References: <c4388022-ba28-6b87-e34d-97af0cbdbd39@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DA5C3267256
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:30:18 +0200 (CEST)
In-Reply-To: <c4388022-ba28-6b87-e34d-97af0cbdbd39@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: tiwai@suse.de, Ian W Morrison <ianwmorrison@gmail.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add jack detection workaround for MINIX Z83-4 based devices

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

>From 88faae2c2e35c88a806c052a7fc20948211b0895 Mon Sep 17 00:00:00 2001
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Thu, 31 Aug 2017 08:35:47 +1000
Subject: [PATCH] ASoC: rt5645: Add jack detection workaround for MINIX Z83-4
 based devices

The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices requires jd_mode=3
to make the jack detection work. Using a BIOS DMI product of "Z83-4"
will match both devices of 'NEO Z83-4' and 'Z83-4 Pro'.

Signed-off-by: Ian W Morrison <ianwmorrison@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index d2f038001908..2e145f089d9d 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3655,6 +3655,21 @@ static struct dmi_system_id dmi_platform_asus_t100ha[] = {
 	{ }
 };
 
+static struct rt5645_platform_data minix_z83_4_platform_data = {
+	.jd_mode = 3,
+};
+
+static struct dmi_system_id dmi_platform_minix_z83_4[] = {
+	{
+		.ident = "MINIX Z83-4",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
+		},
+	},
+	{ }
+};
+
 static bool rt5645_check_dp(struct device *dev)
 {
 	if (device_property_present(dev, "realtek,in2-differential") ||
@@ -3709,6 +3724,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645->pdata = gpd_win_platform_data;
 	else if (dmi_check_system(dmi_platform_asus_t100ha))
 		rt5645->pdata = general_platform_data2;
+	else if (dmi_check_system(dmi_platform_minix_z83_4))
+		rt5645->pdata = minix_z83_4_platform_data;
 
 	if (quirk != -1) {
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
-- 
2.14.1
