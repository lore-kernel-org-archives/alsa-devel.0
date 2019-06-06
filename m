From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: osk5912: use modern dai_link style"
	to the asoc tree
Date: Thu,  6 Jun 2019 22:26:48 +0100 (BST)
Message-ID: <20190606212649.04CEB440049@finisterre.sirena.org.uk>
References: <87d0jrjrgv.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B23DEF897C1
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:49 +0200 (CEST)
In-Reply-To: <87d0jrjrgv.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: ti: osk5912: use modern dai_link style

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

>From 5cffc237432d47084add97e42f13dbd055c107a8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:12:43 +0900
Subject: [PATCH] ASoC: ti: osk5912: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/osk5912.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/osk5912.c b/sound/soc/ti/osk5912.c
index e4096779ca05..0144f91f4778 100644
--- a/sound/soc/ti/osk5912.c
+++ b/sound/soc/ti/osk5912.c
@@ -91,16 +91,19 @@ static const struct snd_soc_dapm_route audio_map[] = {
 };
 
 /* Digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(aic23,
+	DAILINK_COMP_ARRAY(COMP_CPU("omap-mcbsp.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic23-codec",
+				      "tlv320aic23-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("omap-mcbsp.1")));
+
 static struct snd_soc_dai_link osk_dai = {
 	.name = "TLV320AIC23",
 	.stream_name = "AIC23",
-	.cpu_dai_name = "omap-mcbsp.1",
-	.codec_dai_name = "tlv320aic23-hifi",
-	.platform_name = "omap-mcbsp.1",
-	.codec_name = "tlv320aic23-codec",
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
 	.ops = &osk_ops,
+	SND_SOC_DAILINK_REG(aic23),
 };
 
 /* Audio machine driver */
-- 
2.20.1
