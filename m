From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: define tdm type & default tdm hw
	config" to the asoc tree
Date: Tue, 12 Apr 2016 03:00:59 +0100
Message-ID: <E1apndU-0002K3-00@debutante>
References: <1460021136-27822-4-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49996265347
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 04:01:08 +0200 (CEST)
In-Reply-To: <1460021136-27822-4-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: define tdm type & default tdm hw config

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

>From 9a00a3e9fea1ea5affa7bea971299d3a5832daad Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 7 Apr 2016 11:25:32 +0200
Subject: [PATCH] ASoC: sti: define tdm type & default tdm hw config

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 75116ab3cbc0..750eb5a07e6c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1228,6 +1228,9 @@
 #define UNIPERIF_TYPE_IS_IEC958(p) \
 	(UNIPERIF_TYPE_IS_HDMI(p) || \
 		UNIPERIF_TYPE_IS_SPDIF(p))
+#define UNIPERIF_TYPE_IS_TDM(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_TDM)
+
 /*
  * Uniperipheral IP revisions
  */
@@ -1249,7 +1252,8 @@ enum uniperif_type {
 	SND_ST_UNIPERIF_TYPE_NONE,
 	SND_ST_UNIPERIF_TYPE_HDMI,
 	SND_ST_UNIPERIF_TYPE_PCM,
-	SND_ST_UNIPERIF_TYPE_SPDIF
+	SND_ST_UNIPERIF_TYPE_SPDIF,
+	SND_ST_UNIPERIF_TYPE_TDM
 };
 
 enum uniperif_state {
@@ -1330,6 +1334,28 @@ struct sti_uniperiph_data {
 	struct sti_uniperiph_dai dai_data;
 };
 
+static const struct snd_pcm_hardware uni_tdm_hw = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID,
+
+	.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE,
+
+	.rates = SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min = 8000,
+	.rate_max = 48000,
+
+	.channels_min = 1,
+	.channels_max = 32,
+
+	.periods_min = 2,
+	.periods_max = 10,
+
+	.period_bytes_min = 128,
+	.period_bytes_max = 64 * PAGE_SIZE,
+	.buffer_bytes_max = 256 * PAGE_SIZE
+};
+
 /* uniperiph player*/
 int uni_player_init(struct platform_device *pdev,
 		    struct uniperif *uni_player);
-- 
2.8.0.rc3
