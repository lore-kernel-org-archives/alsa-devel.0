From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-ssi: Fix bitclock calculation for
	master mode" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:42 +0100
Message-ID: <E1ZCTNW-0005UH-44@finisterre>
References: <1435919976-1667-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DCB5A26568F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:00 +0200 (CEST)
In-Reply-To: <1435919976-1667-1-git-send-email-jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Juergen Borleis <jbe@pengutronix.de>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-ssi: Fix bitclock calculation for master mode

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

>From ebac95a9208e6b5f134df8518df1bfd1b3fee354 Mon Sep 17 00:00:00 2001
From: Juergen Borleis <jbe@pengutronix.de>
Date: Fri, 3 Jul 2015 12:39:36 +0200
Subject: [PATCH] ASoC: fsl-ssi: Fix bitclock calculation for master mode

According to the datasheet 'pm', 'psr' and 'div2' should never be all 0.
Since commit 541b03ad6cfe ("ASoC: fsl_ssi: Fix the incorrect limitation of
the bit clock rate") this can happen, because for some bitclock rates
'pm' = 0 seems to be a valid choice but does not work due to hardware
restrictions. This results into a bad hardware behaviour (slow audio for
example). Feature tested on a i.MX25.

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c7647e0..c0b940e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -633,7 +633,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		sub *= 100000;
 		do_div(sub, freq);
 
-		if (sub < savesub) {
+		if (sub < savesub && !(i == 0 && psr == 0 && div2 == 0)) {
 			baudrate = tmprate;
 			savesub = sub;
 			pm = i;
-- 
2.1.4
