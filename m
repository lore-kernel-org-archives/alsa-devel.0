From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l33: Fix display revision id" to
	the asoc tree
Date: Fri, 01 Jul 2016 11:54:40 +0200
Message-ID: <E1bIv9k-0003mc-9C@finisterre>
References: <1467245670.7105.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D787A2614A7
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 11:54:55 +0200 (CEST)
In-Reply-To: <1467245670.7105.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l33: Fix display revision id

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

>From 5d78b027c0d22589d535b3657700e7ff6499d3ed Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 30 Jun 2016 08:14:30 +0800
Subject: [PATCH] ASoC: cs35l33: Fix display revision id

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l33.c b/sound/soc/codecs/cs35l33.c
index 689c3598bf3d..a4cbb16d68ad 100644
--- a/sound/soc/codecs/cs35l33.c
+++ b/sound/soc/codecs/cs35l33.c
@@ -1219,7 +1219,7 @@ static int cs35l33_i2c_probe(struct i2c_client *i2c_client,
 	}
 
 	dev_info(&i2c_client->dev,
-		 "Cirrus Logic CS35L33, Revision: %02X\n", ret & 0xFF);
+		 "Cirrus Logic CS35L33, Revision: %02X\n", reg & 0xFF);
 
 	ret = regmap_register_patch(cs35l33->regmap,
 			cs35l33_patch, ARRAY_SIZE(cs35l33_patch));
-- 
2.8.1
