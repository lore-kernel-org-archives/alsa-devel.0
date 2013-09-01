From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Staticse non-exported
 symbols
Date: Sun, 1 Sep 2013 02:43:49 +0000
Message-ID: <cgvcjx6352rqksg31th46kge.1378003344008@email.android.com>
References: <1377963705-25670-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 58A8C261703
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 04:43:55 +0200 (CEST)
In-Reply-To: <1377963705-25670-1-git-send-email-broonie@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Acked-by: Nicolin Chen <B42378@freescale.com>

Thank you sir.

Sent by Android device.

Mark Brown <broonie@kernel.org> wrote:


From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index e93dc0d..c5c228a 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -411,8 +411,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
        return 0;
 }

-int fsl_spdif_startup(struct snd_pcm_substream *substream,
-                       struct snd_soc_dai *cpu_dai)
+static int fsl_spdif_startup(struct snd_pcm_substream *substream,
+                            struct snd_soc_dai *cpu_dai)
 {
        struct snd_soc_pcm_runtime *rtd = substream->private_data;
        struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(rtd->cpu_dai);
@@ -546,7 +546,7 @@ static int fsl_spdif_trigger(struct snd_pcm_substream *substream,
        return 0;
 }

-struct snd_soc_dai_ops fsl_spdif_dai_ops = {
+static struct snd_soc_dai_ops fsl_spdif_dai_ops = {
        .startup = fsl_spdif_startup,
        .hw_params = fsl_spdif_hw_params,
        .trigger = fsl_spdif_trigger,
@@ -919,7 +919,7 @@ static int fsl_spdif_dai_probe(struct snd_soc_dai *dai)
        return 0;
 }

-struct snd_soc_dai_driver fsl_spdif_dai = {
+static struct snd_soc_dai_driver fsl_spdif_dai = {
        .probe = &fsl_spdif_dai_probe,
        .playback = {
                .channels_min = 2,
--
1.8.4.rc3

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
