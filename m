From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add a couple of missing
	consts" to the asoc tree
Date: Mon, 13 Jun 2016 16:47:40 +0100
Message-ID: <E1bCU5U-0002ya-JO@finisterre>
References: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9E992658F5
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 17:47:49 +0200 (CEST)
In-Reply-To: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, ajit.pandey@soctronics.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add a couple of missing consts

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

>From a3178a3ed7986f44be7502d7dc6091ff932d9776 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 13 Jun 2016 13:35:14 +0100
Subject: [PATCH] ASoC: arizona: Add a couple of missing consts

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a6e3881c718e..e678157388bc 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -619,7 +619,7 @@ const struct soc_enum arizona_asrc_rate1 =
 			      arizona_rate_text, arizona_rate_val);
 EXPORT_SYMBOL_GPL(arizona_asrc_rate1);
 
-static const char *arizona_vol_ramp_text[] = {
+static const char * const arizona_vol_ramp_text[] = {
 	"0ms/6dB", "0.5ms/6dB", "1ms/6dB", "2ms/6dB", "4ms/6dB", "8ms/6dB",
 	"15ms/6dB", "30ms/6dB",
 };
@@ -648,7 +648,7 @@ SOC_ENUM_SINGLE_DECL(arizona_out_vi_ramp,
 		     arizona_vol_ramp_text);
 EXPORT_SYMBOL_GPL(arizona_out_vi_ramp);
 
-static const char *arizona_lhpf_mode_text[] = {
+static const char * const arizona_lhpf_mode_text[] = {
 	"Low-pass", "High-pass"
 };
 
@@ -676,7 +676,7 @@ SOC_ENUM_SINGLE_DECL(arizona_lhpf4_mode,
 		     arizona_lhpf_mode_text);
 EXPORT_SYMBOL_GPL(arizona_lhpf4_mode);
 
-static const char *arizona_ng_hold_text[] = {
+static const char * const arizona_ng_hold_text[] = {
 	"30ms", "120ms", "250ms", "500ms",
 };
 
@@ -1753,7 +1753,7 @@ restore_aif:
 	return ret;
 }
 
-static const char *arizona_dai_clk_str(int clk_id)
+static const char * const arizona_dai_clk_str(int clk_id)
 {
 	switch (clk_id) {
 	case ARIZONA_CLK_SYSCLK:
-- 
2.8.1
