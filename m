From: Mark Brown <broonie@kernel.org>
Subject: Applied "wcd9335: fix a incorrect use of kstrndup()" to the asoc tree
Date: Wed, 29 May 2019 16:45:29 +0100 (BST)
Message-ID: <20190529154529.3178944004A@finisterre.sirena.org.uk>
References: <20190529015305.GA4700@zhanggen-UX430UQ>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529015305.GA4700@zhanggen-UX430UQ>
Sender: linux-kernel-owner@vger.kernel.org
To: Gen Zhang <blackgod016574@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, wen.yang99@zte.com.cn
List-Id: alsa-devel@alsa-project.org

The patch

   wcd9335: fix a incorrect use of kstrndup()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From a54988113985ca22e414e132054f234fc8a92604 Mon Sep 17 00:00:00 2001
From: Gen Zhang <blackgod016574@gmail.com>
Date: Wed, 29 May 2019 09:53:05 +0800
Subject: [PATCH] wcd9335: fix a incorrect use of kstrndup()

In wcd9335_codec_enable_dec(), 'widget_name' is allocated by kstrndup().
However, according to doc: "Note: Use kmemdup_nul() instead if the size
is known exactly." So we should use kmemdup_nul() here instead of
kstrndup().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a04a7cedd99d..85737fe54474 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2734,7 +2734,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	char *dec;
 	u8 hpf_coff_freq;
 
-	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
 	if (!widget_name)
 		return -ENOMEM;
 
-- 
2.20.1
