From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l34: Remove CS35L34_CHIP_ID from
	cs35l34_readable_register" to the asoc tree
Date: Tue, 25 Oct 2016 20:28:55 +0100
Message-ID: <E1bz7P5-0005It-GB@debutante>
References: <1477406376-16054-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F82D2664F7
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:29:04 +0200 (CEST)
In-Reply-To: <1477406376-16054-1-git-send-email-axel.lin@ingics.com>
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

   ASoC: cs35l34: Remove CS35L34_CHIP_ID from cs35l34_readable_register

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

>From 55060feefcdff692ace47b1a2346998dfcd4bcb5 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 25 Oct 2016 22:39:36 +0800
Subject: [PATCH] ASoC: cs35l34: Remove CS35L34_CHIP_ID from
 cs35l34_readable_register

CS35L34_CHIP_ID is not a register address, it's the value read from
CS35L34_DEVID_AB/CD/E registers.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l34.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index 404538379586..e0f672af1d84 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -145,7 +145,6 @@ static bool cs35l34_volatile_register(struct device *dev, unsigned int reg)
 static bool cs35l34_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case	CS35L34_CHIP_ID:
 	case	CS35L34_DEVID_AB:
 	case	CS35L34_DEVID_CD:
 	case	CS35L34_DEVID_E:
-- 
2.8.1
