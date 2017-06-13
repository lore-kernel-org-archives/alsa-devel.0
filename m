From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: Constify hw_constraints" to
	the asoc tree
Date: Tue, 13 Jun 2017 22:08:21 +0100
Message-ID: <E1dKt2z-0000Pl-6F@debutante>
References: <20170608213725.5378-8-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6AAC26701C
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 23:08:32 +0200 (CEST)
In-Reply-To: <20170608213725.5378-8-tiwai@suse.de>
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

   ASoC: samsung: Constify hw_constraints

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

>From 0994c030443b50089b8ac74bc863d71238739f2e Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 8 Jun 2017 23:37:25 +0200
Subject: [PATCH] ASoC: samsung: Constify hw_constraints

snd_pcm_hw_constraint_list(), *_ratnums() and *_ratdens() receive the
const pointers.  Constify the corresponding static objects for better
hardening.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/s3c24xx_uda134x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 81a78940967c..55538e333cc8 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -44,7 +44,7 @@ struct s3c24xx_uda134x {
 
 static unsigned int rates[33 * 2];
 #ifdef ENFORCE_RATES
-static struct snd_pcm_hw_constraint_list hw_constraints_rates = {
+static const struct snd_pcm_hw_constraint_list hw_constraints_rates = {
 	.count	= ARRAY_SIZE(rates),
 	.list	= rates,
 	.mask	= 0,
-- 
2.11.0
