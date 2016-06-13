From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm1681/pcm1791: fix typo in declaration" to the asoc tree
Date: Mon, 13 Jun 2016 17:54:48 +0100
Message-ID: <E1bCV8S-0004dX-Qv@finisterre>
References: <1465832422-2998958-4-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465832422-2998958-4-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm1681/pcm1791: fix typo in declaration

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

>From a074ae0ed68385ee403e4247ce8274705fe9c4e0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Jun 2016 17:39:45 +0200
Subject: [PATCH] ASoC: pcm1681/pcm1791: fix typo in declaration

gcc -Wextra warns about an obvious but harmless typo in the
pcm1681_writeable_reg function, which has an extra 'register
keyword', and in pcm179x, which has a second copy of that
declaration:

sound/soc/codecs/pcm1681.c:76:42: error: 'register' is not at beginning of declaration [-Werror=old-style-declaration]
sound/soc/codecs/pcm179x.c:62:42: error: 'register' is not at beginning of declaration [-Werror=old-style-declaration]

For consistency with the rest of the file, I'm changing this from
'unsigned register' to 'unsigned int', which has the same meaning
but causes no warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm1681.c | 2 +-
 sound/soc/codecs/pcm179x.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 58325234285c..33e1fc2d1598 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -73,7 +73,7 @@ static bool pcm1681_accessible_reg(struct device *dev, unsigned int reg)
 	return !((reg == 0x00) || (reg == 0x0f));
 }
 
-static bool pcm1681_writeable_reg(struct device *dev, unsigned register reg)
+static bool pcm1681_writeable_reg(struct device *dev, unsigned int reg)
 {
 	return pcm1681_accessible_reg(dev, reg) &&
 		(reg != PCM1681_ZERO_DETECT_STATUS);
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 06a66579ca6d..88fbdd184aa0 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -59,7 +59,7 @@ static bool pcm179x_accessible_reg(struct device *dev, unsigned int reg)
 	return reg >= 0x10 && reg <= 0x17;
 }
 
-static bool pcm179x_writeable_reg(struct device *dev, unsigned register reg)
+static bool pcm179x_writeable_reg(struct device *dev, unsigned int reg)
 {
 	bool accessible;
 
-- 
2.8.1
