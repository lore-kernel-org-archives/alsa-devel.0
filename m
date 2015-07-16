From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: remove meanless pr_info" to the
	asoc tree
Date: Thu, 16 Jul 2015 13:12:33 +0100
Message-ID: <E1ZFi1h-0001lh-B9@finisterre>
References: <1437012093-6133-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FD1B26655F
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 14:12:45 +0200 (CEST)
In-Reply-To: <1437012093-6133-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: remove meanless pr_info

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

>From 5efe58c44312a7f8a1f3ec77c2b88f6d22b74880 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 16 Jul 2015 10:01:33 +0800
Subject: [PATCH] ASoC: rt298: remove meanless pr_info

This line doesn't include any information. So, remove it.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 7c4bcb6..6ff68a3 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1144,8 +1144,6 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	const struct acpi_device_id *acpiid;
 	int i, ret;
 
-	pr_info("%s\n", __func__);
-
 	rt298 = devm_kzalloc(&i2c->dev,	sizeof(*rt298),
 				GFP_KERNEL);
 	if (NULL == rt298)
-- 
2.1.4
