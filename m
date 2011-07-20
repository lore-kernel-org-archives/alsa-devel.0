From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: davinci: fix codec start and stop functions
Date: Wed, 20 Jul 2011 17:36:04 +0530
Message-ID: <1311163564-24526-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org

According to DM365 voice codec data sheet at [1], before starting
recording or playback, ADC/DAC modules should follow a reset and
enable cycle. Writing a 1 to the ADC/DAC bit in the register resets
the module and clearing the bit to 0 will enable the module. But the
driver seems to be doing the reverse of it.

[1] http://focus.ti.com/lit/ug/sprufi9b/sprufi9b.pdf

Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj-l0cyMroinI0@public.gmane.org>
---
 sound/soc/davinci/davinci-vcif.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index 9259f1f..c957e9e 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -62,9 +62,9 @@ static void davinci_vcif_start(struct snd_pcm_substream *substream)
 	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 1);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 0);
 	else
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 1);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 0);
 
 	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
 }
@@ -80,9 +80,9 @@ static void davinci_vcif_stop(struct snd_pcm_substream *substream)
 	/* Reset transmitter/receiver and sample rate/frame sync generators */
 	w = readl(davinci_vc->base + DAVINCI_VC_CTRL);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 0);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTDAC, 1);
 	else
-		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 0);
+		MOD_REG_BIT(w, DAVINCI_VC_CTRL_RSTADC, 1);
 
 	writel(w, davinci_vc->base + DAVINCI_VC_CTRL);
 }
-- 
1.7.1
