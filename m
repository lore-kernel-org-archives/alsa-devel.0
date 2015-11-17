From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: don't overwrite CTRL2 register"
	to the asoc tree
Date: Tue, 17 Nov 2015 18:54:47 +0000
Message-ID: <E1ZylOx-00041F-LL@debutante>
References: <87h9klhw5e.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEDA02652C5
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 19:54:52 +0100 (CET)
In-Reply-To: <87h9klhw5e.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: don't overwrite CTRL2 register

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

>From b323dd30718e2055adb5534e52f685a57c119c18 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Nov 2015 08:28:56 +0000
Subject: [PATCH] ASoC: ak4613: don't overwrite CTRL2 register

Current code set DFS settings on CTRL2 register, but it overwrite
default settings. This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index dab127603ff6..62c08a6395af 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -70,6 +70,7 @@
 #define FMT_MASK	(0xf8)
 
 /* CTRL2 */
+#define DFS_MASK		(3 << 2)
 #define DFS_NORMAL_SPEED	(0 << 2)
 #define DFS_DOUBLE_SPEED	(1 << 2)
 #define DFS_QUAD_SPEED		(2 << 2)
@@ -361,7 +362,7 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	fmt_ctrl = AUDIO_IFACE_TO_VAL(iface);
 
 	snd_soc_update_bits(codec, CTRL1, FMT_MASK, fmt_ctrl);
-	snd_soc_write(codec, CTRL2, ctrl2);
+	snd_soc_update_bits(codec, CTRL2, DFS_MASK, ctrl2);
 
 	snd_soc_write(codec, ICTRL, priv->ic);
 	snd_soc_write(codec, OCTRL, priv->oc);
-- 
2.6.2
