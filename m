From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: magician: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:55 +0100 (BST)
Message-ID: <20190606212655.29107440046@finisterre.sirena.org.uk>
References: <87sgsnjrib.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DAE4DF8975A
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:55 +0200 (CEST)
In-Reply-To: <87sgsnjrib.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pxa: magician: use modern dai_link style

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

>From 018252749ce4cf683ad5164fe47ca00d5c567234 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:11:51 +0900
Subject: [PATCH] ASoC: pxa: magician: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/magician.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index 935a248e5bf6..bf8084f2e625 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -290,24 +290,30 @@ static const struct snd_kcontrol_new uda1380_magician_controls[] = {
 };
 
 /* magician digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(playback,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa-ssp-dai.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("uda1380-codec.0-0018",
+				      "uda1380-hifi-playback")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
+SND_SOC_DAILINK_DEFS(capture,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa2xx-i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("uda1380-codec.0-0018",
+				      "uda1380-hifi-capture")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
 static struct snd_soc_dai_link magician_dai[] = {
 {
 	.name = "uda1380",
 	.stream_name = "UDA1380 Playback",
-	.cpu_dai_name = "pxa-ssp-dai.0",
-	.codec_dai_name = "uda1380-hifi-playback",
-	.platform_name = "pxa-pcm-audio",
-	.codec_name = "uda1380-codec.0-0018",
 	.ops = &magician_playback_ops,
+	SND_SOC_DAILINK_REG(playback),
 },
 {
 	.name = "uda1380",
 	.stream_name = "UDA1380 Capture",
-	.cpu_dai_name = "pxa2xx-i2s",
-	.codec_dai_name = "uda1380-hifi-capture",
-	.platform_name = "pxa-pcm-audio",
-	.codec_name = "uda1380-codec.0-0018",
 	.ops = &magician_capture_ops,
+	SND_SOC_DAILINK_REG(capture),
 }
 };
 
-- 
2.20.1
