From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC][PATCH] ASoC: Move symmetric rate check for
	substreams to hw_params
Date: Mon,  7 Mar 2011 17:26:03 +0530
Message-ID: <1299498963-1134-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A42B10382B
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 12:56:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Afzal Mohammed <afzal@ti.com>, broonie@opensource.wolfsonmicro.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Currently the symmetric rate check is present in the snd_pcm_open() call.
However this causes snd_pcm_open() to fail for the 2nd substream is the
2nd call to snd_pcm_open() is made before the 1st substream has set a non-zero
rate by calling snd_pcm_hw_params().

Fix this by moving the call to snd_pcm_apply_symmetry() to soc_pcm_hw_params().

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---

This patch is one way of fixing the issues reported here
http://comments.gmane.org/gmane.linux.alsa.devel/75489 and
http://thread.gmane.org/gmane.linux.alsa.devel/81055/focus=21653

 sound/soc/soc-core.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 64befac..edec9af 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -638,13 +638,6 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto config_err;
 	}
 
-	/* Symmetry only applies if we've already got an active stream. */
-	if (cpu_dai->active || codec_dai->active) {
-		ret = soc_pcm_apply_symmetry(substream);
-		if (ret != 0)
-			goto config_err;
-	}
-
 	pr_debug("asoc: %s <-> %s info:\n",
 			codec_dai->name, cpu_dai->name);
 	pr_debug("asoc: rate mask 0x%x\n", runtime->hw.rates);
@@ -742,6 +735,9 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	codec_dai->active--;
 	codec->active--;
 
+	if(!codec_dai->active && !cpu_dai->active)
+		rtd->rate = 0;
+
 	/* Muting the DAC suppresses artifacts caused during digital
 	 * shutdown, for example from stopping clocks.
 	 */
@@ -898,12 +894,25 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	rtd->rate = params_rate(params);
+	/* Symmetry only applies if we've already got an active stream,
+	   a non zero rtd->rate implies that stream was already active and
+	   rtd->rate has been set previously */
+	if (rtd->rate) {
+		ret = soc_pcm_apply_symmetry(substream);
+		if (ret < 0)
+			goto symmetry_err;
+	} else {
+		rtd->rate = params_rate(params);
+	}
 
 out:
 	mutex_unlock(&pcm_mutex);
 	return ret;
 
+symmetry_err:
+	if(platform->driver->ops->hw_free)
+		platform->driver->ops->hw_free(substream);
+
 platform_err:
 	if (cpu_dai->driver->ops->hw_free)
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
-- 
1.6.2.4
