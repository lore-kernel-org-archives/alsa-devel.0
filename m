From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_dma_ops
Date: Tue, 25 Sep 2018 11:09:14 -0700
Message-ID: <20180925180914.193244-1-mka@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

The symbols 'dummy_dma_ops' is declared with different data types by
sound/soc/soc-utils.c and arch/arm64/include/asm/dma-mapping.h. This
leads to conflicts when soc-utils.c (indirectly) includes dma-mapping.h:

sound/soc/soc-utils.c:282:33: error: conflicting types for 'dummy_dma_ops'
  static const struct snd_pcm_ops dummy_dma_ops = {
                                  ^
...
arch/arm64/include/asm/dma-mapping.h:27:33: note: previous declaration of 'dummy_dma_ops' was here
  extern const struct dma_map_ops dummy_dma_ops;
                                  ^

Rename the symbol in soc-utils.c to 'snd_dummy_dma_ops' to avoid the
conflict.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- use 'snd_dummy_dma_ops' instead of 'snd_dummy_ops'
---
 sound/soc/soc-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index e0c93496c0cd..e3b9dd634c6d 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_pcm_ops dummy_dma_ops = {
+static const struct snd_pcm_ops snd_dummy_dma_ops = {
 	.open		= dummy_dma_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
 static const struct snd_soc_component_driver dummy_platform = {
-	.ops = &dummy_dma_ops,
+	.ops = &snd_dummy_dma_ops,
 };
 
 static const struct snd_soc_component_driver dummy_codec = {
-- 
2.19.0.605.g01d371f741-goog
