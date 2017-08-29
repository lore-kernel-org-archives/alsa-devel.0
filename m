From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: Fix fraction overflow in PLL
	calculation" to the asoc tree
Date: Tue, 29 Aug 2017 20:51:35 +0100 (BST)
Message-ID: <20170829195135.EFFAB4400FC@finisterre.ee.mobilebroadband>
References: <1503697016-21422-1-git-send-email-oskar@scara.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AD59266E37
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:51:41 +0200 (CEST)
In-Reply-To: <1503697016-21422-1-git-send-email-oskar@scara.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oskar Schirmer <oskar@scara.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Dan Murphy <dmurphy@ti.com>, Fabio Estevam <fabio.estevam@nxp.com>, Andrew Morton <akpm@linux-foundation.org>, Andreas Dannenberg <dannenberg@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas2552: Fix fraction overflow in PLL calculation

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

>From 1bb7cb68feb73a8106546cbd3379590297b0a950 Mon Sep 17 00:00:00 2001
From: Oskar Schirmer <oskar@scara.com>
Date: Fri, 25 Aug 2017 21:36:56 +0000
Subject: [PATCH] ASoC: tas2552: Fix fraction overflow in PLL calculation

Setting the PLL involves the calculation of a fixed point ratio
with 4 decimal digits fraction, referred to as "J.D". The
fraction "D" is stored separately from the integer part "J"
and is limited to 0..9999.

The current algorithm uses integer registers to calculate the
fraction part, but failed to compensate for rounding errors,
resulting in values larger than 9999 for the fraction part
occasionally, e.g. for 44.1kHz audio rate and pll_clkin =
3763400 it would set J to 11 and D to 10002, which will at
best result in wrong pitch.

The critical part is the "pll_clkin / 10000", which would be
ok with real numbers, but using integer arithmetic the rounding
decreases the divisor, thus increasing the final quotient.

The issue is solved by linear interpolation over the reciprocal
function between the two adjacent points with integer divisor,
i.e. pll_clkin / 10000 and pll_clkin / 10000 + 1, and doing
all rounding to the lower result.

As a side effect to the bug fix, the approximation to the
desired frequency is much better, for the above mentioned
example we get 11.9993, while the true ratio is 11.9993623.

Signed-off-by: Oskar Schirmer <oskar@scara.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2552.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 8840f72f3c4a..10116169a239 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -192,7 +192,7 @@ static int tas2552_setup_pll(struct snd_soc_codec *codec,
 		 * pll_clk = (.5 * pll_clkin * J.D) / 2^p
 		 * Need to fill in J and D here based on incoming freq
 		 */
-		unsigned int d;
+		unsigned int d, q, t;
 		u8 j;
 		u8 pll_sel = (tas2552->pll_clk_id << 3) & TAS2552_PLL_SRC_MASK;
 		u8 p = snd_soc_read(codec, TAS2552_PLL_CTRL_1);
@@ -200,9 +200,12 @@ static int tas2552_setup_pll(struct snd_soc_codec *codec,
 		p = (p >> 7);
 
 recalc:
-		j = (pll_clk * 2 * (1 << p)) / pll_clkin;
-		d = (pll_clk * 2 * (1 << p)) % pll_clkin;
-		d /= (pll_clkin / 10000);
+		t = (pll_clk * 2) << p;
+		j = t / pll_clkin;
+		d = t % pll_clkin;
+		t = pll_clkin / 10000;
+		q = d / (t + 1);
+		d = q + ((9999 - pll_clkin % 10000) * (d / t - q)) / 10000;
 
 		if (d && (pll_clkin < 512000 || pll_clkin > 9200000)) {
 			if (tas2552->pll_clk_id == TAS2552_PLL_CLKIN_BCLK) {
-- 
2.13.2
