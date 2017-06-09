From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: Fix out of bounds array access
	for ak4613_iface" to the asoc tree
Date: Fri, 09 Jun 2017 18:40:09 +0100
Message-ID: <E1dJNtJ-0006yj-KX@debutante>
References: <20170609070121.30359-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02AF7267695
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 19:40:19 +0200 (CEST)
In-Reply-To: <20170609070121.30359-1-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Ryo Kodama <ryo.kodama.vz@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: Fix out of bounds array access for ak4613_iface

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

>From b5f2a487f524e6eeeec38651e7b58760ebfd843e Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 9 Jun 2017 15:01:21 +0800
Subject: [PATCH] ASoC: ak4613: Fix out of bounds array access for ak4613_iface

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index b2dfddead227..987918628d5b 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -345,7 +345,7 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 		if (ak4613_dai_fmt_matching(priv->iface, is_play, fmt, width))
 			iface = priv->iface;
 	} else {
-		for (i = ARRAY_SIZE(ak4613_iface); i >= 0; i--) {
+		for (i = ARRAY_SIZE(ak4613_iface) - 1; i >= 0; i--) {
 			if (!ak4613_dai_fmt_matching(ak4613_iface + i,
 						     is_play,
 						     fmt, width))
-- 
2.11.0
