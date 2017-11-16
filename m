From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: change FVCO maximum threshold"
	to the asoc tree
Date: Thu, 16 Nov 2017 19:28:22 +0000 (GMT)
Message-ID: <20171116192822.B413544005B@finisterre.ee.mobilebroadband>
References: <1510540588-2463-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C415826777A
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:28:25 +0100 (CET)
In-Reply-To: <1510540588-2463-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: change FVCO maximum threshold

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

>From 080f773d226a9c2b0fa0d8f02107518c560f8b77 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Mon, 13 Nov 2017 10:36:28 +0800
Subject: [PATCH] ASoC: nau8824: change FVCO maximum threshold

Change the maximum of FDCO which remains between 90MHz-100MHz.
FDCO must be within the 90MHz-100MHz or the FFL cannot be
guaranteed across the full range of operation.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 8a9a9939827e..088e0cef4cb8 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -43,7 +43,7 @@ static bool nau8824_is_jack_inserted(struct nau8824 *nau8824);
 
 /* the parameter threshold of FLL */
 #define NAU_FREF_MAX 13500000
-#define NAU_FVCO_MAX 124000000
+#define NAU_FVCO_MAX 100000000
 #define NAU_FVCO_MIN 90000000
 
 /* scaling for mclk from sysclk_src output */
-- 
2.14.1
