From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4104: Limit the supported sample
	rates" to the asoc tree
Date: Mon, 26 Sep 2016 09:43:54 -0700
Message-ID: <E1boZ0U-0007CB-8T@finisterre>
References: <1474896859-31069-1-git-send-email-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F9A7265598
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:44:43 +0200 (CEST)
In-Reply-To: <1474896859-31069-1-git-send-email-vishalthanki@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vishal Thanki <vishalthanki@gmail.com>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, afd@ti.com, jic23@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4104: Limit the supported sample rates

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

>From c14c59f2e9ca2dc3ddb3af67b71a11feaaacbbce Mon Sep 17 00:00:00 2001
From: Vishal Thanki <vishalthanki@gmail.com>
Date: Mon, 26 Sep 2016 15:34:19 +0200
Subject: [PATCH] ASoC: ak4104: Limit the supported sample rates

Currently the driver exposes range of sample rates between 8KHz to
192KHz as a part of dai_driver. This does not hold true as the limited
number sample rates are allowed in hw_params DAI callback. This patch
limits the sample rates exposed via dai_driver.

Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4104.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index 595d02d7602c..bc5c8705bd8f 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -163,7 +163,10 @@ static struct snd_soc_dai_driver ak4104_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+			 SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			 SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			 SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE  |
 			   SNDRV_PCM_FMTBIT_S24_3LE |
 			   SNDRV_PCM_FMTBIT_S24_LE
-- 
2.9.3
