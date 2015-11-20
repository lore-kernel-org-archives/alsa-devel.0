From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update the rtd query"
	to the asoc tree
Date: Fri, 20 Nov 2015 18:20:25 +0000
Message-ID: <E1ZzqIM-0003us-06@debutante>
References: <1448039081-772-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4450426669D
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:35 +0100 (CET)
In-Reply-To: <1448039081-772-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Update the rtd query

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

>From dcc2fa34956a1cc2b84415b9ce3bbef4ae1aceb0 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 20 Nov 2015 22:34:41 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update the rtd query

sound card rtd was an array and was updated to a list so update
the driver to use a list

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 3f5a96b585b8..65c65d4c422c 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -35,12 +35,10 @@ static struct snd_soc_card skylake_audio_card;
 
 static inline struct snd_soc_dai *skl_get_codec_dai(struct snd_soc_card *card)
 {
-	int i;
+	struct snd_soc_pcm_runtime *rtd;
 
-	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_pcm_runtime *rtd;
+	list_for_each_entry(rtd, &card->rtd_list, list) {
 
-		rtd = card->rtd + i;
 		if (!strncmp(rtd->codec_dai->name, SKL_NUVOTON_CODEC_DAI,
 			     strlen(SKL_NUVOTON_CODEC_DAI)))
 			return rtd->codec_dai;
-- 
2.6.2
