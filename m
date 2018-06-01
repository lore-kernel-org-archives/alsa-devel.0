From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: set cpu dai clk in
	hw_params" to the asoc tree
Date: Fri, 01 Jun 2018 12:05:54 +0100
Message-ID: <E1fOhsY-0000Ti-Un@debutante>
References: <20180530194556.407-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA1D2676E7
 for <alsa-devel@alsa-project.org>; Fri,  1 Jun 2018 13:06:01 +0200 (CEST)
In-Reply-To: <20180530194556.407-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, broonie@kernel.org, robert.jarzmik@free.fr
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: set cpu dai clk in hw_params

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e9be4ffd4f40fcb18209dc5120233f2d11a24b6a Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 30 May 2018 21:45:56 +0200
Subject: [PATCH] ASoC: simple-card: set cpu dai clk in hw_params

The simple-card driver currently accepts a clock node in the cpu dai
sub-node and only uses it as an alternative to the
'system-clock-frequency' property to get the current frequency.

This patch adds another use of the passed clock node. If mclk-fs is
specified, the clocks in cpu and codec dai sub-nodes will be set to
the calculated rate (stream rate * mclk_fs) in hw_params.

This allows platforms to pass tuneable clocks as phandle that will
automatically be set to the right rates.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/simple-card.txt |  5 +++++
 sound/soc/generic/simple-card.c               | 21 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 17c13e74667d..a4c72d09cd45 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -86,6 +86,11 @@ Optional CPU/CODEC subnodes properties:
 					  in dai startup() and disabled with
 					  clk_disable_unprepare() in dai
 					  shutdown().
+					  If a clock is specified and a
+					  multiplication factor is given with
+					  mclk-fs, the clock will be set to the
+					  calculated mclk frequency when the
+					  stream starts.
 - system-clock-direction-out		: specifies clock direction as 'out' on
 					  initialization. It is useful for some aCPUs with
 					  fixed clocks.
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6959a74a6f49..4a516c428b3d 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -135,6 +135,18 @@ static void asoc_simple_card_shutdown(struct snd_pcm_substream *substream)
 	asoc_simple_card_clk_disable(&dai_props->codec_dai);
 }
 
+static int asoc_simple_set_clk_rate(struct asoc_simple_dai *simple_dai,
+				    unsigned long rate)
+{
+	if (!simple_dai->clk)
+		return 0;
+
+	if (clk_get_rate(simple_dai->clk) == rate)
+		return 0;
+
+	return clk_set_rate(simple_dai->clk, rate);
+}
+
 static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 				      struct snd_pcm_hw_params *params)
 {
@@ -154,6 +166,15 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 
 	if (mclk_fs) {
 		mclk = params_rate(params) * mclk_fs;
+
+		ret = asoc_simple_set_clk_rate(&dai_props->codec_dai, mclk);
+		if (ret < 0)
+			return ret;
+
+		ret = asoc_simple_set_clk_rate(&dai_props->cpu_dai, mclk);
+		if (ret < 0)
+			return ret;
+
 		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 					     SND_SOC_CLOCK_IN);
 		if (ret && ret != -ENOTSUPP)
-- 
2.17.0
