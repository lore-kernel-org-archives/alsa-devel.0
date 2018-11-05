From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: remove unnecessary unlikely()"
	to the asoc tree
Date: Mon,  5 Nov 2018 11:58:53 +0000 (GMT)
Message-ID: <20181105115853.81FF41124D98@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E84752678DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 12:58:53 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: remove unnecessary unlikely()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0b6277e6343e192aaa7d452ab933281eb0d420dc Mon Sep 17 00:00:00 2001
From: Yangtao Li <tiny.windzz@gmail.com>
Date: Sun, 4 Nov 2018 07:55:29 -0500
Subject: [PATCH] ASoC: nau8825: remove unnecessary unlikely()

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index b9fed99d8b5e..7bbcbf5f05c8 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -424,10 +424,8 @@ static u32 nau8825_xtalk_sidetone(u32 sig_org, u32 sig_cros)
 {
 	u32 gain, sidetone;
 
-	if (unlikely(sig_org == 0) || unlikely(sig_cros == 0)) {
-		WARN_ON(1);
+	if (WARN_ON(sig_org == 0 || sig_cros == 0))
 		return 0;
-	}
 
 	sig_org = nau8825_intlog10_dec3(sig_org);
 	sig_cros = nau8825_intlog10_dec3(sig_cros);
-- 
2.19.0.rc2
