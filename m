From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: spitz: use modern dai_link style"
	to the asoc tree
Date: Thu,  6 Jun 2019 22:26:51 +0100 (BST)
Message-ID: <20190606212651.39824440046@finisterre.sirena.org.uk>
References: <87imtjjrhd.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEBC2F897CF
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:51 +0200 (CEST)
In-Reply-To: <87imtjjrhd.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pxa: spitz: use modern dai_link style

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

>From 196a521a3c86eb627004cf6b420cd7b2f6c587a0 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:12:25 +0900
Subject: [PATCH] ASoC: pxa: spitz: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/spitz.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 1671da648e95..7973466b0948 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -257,16 +257,18 @@ static const struct snd_kcontrol_new wm8750_spitz_controls[] = {
 };
 
 /* spitz digital audio interface glue - connects codec <--> CPU */
+SND_SOC_DAILINK_DEFS(wm8750,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa2xx-i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8750.0-001b", "wm8750-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
 static struct snd_soc_dai_link spitz_dai = {
 	.name = "wm8750",
 	.stream_name = "WM8750",
-	.cpu_dai_name = "pxa2xx-i2s",
-	.codec_dai_name = "wm8750-hifi",
-	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8750.0-001b",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &spitz_ops,
+	SND_SOC_DAILINK_REG(wm8750),
 };
 
 /* spitz audio machine driver */
-- 
2.20.1
