From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: Prefix hexadecimal ID register
	value with 0x in error print" to the asoc tree
Date: Fri, 03 Jul 2015 19:10:47 +0100
Message-ID: <E1ZB5QF-00058v-9Y@debutante>
References: <1435229941-9574-5-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C4E8265050
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2015 20:10:54 +0200 (CEST)
In-Reply-To: <1435229941-9574-5-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: Prefix hexadecimal ID register value with 0x in error print

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

>From 45f6ac1e3b890f072b239d8721be9b2f1574c13c Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Thu, 25 Jun 2015 13:59:00 +0300
Subject: [PATCH] ASoC: rt5670: Prefix hexadecimal ID register value with 0x in
 error print

Make it obvious that unexpected value read from ID register is printed in
hexadecimal.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 840dd6d0003a..115bb4b19ef9 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2864,7 +2864,7 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 	regmap_read(rt5670->regmap, RT5670_VENDOR_ID2, &val);
 	if (val != RT5670_DEVICE_ID) {
 		dev_err(&i2c->dev,
-			"Device with ID register %x is not rt5670/72\n", val);
+			"Device with ID register %#x is not rt5670/72\n", val);
 		return -ENODEV;
 	}
 
-- 
2.1.4
