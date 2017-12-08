From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ssi: fix race condition in
	rsnd_ssi_pointer_update" to the asoc tree
Date: Fri, 08 Dec 2017 18:52:25 +0000
Message-ID: <E1eNNl3-0003pn-VV@debutante>
References: <1512634956-17760-2-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 76D91267255
 for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2017 19:52:38 +0100 (CET)
In-Reply-To: <1512634956-17760-2-git-send-email-jiada_wang@mentor.com>
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

   ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update

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

>From 33f801366bdf3f8b67dfe325b84f4051a090d01e Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Thu, 7 Dec 2017 22:15:38 -0800
Subject: [PATCH] ASoC: rsnd: ssi: fix race condition in
 rsnd_ssi_pointer_update

Currently there is race condition between set of byte_pos and wrap
it around when new buffer starts. If .pointer is called in-between
it will result in inconsistent pointer position be returned
from .pointer callback.

This patch increments buffer pointer atomically to avoid this issue.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reviewed-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ssi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index fece1e5f582f..cbf3bf312d23 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -446,25 +446,29 @@ static bool rsnd_ssi_pointer_update(struct rsnd_mod *mod,
 				    int byte)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	bool ret = false;
+	int byte_pos;
 
-	ssi->byte_pos += byte;
+	byte_pos = ssi->byte_pos + byte;
 
-	if (ssi->byte_pos >= ssi->next_period_byte) {
+	if (byte_pos >= ssi->next_period_byte) {
 		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
 		ssi->period_pos++;
 		ssi->next_period_byte += ssi->byte_per_period;
 
 		if (ssi->period_pos >= runtime->periods) {
-			ssi->byte_pos = 0;
+			byte_pos = 0;
 			ssi->period_pos = 0;
 			ssi->next_period_byte = ssi->byte_per_period;
 		}
 
-		return true;
+		ret = true;
 	}
 
-	return false;
+	WRITE_ONCE(ssi->byte_pos, byte_pos);
+
+	return ret;
 }
 
 /*
@@ -838,7 +842,7 @@ static int rsnd_ssi_pointer(struct rsnd_mod *mod,
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
-	*pointer = bytes_to_frames(runtime, ssi->byte_pos);
+	*pointer = bytes_to_frames(runtime, READ_ONCE(ssi->byte_pos));
 
 	return 0;
 }
-- 
2.15.1
