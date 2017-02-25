From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: pxa: Added */ to the next line
Date: Sat, 25 Feb 2017 23:20:30 +0200
Message-ID: <1488057630-14575-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: perex@perex.cz, daniel@zonque.org, robert.jarzmik@free.fr, haojian.zhuang@gmail.com, tiwai@suse.com, philipp.zabel@gmail.com, lost.distance@yahoo.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/hx4700.c     | 3 ++-
 sound/soc/pxa/pxa-ssp.c    | 3 ++-
 sound/soc/pxa/pxa2xx-pcm.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 8548304..17c2e67 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -70,7 +70,8 @@ static int hx4700_hw_params(struct snd_pcm_substream *substream,
 		return ret;

 	/* inform codec driver about clock freq *
-	 * (PXA I2S always uses divider 256)    */
+	 * (PXA I2S always uses divider 256)
+	 */
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, 256 * params_rate(params),
 			SND_SOC_CLOCK_IN);
 	if (ret < 0)
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3cad990..3bdace6 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -254,7 +254,8 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	}

 	/* The SSP clock must be disabled when changing SSP clock mode
-	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
+	 * on PXA2xx.  On PXA3xx it must be enabled when doing so.
+	 */
 	if (ssp->type != PXA3xx_SSP)
 		clk_disable_unprepare(ssp->clk);
 	val = pxa_ssp_read_reg(ssp, SSCR0) | sscr0;
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index b51d7a0..3926cd8 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -31,7 +31,8 @@ static int pxa2xx_pcm_hw_params(struct snd_pcm_substream *substream,
 	dma = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);

 	/* return if this is a bufferless transfer e.g.
-	 * codec <--> BT codec or GSM modem -- lg FIXME */
+	 * codec <--> BT codec or GSM modem -- lg
+	 */
 	if (!dma)
 		return 0;

--
1.9.1
