From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mxs-saif: fix setting master base rate"
	to the asoc tree
Date: Tue, 17 Jan 2017 18:44:57 +0000
Message-ID: <E1cTYkb-0008MS-MY@debutante>
References: <20170113204428.16703-1-joerg.krause@embedded.rocks>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8103113795126066690=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B59F42665B0
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 19:45:24 +0100 (CET)
In-Reply-To: <20170113204428.16703-1-joerg.krause@embedded.rocks>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Mans Rullgard <mans@mansr.com>, Victorien Vedrine <victorien.vedrine@ophrys.net>, =?UTF-8?q?J=C3=B6rg=20Krause?= <joerg.krause@embedded.rocks>, Takashi Iwai <tiwai@suse.com>, =?UTF-8?q?J=C3=B6rg=20Krause?= <jk@lintech.de>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

--===============8103113795126066690==
Content-Type: text/plain

The patch

   ASoC: mxs-saif: fix setting master base rate

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

>From bcb8c270829a639b8b838809d7c2b540e65f4e01 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?J=C3=B6rg=20Krause?= <jk@lintech.de>
Date: Fri, 13 Jan 2017 21:44:27 +0100
Subject: [PATCH] ASoC: mxs-saif: fix setting master base rate
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The SAIF base oversample rates are either 512*fs or 384*fs. An additional
divider exists within the SAIF to generate sub-multiples of these two base
rates if MCLK is required by the codec.

 * The sub-rates for the 512x base rate are: 256x, 128x, 64x, and 32x.
 * The sub-rates for the 384x base rate are: 192x, 96x, and 48x.

Setting the base rate depending on the modulo operation with 32 and 48
give wrong results for some mclk.

If mclk=18.432MHz both modulo operations results in 0. As testing the
result with 32 is done first, a wrong base rate of 512*fs is set instead
of the correct 384*fs.

Fix this by setting the base rate depending on the calculated sub-rate.

Signed-off-by: Jörg Krause <joerg.krause@embedded.rocks>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mxs/mxs-saif.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 9012a2036131..b42f301c6b96 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -119,23 +119,33 @@ static int mxs_saif_set_clk(struct mxs_saif *saif,
 	 * Set SAIF clock
 	 *
 	 * The SAIF clock should be either 384*fs or 512*fs.
-	 * If MCLK is used, the SAIF clk ratio need to match mclk ratio.
-	 *  For 32x mclk, set saif clk as 512*fs.
-	 *  For 48x mclk, set saif clk as 384*fs.
+	 * If MCLK is used, the SAIF clk ratio needs to match mclk ratio.
+	 *  For 256x, 128x, 64x, and 32x sub-rates, set saif clk as 512*fs.
+	 *  For 192x, 96x, and 48x sub-rates, set saif clk as 384*fs.
 	 *
 	 * If MCLK is not used, we just set saif clk to 512*fs.
 	 */
 	clk_prepare_enable(master_saif->clk);
 
 	if (master_saif->mclk_in_use) {
-		if (mclk % 32 == 0) {
+		switch (mclk / rate) {
+		case 32:
+		case 64:
+		case 128:
+		case 256:
+		case 512:
 			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
 			ret = clk_set_rate(master_saif->clk, 512 * rate);
-		} else if (mclk % 48 == 0) {
+			break;
+		case 48:
+		case 96:
+		case 192:
+		case 384:
 			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
 			ret = clk_set_rate(master_saif->clk, 384 * rate);
-		} else {
-			/* SAIF MCLK should be either 32x or 48x */
+			break;
+		default:
+			/* SAIF MCLK should be a sub-rate of 512x or 384x */
 			clk_disable_unprepare(master_saif->clk);
 			return -EINVAL;
 		}
-- 
2.11.0


--===============8103113795126066690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8103113795126066690==--
