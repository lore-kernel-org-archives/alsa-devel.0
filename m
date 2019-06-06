From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: db1200: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:37 +0100 (BST)
Message-ID: <20190606212637.CF68B440046@finisterre.sirena.org.uk>
References: <87k1dzictx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96ECFF897A3
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:38 +0200 (CEST)
In-Reply-To: <87k1dzictx.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: au1x: db1200: use modern dai_link style

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

>From fc4b060a8c6357b2ee22fe21f261f2fb77d41706 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:14:13 +0900
Subject: [PATCH] ASoC: au1x: db1200: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/db1200.c | 50 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 301e1fc9a377..4b012bf54c37 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -46,13 +46,15 @@ static const struct platform_device_id db1200_pids[] = {
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
+SND_SOC_DAILINK_DEFS(db1200_ac97,
+	DAILINK_COMP_ARRAY(COMP_CPU("au1xpsc_ac97.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("ac97-codec.1", "ac97-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("au1xpsc-pcm.1")));
+
 static struct snd_soc_dai_link db1200_ac97_dai = {
 	.name		= "AC97",
 	.stream_name	= "AC97 HiFi",
-	.codec_dai_name	= "ac97-hifi",
-	.cpu_dai_name	= "au1xpsc_ac97.1",
-	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "ac97-codec.1",
+	SND_SOC_DAILINK_REG(db1200_ac97),
 };
 
 static struct snd_soc_card db1200_ac97_machine = {
@@ -62,13 +64,15 @@ static struct snd_soc_card db1200_ac97_machine = {
 	.num_links	= 1,
 };
 
+SND_SOC_DAILINK_DEFS(db1300_ac97,
+	DAILINK_COMP_ARRAY(COMP_CPU("au1xpsc_ac97.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec.1", "wm9712-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("au1xpsc-pcm.1")));
+
 static struct snd_soc_dai_link db1300_ac97_dai = {
 	.name		= "AC97",
 	.stream_name	= "AC97 HiFi",
-	.codec_dai_name	= "wm9712-hifi",
-	.cpu_dai_name	= "au1xpsc_ac97.1",
-	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "wm9712-codec.1",
+	SND_SOC_DAILINK_REG(db1300_ac97),
 };
 
 static struct snd_soc_card db1300_ac97_machine = {
@@ -103,16 +107,18 @@ static const struct snd_soc_ops db1200_i2s_wm8731_ops = {
 	.startup	= db1200_i2s_startup,
 };
 
+SND_SOC_DAILINK_DEFS(db1200_i2s,
+	DAILINK_COMP_ARRAY(COMP_CPU("au1xpsc_i2s.1")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8731.0-001b", "wm8731-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("au1xpsc-pcm.1")));
+
 static struct snd_soc_dai_link db1200_i2s_dai = {
 	.name		= "WM8731",
 	.stream_name	= "WM8731 PCM",
-	.codec_dai_name	= "wm8731-hifi",
-	.cpu_dai_name	= "au1xpsc_i2s.1",
-	.platform_name	= "au1xpsc-pcm.1",
-	.codec_name	= "wm8731.0-001b",
 	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
+	SND_SOC_DAILINK_REG(db1200_i2s),
 };
 
 static struct snd_soc_card db1200_i2s_machine = {
@@ -122,16 +128,18 @@ static struct snd_soc_card db1200_i2s_machine = {
 	.num_links	= 1,
 };
 
+SND_SOC_DAILINK_DEFS(db1300_i2s,
+	DAILINK_COMP_ARRAY(COMP_CPU("au1xpsc_i2s.2")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8731.0-001b", "wm8731-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("au1xpsc-pcm.2")));
+
 static struct snd_soc_dai_link db1300_i2s_dai = {
 	.name		= "WM8731",
 	.stream_name	= "WM8731 PCM",
-	.codec_dai_name	= "wm8731-hifi",
-	.cpu_dai_name	= "au1xpsc_i2s.2",
-	.platform_name	= "au1xpsc-pcm.2",
-	.codec_name	= "wm8731.0-001b",
 	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
+	SND_SOC_DAILINK_REG(db1300_i2s),
 };
 
 static struct snd_soc_card db1300_i2s_machine = {
@@ -141,16 +149,18 @@ static struct snd_soc_card db1300_i2s_machine = {
 	.num_links	= 1,
 };
 
+SND_SOC_DAILINK_DEFS(db1550_i2s,
+	DAILINK_COMP_ARRAY(COMP_CPU("au1xpsc_i2s.3")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8731.0-001b", "wm8731-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("au1xpsc-pcm.3")));
+
 static struct snd_soc_dai_link db1550_i2s_dai = {
 	.name		= "WM8731",
 	.stream_name	= "WM8731 PCM",
-	.codec_dai_name	= "wm8731-hifi",
-	.cpu_dai_name	= "au1xpsc_i2s.3",
-	.platform_name	= "au1xpsc-pcm.3",
-	.codec_name	= "wm8731.0-001b",
 	.dai_fmt	= SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
 			  SND_SOC_DAIFMT_CBM_CFM,
 	.ops		= &db1200_i2s_wm8731_ops,
+	SND_SOC_DAILINK_REG(db1550_i2s),
 };
 
 static struct snd_soc_card db1550_i2s_machine = {
-- 
2.20.1
