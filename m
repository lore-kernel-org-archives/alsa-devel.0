From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: compress: Derive substream from stream based on direction" to the asoc tree
Date: Mon, 19 Jun 2017 17:23:46 +0100
Message-ID: <E1dMzSs-0002Lf-9S@debutante>
References: <1497659620-7197-1-git-send-email-bgoswami@codeaurora.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1497659620-7197-1-git-send-email-bgoswami@codeaurora.org>
Sender: stable-owner@vger.kernel.org
To: Satish Babu Patakokila <sbpata@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, vinod.koul@intel.com, alsa-devel@alsa-project.orgBanajit Goswami <bgoswami@codeaurora.org>, plai@codeaurora.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: compress: Derive substream from stream based on direction

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

>From 01b8cedfd0422326caae308641dcadaa85e0ca72 Mon Sep 17 00:00:00 2001
From: Satish Babu Patakokila <sbpata@codeaurora.org>
Date: Fri, 16 Jun 2017 17:33:40 -0700
Subject: [PATCH] ASoC: compress: Derive substream from stream based on
 direction

Currently compress driver hardcodes direction as playback to get
substream from the stream. This results in getting the incorrect
substream for compressed capture usecase.
To fix this, remove the hardcoding and derive substream based on
the stream direction.

Signed-off-by: Satish Babu Patakokila <sbpata@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-compress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index bfd71b873ca2..206f36bf43e8 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -81,7 +81,8 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
 static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
-	struct snd_pcm_substream *fe_substream = fe->pcm->streams[0].substream;
+	struct snd_pcm_substream *fe_substream =
+		 fe->pcm->streams[cstream->direction].substream;
 	struct snd_soc_platform *platform = fe->platform;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	struct snd_soc_dpcm *dpcm;
@@ -467,7 +468,8 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 					struct snd_compr_params *params)
 {
 	struct snd_soc_pcm_runtime *fe = cstream->private_data;
-	struct snd_pcm_substream *fe_substream = fe->pcm->streams[0].substream;
+	struct snd_pcm_substream *fe_substream =
+		 fe->pcm->streams[cstream->direction].substream;
 	struct snd_soc_platform *platform = fe->platform;
 	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
 	int ret = 0, stream;
-- 
2.11.0
