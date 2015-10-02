From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Allow 4 channel recording on
	AIF1" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:42 +0100
Message-ID: <E1Zi3tu-000807-47@finisterre>
References: <1443472357-12150-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C442A260686
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:51 +0200 (CEST)
In-Reply-To: <1443472357-12150-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Allow 4 channel recording on AIF1

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

>From fbe039bb0815e6113f82021aa8c0e36a1941f511 Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Mon, 28 Sep 2015 13:32:37 -0700
Subject: [PATCH] ASoC: rt5645: Allow 4 channel recording on AIF1

The codec supports 4 channel recording with TDM on AIF1.
This patch modifies the DAI capability to allow it.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 1f7045bc..66b7332e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3113,7 +3113,7 @@ static struct snd_soc_dai_driver rt5645_dai[] = {
 		.capture = {
 			.stream_name = "AIF1 Capture",
 			.channels_min = 1,
-			.channels_max = 2,
+			.channels_max = 4,
 			.rates = RT5645_STEREO_RATES,
 			.formats = RT5645_FORMATS,
 		},
-- 
2.5.0
