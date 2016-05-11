From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98371 Remove duplicate entry in
	max98371_reg" to the asoc tree
Date: Wed, 11 May 2016 17:13:50 +0100
Message-ID: <E1b0Wli-0006QE-RK@debutante>
References: <1462938491.444.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57DCC2667E7
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 18:16:08 +0200 (CEST)
In-Reply-To: <1462938491.444.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98371 Remove duplicate entry in max98371_reg

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

>From af37d21a3245c4a54d608c1d85588203ebfe1ef9 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 11 May 2016 11:48:11 +0800
Subject: [PATCH] ASoC: max98371 Remove duplicate entry in max98371_reg

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98371.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 21fae0932137..cf0a39bb631a 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -107,7 +107,6 @@ static const struct reg_default max98371_reg[] = {
 	{ 0x39, 0x00 },
 	{ 0x3A, 0x00 },
 	{ 0x3B, 0x00 },
-	{ 0x3B, 0x00 },
 	{ 0x3C, 0x00 },
 	{ 0x3D, 0x00 },
 	{ 0x3E, 0x00 },
-- 
2.8.1
