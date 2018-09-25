From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to
	snd_dummy_ops
Date: Mon, 24 Sep 2018 17:47:11 -0700
Message-ID: <20180925004711.99422-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EA9D2676A7
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 02:47:26 +0200 (CEST)
Received: by mail-pg1-f195.google.com with SMTP id n31-v6so3271602pgm.7
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2018 17:47:26 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org
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

Rename the symbol in soc-utils.c to 'snd_dummy_ops' to avoid the conflict.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 sound/soc/soc-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index e0c93496c0cd..ab44133bc0bf 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static const struct snd_pcm_ops dummy_dma_ops = {
+static const struct snd_pcm_ops snd_dummy_ops = {
 	.open		= dummy_dma_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 };
 
 static const struct snd_soc_component_driver dummy_platform = {
-	.ops = &dummy_dma_ops,
+	.ops = &snd_dummy_ops,
 };
 
 static const struct snd_soc_component_driver dummy_codec = {
-- 
2.19.0.605.g01d371f741-goog
