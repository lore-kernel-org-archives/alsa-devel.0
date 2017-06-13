From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Constify hw_constraints" to
	the asoc tree
Date: Tue, 13 Jun 2017 22:08:24 +0100
Message-ID: <E1dKt32-0000Qn-7m@debutante>
References: <20170608213725.5378-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6094266FFD
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 23:08:32 +0200 (CEST)
In-Reply-To: <20170608213725.5378-7-tiwai@suse.de>
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

   ASoC: mediatek: Constify hw_constraints

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

>From b02ee56087adae4819ce4d91c08d57403f71fd34 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 8 Jun 2017 23:37:24 +0200
Subject: [PATCH] ASoC: mediatek: Constify hw_constraints

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-By: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index aa5b31b121e3..70f61d53fe05 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -107,7 +107,7 @@ static const struct snd_kcontrol_new mt2701_cs42448_controls[] = {
 
 static const unsigned int mt2701_cs42448_sampling_rates[] = {48000};
 
-static struct snd_pcm_hw_constraint_list mt2701_cs42448_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list mt2701_cs42448_constraints_rates = {
 		.count = ARRAY_SIZE(mt2701_cs42448_sampling_rates),
 		.list = mt2701_cs42448_sampling_rates,
 		.mask = 0,
-- 
2.11.0
