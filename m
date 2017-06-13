From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: byt: Constify hw_constraints" to
	the asoc tree
Date: Tue, 13 Jun 2017 22:08:36 +0100
Message-ID: <E1dKt3E-0000Vh-9v@debutante>
References: <20170608213725.5378-5-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 601D92670CE
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 23:08:45 +0200 (CEST)
In-Reply-To: <20170608213725.5378-5-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Brian Austin <brian.austin@cirrus.com>, Krzysztof Kozlowski <krzk@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: byt: Constify hw_constraints

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

>From 1ebb4d9dbf8f7a429abff359fa1d779b639da76f Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 8 Jun 2017 23:37:22 +0200
Subject: [PATCH] ASoC: intel: byt: Constify hw_constraints

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_nocodec.c | 4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_nocodec.c b/sound/soc/intel/boards/bytcht_nocodec.c
index 89853eeaaf9d..1dd9441806fa 100644
--- a/sound/soc/intel/boards/bytcht_nocodec.c
+++ b/sound/soc/intel/boards/bytcht_nocodec.c
@@ -85,11 +85,11 @@ static int codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int rates_48000[] = {
+static const unsigned int rates_48000[] = {
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_48000 = {
+static const struct snd_pcm_hw_constraint_list constraints_48000 = {
 	.count = ARRAY_SIZE(rates_48000),
 	.list  = rates_48000,
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8164bec63bf1..4a3516b38c2c 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -203,11 +203,11 @@ static int byt_rt5651_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int rates_48000[] = {
+static const unsigned int rates_48000[] = {
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list constraints_48000 = {
+static const struct snd_pcm_hw_constraint_list constraints_48000 = {
 	.count = ARRAY_SIZE(rates_48000),
 	.list  = rates_48000,
 };
-- 
2.11.0
