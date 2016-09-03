From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Correct handling of FLL theta
	in synchroniser mode" to the asoc tree
Date: Sat, 03 Sep 2016 12:08:36 +0100
Message-ID: <E1bg8oP-0003dE-01@finisterre>
References: <1472831568-466-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA6B2266FBD
 for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2016 13:08:55 +0200 (CEST)
In-Reply-To: <1472831568-466-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, s.nawrocki@samsung.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Correct handling of FLL theta in synchroniser mode

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

>From e87d9ae8886783f3a5a8dd6863e8261783214e3b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 2 Sep 2016 16:52:43 +0100
Subject: [PATCH] ASoC: arizona: Correct handling of FLL theta in synchroniser
 mode

Theta/lambda is used to give the fractional portion of the FLL
frequency multiplication. When the synchroniser is active the
reference path lambda value is hard coded in the hardware to
65536. This patch corrects the handling of theta such that it
is scaled to match this denominator, when the synchroniser is
active.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ccb3ca2f77a4..ded235f3090f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1920,8 +1920,8 @@ static struct {
 
 struct arizona_fll_cfg {
 	int n;
-	int theta;
-	int lambda;
+	unsigned int theta;
+	unsigned int lambda;
 	int refdiv;
 	int outdiv;
 	int fratio;
@@ -2233,6 +2233,10 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 	    fll->ref_src != fll->sync_src) {
 		arizona_calc_fll(fll, &cfg, fll->ref_freq, false);
 
+		/* Ref path hardcodes lambda to 65536 when sync is on */
+		if (fll->sync_src >= 0 && cfg.lambda)
+			cfg.theta = (cfg.theta * (1 << 16)) / cfg.lambda;
+
 		arizona_apply_fll(arizona, fll->base, &cfg, fll->ref_src,
 				  false);
 		if (fll->sync_src >= 0) {
-- 
2.9.3
