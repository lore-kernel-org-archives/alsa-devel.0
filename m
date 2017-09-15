From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ASoC: rt5645: Make a few struct const
Date: Fri, 15 Sep 2017 10:27:10 +0200
Message-ID: <20170915102710.0e4550b2@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3899C266C85
 for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2017 10:27:12 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Ian W Morrison <ianwmorrison@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

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

--- linux-4.14-rc0.orig/sound/soc/codecs/rt5645.c	2017-09-14 11:08:35.328003671 +0200
+++ linux-4.14-rc0/sound/soc/codecs/rt5645.c	2017-09-14 11:38:34.014328130 +0200
@@ -3637,14 +3637,14 @@ static const struct dmi_system_id dmi_pl
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
@@ -3655,11 +3655,11 @@ static struct dmi_system_id dmi_platform
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
Jean Delvare
SUSE L3 Support
