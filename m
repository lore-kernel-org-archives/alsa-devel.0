From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: smartq_wm8987: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:05 +0100 (BST)
Message-ID: <20190606212705.325DF440046@finisterre.sirena.org.uk>
References: <87imtjl65t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7C71F897EC
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:05 +0200 (CEST)
In-Reply-To: <87imtjl65t.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: smartq_wm8987: use modern dai_link style

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

>From a259926056dde250bcb34f015dd9eb72d4709b69 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:10:01 +0900
Subject: [PATCH] ASoC: samsung: smartq_wm8987: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/smartq_wm8987.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
index b9e887ea60b2..fab3db9fdb98 100644
--- a/sound/soc/samsung/smartq_wm8987.c
+++ b/sound/soc/samsung/smartq_wm8987.c
@@ -153,18 +153,20 @@ static int smartq_wm8987_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
+SND_SOC_DAILINK_DEFS(wm8987,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-i2s.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8750.0-0x1a", "wm8750-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-i2s.0")));
+
 static struct snd_soc_dai_link smartq_dai[] = {
 	{
 		.name		= "wm8987",
 		.stream_name	= "SmartQ Hi-Fi",
-		.cpu_dai_name	= "samsung-i2s.0",
-		.codec_dai_name	= "wm8750-hifi",
-		.platform_name	= "samsung-i2s.0",
-		.codec_name	= "wm8750.0-0x1a",
 		.init		= smartq_wm8987_init,
 		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBS_CFS,
 		.ops		= &smartq_hifi_ops,
+		SND_SOC_DAILINK_REG(wm8987),
 	},
 };
 
-- 
2.20.1
