From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Make a few struct const" to the
	asoc tree
Date: Tue, 19 Sep 2017 14:47:21 +0100
Message-ID: <E1duIrx-0008Qe-Gj@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D4F10267480
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:47:38 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Make a few struct const

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

>From 72d7a16bb07582f8416bbcdc65fe2a1e63f11294 Mon Sep 17 00:00:00 2001
From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 15 Sep 2017 10:27:10 +0200
Subject: [PATCH] ASoC: rt5645: Make a few struct const

These dmi_system_id structures and associated platform data are
never modified so they can be marked const.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
--
 sound/soc/codecs/rt5645.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a98647ac497c..4b2dbf0c3409 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3637,14 +3637,14 @@ static const struct dmi_system_id dmi_platform_gpd_win[] = {
 	{}
 };
 
-static struct rt5645_platform_data general_platform_data2 = {
+static const struct rt5645_platform_data general_platform_data2 = {
 	.dmic1_data_pin = RT5645_DMIC_DATA_IN2N,
 	.dmic2_data_pin = RT5645_DMIC2_DISABLE,
 	.jd_mode = 3,
 	.inv_jd1_1 = true,
 };
 
-static struct dmi_system_id dmi_platform_asus_t100ha[] = {
+static const struct dmi_system_id dmi_platform_asus_t100ha[] = {
 	{
 		.ident = "ASUS T100HAN",
 		.matches = {
@@ -3655,11 +3655,11 @@ static struct dmi_system_id dmi_platform_asus_t100ha[] = {
 	{ }
 };
 
-static struct rt5645_platform_data minix_z83_4_platform_data = {
+static const struct rt5645_platform_data minix_z83_4_platform_data = {
 	.jd_mode = 3,
 };
 
-static struct dmi_system_id dmi_platform_minix_z83_4[] = {
+static const struct dmi_system_id dmi_platform_minix_z83_4[] = {
 	{
 		.ident = "MINIX Z83-4",
 		.matches = {
-- 
2.14.1
