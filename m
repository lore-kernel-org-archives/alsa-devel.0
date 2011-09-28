From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Add BUG() assertion if max98088_get_channel
 returns -EINVAL
Date: Wed, 28 Sep 2011 22:01:11 +0800
Message-ID: <1317218471.8008.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Peter Hsiang <peter.hsiang@maxim-ic.com>, Jesse Marroquin <jesse.marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

The callers use the return value of max98088_get_channel as array index to
access max98088->dai[] array.
Add BUG() assertion for out of bound access of max98088->dai[] array.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/max98088.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index ac65a2d..aaca91c 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1703,6 +1703,7 @@ static int max98088_get_channel(const char *name)
                return 0;
        if (strcmp(name, "EQ2 Mode") == 0)
                return 1;
+	BUG();
        return -EINVAL;
 }
 
-- 
1.7.4.1
