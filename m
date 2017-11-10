From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ASoC: rt5514: mark PM functions as
	__maybe_unused
Date: Fri, 10 Nov 2017 15:54:42 +0100
Message-ID: <20171110145455.821805-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D322266C99
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 15:55:13 +0100 (CET)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Chinyue Chen <chinyue@chromium.org>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Hsin-Yu Chao <hychao@chromium.org>, Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

The new functions are only used when CONFIG_PM is enabled,
leading to a harmless warning:

sound/soc/codecs/rt5514-spi.c:474:12: error: 'rt5514_resume' defined but not used [-Werror=unused-function]
sound/soc/codecs/rt5514-spi.c:464:12: error: 'rt5514_suspend' defined but not used [-Werror=unused-function]

This marks them as __maybe_unused to make the build silent
again.

Fixes: 58f1c07d23cd ("ASoC: rt5514: Voice wakeup support.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/rt5514-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 36e0a58ffc87..2df91db765ac 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -461,7 +461,7 @@ static int rt5514_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int rt5514_suspend(struct device *dev)
+static int __maybe_unused rt5514_suspend(struct device *dev)
 {
 	int irq = to_spi_device(dev)->irq;
 
@@ -471,7 +471,7 @@ static int rt5514_suspend(struct device *dev)
 	return 0;
 }
 
-static int rt5514_resume(struct device *dev)
+static int __maybe_unused rt5514_resume(struct device *dev)
 {
 	struct snd_soc_platform *platform = snd_soc_lookup_platform(dev);
 	struct rt5514_dsp *rt5514_dsp =
-- 
2.9.0
