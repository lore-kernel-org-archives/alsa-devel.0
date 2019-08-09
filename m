From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ml26124: remove unused variable 'ngth'" to the asoc tree
Date: Fri,  9 Aug 2019 13:31:52 +0100 (BST)
Message-ID: <20190809123152.6CEB82743057@ypsilon.sirena.org.uk>
References: <20190809082440.67412-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809082440.67412-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, gregkh@linuxfoundation.org, Hulk Robot <hulkci@huawei.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, rfontana@redhat.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ml26124: remove unused variable 'ngth'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 0fd70e22a0ffebd13028bf2c7da6b747070475bf Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 9 Aug 2019 16:24:40 +0800
Subject: [PATCH] ASoC: ml26124: remove unused variable 'ngth'

In file included from ./include/sound/tlv.h:10:0,
                 from sound/soc/codecs/ml26124.c:19:
sound/soc/codecs/ml26124.c:59:35: warning: ngth defined but not used [-Wunused-const-variable=]
 static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
                                   ^
./include/uapi/sound/tlv.h:64:15: note: in definition of macro SNDRV_CTL_TLVD_DECLARE_DB_SCALE
  unsigned int name[] = { \
               ^~~~
sound/soc/codecs/ml26124.c:59:14: note: in expansion of macro DECLARE_TLV_DB_SCALE
 static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
              ^~~~~~~~~~~~~~~~~~~~

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20190809082440.67412-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ml26124.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/ml26124.c b/sound/soc/codecs/ml26124.c
index 3abd27893ce6..55823bc95d06 100644
--- a/sound/soc/codecs/ml26124.c
+++ b/sound/soc/codecs/ml26124.c
@@ -56,7 +56,6 @@ static const DECLARE_TLV_DB_SCALE(alclvl, -2250, 150, 0);
 static const DECLARE_TLV_DB_SCALE(mingain, -1200, 600, 0);
 static const DECLARE_TLV_DB_SCALE(maxgain, -675, 600, 0);
 static const DECLARE_TLV_DB_SCALE(boost_vol, -1200, 75, 0);
-static const DECLARE_TLV_DB_SCALE(ngth, -7650, 150, 0);
 
 static const char * const ml26124_companding[] = {"16bit PCM", "u-law",
 						  "A-law"};
-- 
2.20.1
