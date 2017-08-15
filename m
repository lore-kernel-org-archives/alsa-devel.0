From: Mark Brown <broonie@kernel.org>
Subject: Applied "arizona: anc: Correct setting of
	FCx_MIC_MODE_SEL" to the asoc tree
Date: Tue, 15 Aug 2017 16:10:47 +0100
Message-ID: <E1dhdUV-0007Xn-Vf@debutante>
References: <20170814144557.6875-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5626C266C99
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 17:10:53 +0200 (CEST)
In-Reply-To: <20170814144557.6875-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, sapthagiri.baratam@incubesol.com
List-Id: alsa-devel@alsa-project.org

The patch

   arizona: anc: Correct setting of FCx_MIC_MODE_SEL

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

>From 4428ffa1fe66a9e3cf68bba3ad135f17be4ed674 Mon Sep 17 00:00:00 2001
From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Date: Mon, 14 Aug 2017 15:46:24 +0100
Subject: [PATCH] arizona: anc: Correct setting of FCx_MIC_MODE_SEL

The mask rather than the shift is accidentally passed to the
SOC_ENUM_SINGLE macro which results in the wrong bits being set for this
control, change to using the shift to correct this.

Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 0a734d910850..a1149f6a8450 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -710,7 +710,7 @@ const struct soc_enum arizona_anc_input_src[] = {
 			ARRAY_SIZE(arizona_anc_input_src_text),
 			arizona_anc_input_src_text),
 	SOC_ENUM_SINGLE(ARIZONA_FCL_ADC_REFORMATTER_CONTROL,
-			ARIZONA_FCL_MIC_MODE_SEL,
+			ARIZONA_FCL_MIC_MODE_SEL_SHIFT,
 			ARRAY_SIZE(arizona_anc_channel_src_text),
 			arizona_anc_channel_src_text),
 	SOC_ENUM_SINGLE(ARIZONA_ANC_SRC,
@@ -718,7 +718,7 @@ const struct soc_enum arizona_anc_input_src[] = {
 			ARRAY_SIZE(arizona_anc_input_src_text),
 			arizona_anc_input_src_text),
 	SOC_ENUM_SINGLE(ARIZONA_FCR_ADC_REFORMATTER_CONTROL,
-			ARIZONA_FCR_MIC_MODE_SEL,
+			ARIZONA_FCR_MIC_MODE_SEL_SHIFT,
 			ARRAY_SIZE(arizona_anc_channel_src_text),
 			arizona_anc_channel_src_text),
 };
-- 
2.13.3
