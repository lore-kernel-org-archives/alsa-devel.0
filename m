From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: cx2072x: mark PM function as __maybe_unused
Date: Mon, 17 Jun 2019 13:06:15 +0200
Message-ID: <20190617110615.2084748-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, simon.ho@synaptics.com, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

While the suspend function is already marked __maybe_unused,
the resume function is not, which leads to a warning when
CONFIG_PM is disabled:

sound/soc/codecs/cx2072x.c:1625:12: error: unused function 'cx2072x_runtime_resume' [-Werror,-Wunused-function]

Mark this one like the other one.

Fixes: a497a4363706 ("ASoC: Add support for Conexant CX2072X CODEC")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index f2cb35a50726..1c1ba7bea4d8 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -1622,7 +1622,7 @@ static int __maybe_unused cx2072x_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int cx2072x_runtime_resume(struct device *dev)
+static int __maybe_unused cx2072x_runtime_resume(struct device *dev)
 {
 	struct cx2072x_priv *cx2072x = dev_get_drvdata(dev);
 
-- 
2.20.0
