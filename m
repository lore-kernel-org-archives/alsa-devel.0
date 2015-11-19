From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: set player private data" to the
	asoc tree
Date: Thu, 19 Nov 2015 19:56:41 +0000
Message-ID: <E1ZzVJx-0006T4-Rn@debutante>
References: <1447941250-344-4-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 92EFC261534
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 20:56:52 +0100 (CET)
In-Reply-To: <1447941250-344-4-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: set player private data

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 36a65e2072625556191c6c616d65ed4f67f4f0d0 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 19 Nov 2015 14:54:09 +0100
Subject: [PATCH] ASoC: sti: set player private data

Set substream player private data.
substream player private data is used in uni_player_irq_handler to lock,
stop & unlock the stream when interrupt indicates underflow/overflow.
If not set, then segmentation fault occurs.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 1e19a7c6b7e8..5c2bc53f0a9b 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -669,6 +669,7 @@ static int uni_player_startup(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
+	player->substream = substream;
 
 	player->clk_adj = 0;
 
@@ -950,6 +951,8 @@ static void uni_player_shutdown(struct snd_pcm_substream *substream,
 	if (player->state != UNIPERIF_STATE_STOPPED)
 		/* Stop the player */
 		uni_player_stop(player);
+
+	player->substream = NULL;
 }
 
 static int uni_player_parse_dt_clk_glue(struct platform_device *pdev,
-- 
2.6.2
