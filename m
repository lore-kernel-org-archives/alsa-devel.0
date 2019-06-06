From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: efika-audio-fabric: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:35 +0100 (BST)
Message-ID: <20190606212635.8F183440046@finisterre.sirena.org.uk>
References: <87ef47icte.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BD24F897A0
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:36 +0200 (CEST)
In-Reply-To: <87ef47icte.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: fsl: efika-audio-fabric: use modern dai_link style

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

>From cf8c3ec87c7259749d079e767b285af5677b411d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:14:32 +0900
Subject: [PATCH] ASoC: fsl: efika-audio-fabric: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/efika-audio-fabric.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
index 667f4215dfc0..8f6396faec9b 100644
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ b/sound/soc/fsl/efika-audio-fabric.c
@@ -29,22 +29,28 @@
 
 #define DRV_NAME "efika-audio-fabric"
 
+SND_SOC_DAILINK_DEFS(analog,
+	DAILINK_COMP_ARRAY(COMP_CPU("mpc5200-psc-ac97.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("stac9766-codec",
+				      "stac9766-hifi-analog")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("mpc5200-pcm-audio")));
+
+SND_SOC_DAILINK_DEFS(iec958,
+	DAILINK_COMP_ARRAY(COMP_CPU("mpc5200-psc-ac97.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("stac9766-codec",
+				      "stac9766-hifi-IEC958")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("mpc5200-pcm-audio")));
+
 static struct snd_soc_dai_link efika_fabric_dai[] = {
 {
 	.name = "AC97",
 	.stream_name = "AC97 Analog",
-	.codec_dai_name = "stac9766-hifi-analog",
-	.cpu_dai_name = "mpc5200-psc-ac97.0",
-	.platform_name = "mpc5200-pcm-audio",
-	.codec_name = "stac9766-codec",
+	SND_SOC_DAILINK_REG(analog),
 },
 {
 	.name = "AC97",
 	.stream_name = "AC97 IEC958",
-	.codec_dai_name = "stac9766-hifi-IEC958",
-	.cpu_dai_name = "mpc5200-psc-ac97.1",
-	.platform_name = "mpc5200-pcm-audio",
-	.codec_name = "stac9766-codec",
+	SND_SOC_DAILINK_REG(iec958),
 },
 };
 
-- 
2.20.1
