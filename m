From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ASoC: atmel_pcm: use endian agnostic IO
	accessors
Date: Thu, 26 Mar 2015 15:28:01 +0000
Message-ID: <1427383681-3537-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ducie-dc1.codethink.co.uk (ducie-dc1.codethink.co.uk
 [185.25.241.215])
 by alsa0.perex.cz (Postfix) with ESMTP id D6EFA2657A5
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 16:28:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@lists.codethink.co.uk
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bo Shen <voice.shen@atmel.com>, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

The atmel-pcm.h is using __raw_readl and __raw_writel for IO
accessors which do not work if the processor is in big endian
mode (the peripheral will still expect data in little endian
format).

Note, I do not think this is being used in the AVR32 which
would require a different fix (possible after atmel_io.h is
merged).

This has not been run-tested as I do not have a board with
an audio code on.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Bo Shen <voice.shen@atmel.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Mark Brown <broonie@kernel.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
CC: alsa-devel@alsa-project.org
---
 sound/soc/atmel/atmel-pcm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
index 12ae814..8f5f551 100644
--- a/sound/soc/atmel/atmel-pcm.h
+++ b/sound/soc/atmel/atmel-pcm.h
@@ -80,8 +80,8 @@ struct atmel_pcm_dma_params {
 /*
  * SSC register access (since ssc_writel() / ssc_readl() require literal name)
  */
-#define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
-#define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))
+#define ssc_readx(base, reg)            (readl_relaxed((base) + (reg)))
+#define ssc_writex(base, reg, value)    writel_relaxed((value), (base) + (reg))
 
 int atmel_pcm_new(struct snd_soc_pcm_runtime *rtd);
 void atmel_pcm_free(struct snd_pcm *pcm);
-- 
2.1.4
