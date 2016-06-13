From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: pcm1681/pcm1791: fix typo in declaration
Date: Mon, 13 Jun 2016 17:39:45 +0200
Message-ID: <1465832422-2998958-4-git-send-email-arnd@arndb.de>
References: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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
2.7.0
