From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rx1950_uda1380: Constify rate
	constraints" to the asoc tree
Date: Fri, 23 Oct 2015 08:57:04 +0900
Message-ID: <E1ZpPjE-0002nY-5r@finisterre>
References: <1445503403-22934-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0D97266B02
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:57:13 +0200 (CEST)
In-Reply-To: <1445503403-22934-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rx1950_uda1380: Constify rate constraints

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

>From 7a5b8ba412b6217de8badaa52283588e50eeae08 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 22 Oct 2015 10:43:22 +0200
Subject: [PATCH] ASoC: rx1950_uda1380: Constify rate constraints

The rate constraints in this board driver are not modified at runtime, so
make them const.

While we are at it also remove the unnecessary 0 initializer for the mask
field.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/rx1950_uda1380.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/rx1950_uda1380.c b/sound/soc/samsung/rx1950_uda1380.c
index 35e37c4..fa096ab 100644
--- a/sound/soc/samsung/rx1950_uda1380.c
+++ b/sound/soc/samsung/rx1950_uda1380.c
@@ -38,16 +38,15 @@ static int rx1950_hw_params(struct snd_pcm_substream *substream,
 static int rx1950_spk_power(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event);
 
-static unsigned int rates[] = {
+static const unsigned int rates[] = {
 	16000,
 	44100,
 	48000,
 };
 
-static struct snd_pcm_hw_constraint_list hw_rates = {
+static const struct snd_pcm_hw_constraint_list hw_rates = {
 	.count = ARRAY_SIZE(rates),
 	.list = rates,
-	.mask = 0,
 };
 
 static struct snd_soc_jack hp_jack;
-- 
2.6.1
