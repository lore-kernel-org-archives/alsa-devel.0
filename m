From: Jassi@alsa-project.org, "Brar <jassisinghbrar"@gmail.com
Subject: [PATCH 03/10] ASoC: SMDK_WM8580: Make I2S0 as default
	dai
Date: Mon, 20 Dec 2010 11:05:48 +0900
Message-ID: <1292810748-30000-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E864245B2
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 03:27:07 +0100 (CET)
In-Reply-To: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lrg@slimlogic.co.uk, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Since most newer SMDKs have I2S0 routed to the WM8580's Primary DAI,
future changes can be minimized if the default CPU DAIs are set to
0, rather than 2.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/samsung/smdk_wm8580.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index e2d56b9..e4f3bc8 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -212,7 +212,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	[PRI_PLAYBACK] = { /* Primary Playback i/f */
 		.name = "WM8580 PAIF RX",
 		.stream_name = "Playback",
-		.cpu_dai_name = "samsung-i2s.2",
+		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-audio",
 		.codec_name = "wm8580-codec.0-001b",
@@ -222,7 +222,7 @@ static struct snd_soc_dai_link smdk_dai[] = {
 	[PRI_CAPTURE] = { /* Primary Capture i/f */
 		.name = "WM8580 PAIF TX",
 		.stream_name = "Capture",
-		.cpu_dai_name = "samsung-i2s.2",
+		.cpu_dai_name = "samsung-i2s.0",
 		.codec_dai_name = "wm8580-hifi-capture",
 		.platform_name = "samsung-audio",
 		.codec_name = "wm8580-codec.0-001b",
@@ -256,14 +256,14 @@ static int __init smdk_audio_init(void)
 
 	if (machine_is_smdkc100()) {
 		smdk.num_links = 3;
-		/* S5PC100 has I2S0 as v5 */
-		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
-		str[strlen(str) - 1] = '0';
-		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
-		str[strlen(str) - 1] = '0';
 		/* Secondary is at offset SAMSUNG_I2S_SECOFF from Primary */
 		str = (char *)smdk_dai[SEC_PLAYBACK].cpu_dai_name;
 		str[strlen(str) - 1] = '0' + SAMSUNG_I2S_SECOFF;
+	} else if (machine_is_smdk6410()) {
+		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
+		str[strlen(str) - 1] = '2';
+		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
+		str[strlen(str) - 1] = '2';
 	}
 
 	smdk_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.6.2.5
