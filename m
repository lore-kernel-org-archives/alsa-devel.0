From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: samsung: odroid: Add missing DAPM routes
Date: Fri, 15 Feb 2019 13:04:22 +0100
Message-ID: <20190215120422.22907-1-s.nawrocki@samsung.com>
References: <CGME20190215120457epcas2p3cd14657fc2159c058ab6448c10a47648@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com, m.szyprowski@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

With old DTS there will be missing DAPM routes linking BE with CODECs.
Add those routes in the card driver so sound works properly on Odroid
XU3/4 also without DTS updates enabling the secondary PCM.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
This patch might require my previous patch
"ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM"
to apply cleanly.
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
2.17.1
