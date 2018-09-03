From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: add support for the DSP_A/DSP_B
	formats" to the asoc tree
Date: Mon,  3 Sep 2018 14:46:23 +0100 (BST)
Message-ID: <20180903134623.4989411227AE@debutante.sirena.org.uk>
References: <878t4jf4n6.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D3F9D2678D3
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:46:23 +0200 (CEST)
In-Reply-To: <878t4jf4n6.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jiada Wang <jiada_wang@mentor.com>, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: add support for the DSP_A/DSP_B formats

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

>From 3791b3ee4bb13c381868da89e9e6deb11de660ad Mon Sep 17 00:00:00 2001
From: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Date: Mon, 3 Sep 2018 07:06:01 +0000
Subject: [PATCH] ASoC: rsnd: add support for the DSP_A/DSP_B formats

Signed-off-by: Dragos Tarcatu <dragos_tarcatu@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index ce0a3a61c441..8a417768b7ef 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -689,6 +689,7 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		rdai->frm_clk_inv = 0;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_DSP_B:
 		rdai->sys_delay = 1;
 		rdai->data_alignment = 0;
 		rdai->frm_clk_inv = 1;
@@ -698,6 +699,11 @@ static int rsnd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		rdai->data_alignment = 1;
 		rdai->frm_clk_inv = 1;
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		rdai->sys_delay = 0;
+		rdai->data_alignment = 0;
+		rdai->frm_clk_inv = 1;
+		break;
 	}
 
 	/* set clock inversion */
-- 
2.19.0.rc1
