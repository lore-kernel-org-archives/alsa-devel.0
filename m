From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: lowland: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:01 +0100 (BST)
Message-ID: <20190606212701.4B433440049@finisterre.sirena.org.uk>
References: <878sufl64u.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D7D1F8975C
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:02 +0200 (CEST)
In-Reply-To: <878sufl64u.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: lowland: use modern dai_link style

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7989919453afbaa997a848285ee1a3b940f11e4d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:10:36 +0900
Subject: [PATCH] ASoC: samsung: lowland: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/lowland.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 2fdab2ac8e8c..973f22bcc747 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -82,39 +82,45 @@ static const struct snd_soc_pcm_stream sub_params = {
 	.channels_max = 2,
 };
 
+SND_SOC_DAILINK_DEFS(cpu,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm5100.1-001a", "wm5100-aif1")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
+
+SND_SOC_DAILINK_DEFS(baseband,
+	DAILINK_COMP_ARRAY(COMP_CPU("wm5100-aif2")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm1250-ev1.1-0027", "wm1250-ev1")));
+
+SND_SOC_DAILINK_DEFS(speaker,
+	DAILINK_COMP_ARRAY(COMP_CPU("wm5100-aif3")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9081.1-006c", "wm9081-hifi")));
+
 static struct snd_soc_dai_link lowland_dai[] = {
 	{
 		.name = "CPU",
 		.stream_name = "CPU",
-		.cpu_dai_name = "samsung-i2s.0",
-		.codec_dai_name = "wm5100-aif1",
-		.platform_name = "samsung-i2s.0",
-		.codec_name = "wm5100.1-001a",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				SND_SOC_DAIFMT_CBM_CFM,
 		.init = lowland_wm5100_init,
+		SND_SOC_DAILINK_REG(cpu),
 	},
 	{
 		.name = "Baseband",
 		.stream_name = "Baseband",
-		.cpu_dai_name = "wm5100-aif2",
-		.codec_dai_name = "wm1250-ev1",
-		.codec_name = "wm1250-ev1.1-0027",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(baseband),
 	},
 	{
 		.name = "Sub Speaker",
 		.stream_name = "Sub Speaker",
-		.cpu_dai_name = "wm5100-aif3",
-		.codec_dai_name = "wm9081-hifi",
-		.codec_name = "wm9081.1-006c",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				SND_SOC_DAIFMT_CBM_CFM,
 		.ignore_suspend = 1,
 		.params = &sub_params,
 		.init = lowland_wm9081_init,
+		SND_SOC_DAILINK_REG(speaker),
 	},
 };
 
-- 
2.20.1
