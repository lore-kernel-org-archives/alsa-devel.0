From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 2/8] ASoC: AD1980 codec: add multi-channel
	function support
Date: Tue, 18 Nov 2008 16:18:16 +0800
Message-ID: <1226996302-10234-3-git-send-email-cooloney@kernel.org>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id E873B244CB
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:16:59 +0100 (CET)
In-Reply-To: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, tiwai@suse.de
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

We added multi-channel function to this codec driver and Blackfin ASoC driver as well.
It was tested on Blackfin hardware.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/codecs/ad1980.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index 1397b8e..410fed9 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -85,6 +85,9 @@ SOC_DOUBLE("Line HP Swap Switch", AC97_AD_MISC, 10, 5, 1, 0),
 SOC_DOUBLE("Surround Playback Volume", AC97_SURROUND_MASTER, 8, 0, 31, 1),
 SOC_DOUBLE("Surround Playback Switch", AC97_SURROUND_MASTER, 15, 7, 1, 1),
 
+SOC_DOUBLE("Center/LFE Playback Volume", AC97_CENTER_LFE_MASTER, 8, 0, 31, 1),
+SOC_DOUBLE("Center/LFE Playback Switch", AC97_CENTER_LFE_MASTER, 15, 7, 1, 1),
+
 SOC_ENUM("Capture Source", ad1980_cap_src),
 
 SOC_SINGLE("Mic Boost Switch", AC97_MIC, 6, 1, 0),
@@ -145,7 +148,7 @@ struct snd_soc_dai ad1980_dai = {
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 6,
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE, },
 	.capture = {
@@ -192,6 +195,7 @@ static int ad1980_soc_probe(struct platform_device *pdev)
 	struct snd_soc_codec *codec;
 	int ret = 0;
 	u16 vendor_id2;
+	u16 ext_status;
 
 	printk(KERN_INFO "AD1980 SoC Audio Codec\n");
 
@@ -253,9 +257,16 @@ static int ad1980_soc_probe(struct platform_device *pdev)
 				"supported\n");
 	}
 
-	ac97_write(codec, AC97_MASTER, 0x0000); /* unmute line out volume */
-	ac97_write(codec, AC97_PCM, 0x0000);	/* unmute PCM out volume */
-	ac97_write(codec, AC97_REC_GAIN, 0x0000);/* unmute record volume */
+	/* unmute captures and playbacks volume */
+	ac97_write(codec, AC97_MASTER, 0x0000);
+	ac97_write(codec, AC97_PCM, 0x0000);
+	ac97_write(codec, AC97_REC_GAIN, 0x0000);
+	ac97_write(codec, AC97_CENTER_LFE_MASTER, 0x0000);
+	ac97_write(codec, AC97_SURROUND_MASTER, 0x0000);
+
+	/*power on LFE/CENTER/Surround DACs*/
+	ext_status = ac97_read(codec, AC97_EXTENDED_STATUS);
+	ac97_write(codec, AC97_EXTENDED_STATUS, ext_status&~0x3800);
 
 	ad1980_add_controls(codec);
 	ret = snd_soc_register_card(socdev);
-- 
1.5.6.3
