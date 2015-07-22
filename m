From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: kirkwood: prevent double streaming" to
	the asoc tree
Date: Wed, 22 Jul 2015 10:57:34 +0100
Message-ID: <E1ZHqmM-0007AN-KW@debutante>
References: <20150721165717.F04792605AA@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 150382652E6
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 11:57:42 +0200 (CEST)
In-Reply-To: <20150721165717.F04792605AA@alsa0.perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: kirkwood: prevent double streaming

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

>From c4a42915d84ad4b5b5e13aeed5da67f458e22399 Mon Sep 17 00:00:00 2001
From: Jean-Francois Moine <moinejf@free.fr>
Date: Tue, 21 Jul 2015 18:32:58 +0200
Subject: [PATCH] ASoC: kirkwood: prevent double streaming

The kirkwood audio subsystem presents 2 PCM's for one source.
Streaming on a second PCM while the first one is active
cuts this last one.
Then, ending the last stream gives a kernel trap in free_irq().

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/kirkwood/kirkwood-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 4cf2245950d7..dbfdfe99c69d 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -148,10 +148,14 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	dram = mv_mbus_dram_info();
 	addr = substream->dma_buffer.addr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (priv->substream_play)
+			return -EBUSY;
 		priv->substream_play = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_PLAYBACK_WIN, addr, dram);
 	} else {
+		if (priv->substream_rec)
+			return -EBUSY;
 		priv->substream_rec = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_RECORD_WIN, addr, dram);
-- 
2.1.4
