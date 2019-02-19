From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: odroid: Add missing DAPM
	routes" to the asoc tree
Date: Tue, 19 Feb 2019 11:47:00 +0000 (GMT)
Message-ID: <20190219114700.B1C0211284A6@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A979265523
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 12:47:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: odroid: Add missing DAPM routes

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

>From f89aea0f132142b29dc0c8cf4d445bd12db7b1a6 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 15 Feb 2019 13:04:22 +0100
Subject: [PATCH] ASoC: samsung: odroid: Add missing DAPM routes

With old DTS there will be missing DAPM routes linking BE with CODECs.
Add those routes in the card driver so sound works properly on Odroid
XU3/4 also without DTS updates enabling the secondary PCM.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 941e8c3f67a4..5b2bcd1d3450 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -149,6 +149,12 @@ static const struct snd_soc_ops odroid_card_be_ops = {
 	.trigger = odroid_card_be_trigger,
 };
 
+/* DAPM routes for backward compatibility with old DTS */
+static const struct snd_soc_dapm_route odroid_dapm_routes[] = {
+	{ "I2S Playback", NULL, "Mixer DAI TX" },
+	{ "HiFi Playback", NULL, "Mixer DAI TX" },
+};
+
 static struct snd_soc_dai_link odroid_card_dais[] = {
 	{
 		/* Primary FE <-> BE link */
@@ -237,11 +243,15 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	/*
 	 * For backwards compatibility create the secondary CPU DAI link only
 	 * if there are 2 CPU DAI entries in the cpu sound-dai property in DT.
+	 * Also add required DAPM routes not available in old DTS.
 	 */
 	num_pcms = of_count_phandle_with_args(cpu, "sound-dai",
 					      "#sound-dai-cells");
-	if (num_pcms == 1)
+	if (num_pcms == 1) {
+		card->dapm_routes = odroid_dapm_routes;
+		card->num_dapm_routes = ARRAY_SIZE(odroid_dapm_routes);
 		card->num_links--;
+	}
 
 	for (i = 0; i < num_pcms; i++, link += 2) {
 		ret = of_parse_phandle_with_args(cpu, "sound-dai",
-- 
2.20.1
