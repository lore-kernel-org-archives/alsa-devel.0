From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3168a: cleanup hw_constraint for
	LEFT_J/I2S" to the asoc tree
Date: Mon,  5 Nov 2018 11:58:01 +0000 (GMT)
Message-ID: <20181105115801.9BACE1124D98@debutante.sirena.org.uk>
References: <87h8h3sxt4.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BA7F2678DD
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:58:02 +0100 (CET)
In-Reply-To: <87h8h3sxt4.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3168a: cleanup hw_constraint for LEFT_J/I2S

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

>From 0900d1e64815b3b8d4d04197aa135e77317176e1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Oct 2018 07:31:40 +0000
Subject: [PATCH] ASoC: pcm3168a: cleanup hw_constraint for LEFT_J/I2S

hw constraint for LEFT_J/I2S are same, but had duplicated code.
This code cleanup these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3168a.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 52cc950c9fd1..5f4327f5b725 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -504,6 +504,10 @@ static int pcm3168a_startup(struct snd_pcm_substream *substream,
 	unsigned int fmt;
 	unsigned int sample_min;
 	unsigned int channel_max;
+	unsigned int channel_maxs[] = {
+		6, /* rx */
+		8  /* tx */
+	};
 
 	if (tx)
 		fmt = pcm3168a->dac_fmt;
@@ -528,18 +532,9 @@ static int pcm3168a_startup(struct snd_pcm_substream *substream,
 		channel_max =  2;
 		break;
 	case PCM3168A_FMT_LEFT_J:
-		sample_min  = 24;
-		if (tx)
-			channel_max = 8;
-		else
-			channel_max = 6;
-		break;
 	case PCM3168A_FMT_I2S:
 		sample_min  = 24;
-		if (tx)
-			channel_max = 8;
-		else
-			channel_max = 6;
+		channel_max = channel_maxs[tx];
 		break;
 	default:
 		sample_min  = 24;
-- 
2.19.0.rc2
