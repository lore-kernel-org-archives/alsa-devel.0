From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssi: remove unnesessary
	period_pos" to the asoc tree
Date: Fri, 08 Dec 2017 18:55:01 +0000
Message-ID: <E1eNNnZ-0004Al-0a@debutante>
References: <1512634956-17760-3-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B791C267255
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 19:55:39 +0100 (CET)
In-Reply-To: <1512634956-17760-3-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: ssi: remove unnesessary period_pos

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

>From 2e2d53da81af6b2222c6b4e025a5d01b37b4449b Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Thu, 7 Dec 2017 22:15:39 -0800
Subject: [PATCH] ASoC: rsnd: ssi: remove unnesessary period_pos

period_pos can always be calculated by byte_pos and
byte_per_period, there is no reason to maintain this
variable in rsnd_dai_stream.

This patch removes period_pos from rsnd_ssi and calculates
next_period_byte with consideration of actual byte_pos value.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index cbf3bf312d23..f21202429000 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -80,7 +80,6 @@ struct rsnd_ssi {
 	unsigned int usrcnt;
 
 	int byte_pos;
-	int period_pos;
 	int byte_per_period;
 	int next_period_byte;
 };
@@ -421,7 +420,6 @@ static void rsnd_ssi_pointer_init(struct rsnd_mod *mod,
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
 	ssi->byte_pos		= 0;
-	ssi->period_pos		= 0;
 	ssi->byte_per_period	= runtime->period_size *
 				  runtime->channels *
 				  samples_to_bytes(runtime, 1);
@@ -453,13 +451,12 @@ static bool rsnd_ssi_pointer_update(struct rsnd_mod *mod,
 
 	if (byte_pos >= ssi->next_period_byte) {
 		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
+		int period_pos = byte_pos / ssi->byte_per_period;
 
-		ssi->period_pos++;
-		ssi->next_period_byte += ssi->byte_per_period;
+		ssi->next_period_byte = (period_pos + 1) * ssi->byte_per_period;
 
-		if (ssi->period_pos >= runtime->periods) {
+		if (period_pos >= runtime->periods) {
 			byte_pos = 0;
-			ssi->period_pos = 0;
 			ssi->next_period_byte = ssi->byte_per_period;
 		}
 
-- 
2.15.1
