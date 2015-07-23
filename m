From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l73: Fix mask for setting
	CS42L73_SP_3ST bit" to the asoc tree
Date: Thu, 23 Jul 2015 16:04:28 +0100
Message-ID: <E1ZII2u-0006j8-2y@debutante>
References: <1437611217.6620.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DF75E260711
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:04:38 +0200 (CEST)
In-Reply-To: <1437611217.6620.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l73: Fix mask for setting CS42L73_SP_3ST bit

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

>From 8626e5eb6c33b78ba7a5eb7cfbc5109896f443ef Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 23 Jul 2015 08:26:57 +0800
Subject: [PATCH] ASoC: cs42l73: Fix mask for setting CS42L73_SP_3ST bit

CS42L73_SP_3ST is BIT(7), so the mask field is wrong. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l73.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index b7853b9d3a60..efd924ae384c 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1236,8 +1236,8 @@ static int cs42l73_set_tristate(struct snd_soc_dai *dai, int tristate)
 	struct snd_soc_codec *codec = dai->codec;
 	int id = dai->id;
 
-	return snd_soc_update_bits(codec, CS42L73_SPC(id),
-					0x7F, tristate << 7);
+	return snd_soc_update_bits(codec, CS42L73_SPC(id), CS42L73_SP_3ST,
+				   tristate << 7);
 }
 
 static const struct snd_pcm_hw_constraint_list constraints_12_24 = {
-- 
2.1.4
