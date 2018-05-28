From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/3] ASoC: simple-card: set cpu dai clk in
	hw_params
Date: Mon, 28 May 2018 21:35:01 +0200
Message-ID: <20180528193503.18905-2-daniel@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id CBA5E2673F0
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 21:35:11 +0200 (CEST)
In-Reply-To: <20180528193503.18905-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, kuninori.morimoto.gx@renesas.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The simple-card driver currently accepts a clock node in the cpu dai
sub-node and only uses it as an alternative to the
'system-clock-frequency' property to get the current frequency.

This patch adds another use of the passed clock node. If mclk-fs is
specified, the clock will be set to the calculated rate (stream rate *
mclk_fs) in hw_params. This allows platforms to pass a tuneable clock
as phandle that will automatically be set to the right rates.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 5 +++++
 sound/soc/generic/simple-card.c                         | 4 ++++
 2 files changed, 9 insertions(+)

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
index 6959a74a6f49..ca529a6cab06 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -154,6 +154,10 @@ static int asoc_simple_card_hw_params(struct snd_pcm_substream *substream,
 
 	if (mclk_fs) {
 		mclk = params_rate(params) * mclk_fs;
+
+		if (dai_props->cpu_dai.clk)
+			clk_set_rate(dai_props->cpu_dai.clk, mclk);
+
 		ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
 					     SND_SOC_CLOCK_IN);
 		if (ret && ret != -ENOTSUPP)
-- 
2.14.3
