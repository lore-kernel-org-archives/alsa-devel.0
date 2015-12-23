From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2518: Use a signed return type for
	ssm2518_lookup_mcs()" to the asoc tree
Date: Wed, 23 Dec 2015 00:08:58 +0000
Message-ID: <E1aBWzC-0007LQ-N3@debutante>
References: <56767788.4020709@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2573D265DCD
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:05 +0100 (CET)
In-Reply-To: <56767788.4020709@users.sourceforge.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Elfring <elfring@users.sourceforge.net>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm2518: Use a signed return type for ssm2518_lookup_mcs()

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

>From bfbcab7c2d8ab4cb52f0785d7381d20f39bb065b Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 20 Dec 2015 10:34:25 +0100
Subject: [PATCH] ASoC: ssm2518: Use a signed return type for
 ssm2518_lookup_mcs()

The return type "unsigned int" was used by the ssm2518_lookup_mcs()
function even though it will eventually return a negative error code.
Improve this implementation detail by deletion of the type modifier then.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm2518.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ssm2518.c b/sound/soc/codecs/ssm2518.c
index 86b81a60ac52..e2e0bfa7ec20 100644
--- a/sound/soc/codecs/ssm2518.c
+++ b/sound/soc/codecs/ssm2518.c
@@ -309,7 +309,7 @@ static const struct snd_pcm_hw_constraint_list ssm2518_constraints_12288000 = {
 	.count = ARRAY_SIZE(ssm2518_rates_12288000),
 };
 
-static unsigned int ssm2518_lookup_mcs(struct ssm2518 *ssm2518,
+static int ssm2518_lookup_mcs(struct ssm2518 *ssm2518,
 	unsigned int rate)
 {
 	const unsigned int *sysclks = NULL;
-- 
2.6.2
