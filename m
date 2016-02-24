From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: fix type of variable
	containing error codes" to the asoc tree
Date: Wed, 24 Feb 2016 13:15:38 +0900
Message-ID: <E1aYQrS-0000sc-3J@finisterre>
References: <1456209914-13375-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C972667F8
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 05:15:50 +0100 (CET)
In-Reply-To: <1456209914-13375-1-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: fix type of variable containing error codes

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

>From 127a9cbb5860a7cf15f4d4703ab0454e4603e8ac Mon Sep 17 00:00:00 2001
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Tue, 23 Feb 2016 07:45:14 +0100
Subject: [PATCH] ASoC: max9867: fix type of variable containing error codes

value variable can contain error values and is compared with zero.
Its type must be signed.

The problem has been detected using coccinelle script
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index ab7a94db8db7..4fb6fc7188c7 100755
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -180,7 +180,8 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
-	unsigned int ni_h, ni_l, value;
+	unsigned int ni_h, ni_l;
+	int value;
 
 	value = get_ni_value(max9867->sysclk, params_rate(params));
 	if (value < 0)
-- 
2.7.0
