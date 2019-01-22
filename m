From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Correct the setting while
	select ASRC clk for AD/DA filter" to the asoc tree
Date: Tue, 22 Jan 2019 20:26:44 +0000 (GMT)
Message-ID: <20190122202644.34EC71127955@debutante.sirena.org.uk>
References: <1548143409-15395-1-git-send-email-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E133C267557
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 21:26:49 +0100 (CET)
In-Reply-To: <1548143409-15395-1-git-send-email-shumingf@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, albertchen@realtek.com, broonie@kernel.org, flove@realtek.com, bard.liao@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA filter

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

>From 8077ec011b1ea26abb7ca786f28ecccfb352717f Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 22 Jan 2019 15:50:09 +0800
Subject: [PATCH] ASoC: rt5682: Correct the setting while select ASRC clk for
 AD/DA filter

AD/DA ASRC function control two ASRC clock sources separately.
Whether AD/DA filter select which clock source, we enable AD/DA ASRC
function for all cases.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 89c43b26c379..a9b91bcfcc09 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1778,7 +1778,9 @@ static const struct snd_soc_dapm_route rt5682_dapm_routes[] = {
 	{"ADC Stereo1 Filter", NULL, "ADC STO1 ASRC", is_using_asrc},
 	{"DAC Stereo1 Filter", NULL, "DAC STO1 ASRC", is_using_asrc},
 	{"ADC STO1 ASRC", NULL, "AD ASRC"},
+	{"ADC STO1 ASRC", NULL, "DA ASRC"},
 	{"ADC STO1 ASRC", NULL, "CLKDET"},
+	{"DAC STO1 ASRC", NULL, "AD ASRC"},
 	{"DAC STO1 ASRC", NULL, "DA ASRC"},
 	{"DAC STO1 ASRC", NULL, "CLKDET"},
 
-- 
2.20.1
