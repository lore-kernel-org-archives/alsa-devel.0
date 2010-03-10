From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ASoC: DaVinci: Add hw_param callback for S/PDIF DIT link
Date: Wed, 10 Mar 2010 14:48:33 +0530
Message-ID: <1268212713-12041-1-git-send-email-chaithrika@ti.com>
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
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On TI DM6467 EVM, S/PDIF DIT codec fails to open as it is unable to install
hardware params. This dummy codec has no set_fmt and set_sysclk implementations
and calls from the application to these functions cause errors. This patch adds
a new hardware params callback function for S/PDIF transciever codec.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Tested-by: Anuj Aggarwal <anuj.aggarwal-l0cyMroinI0@public.gmane.org>
---
This patch has been re-worked upon based on the review comments for
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-January/024621.html

Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-evm.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7ccbe66..dba6651 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -81,10 +81,24 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int evm_spdif_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	/* set cpu DAI configuration */
+	return snd_soc_dai_set_fmt(cpu_dai, AUDIO_FORMAT);
+}
+
 static struct snd_soc_ops evm_ops = {
 	.hw_params = evm_hw_params,
 };
 
+static struct snd_soc_ops evm_spdif_ops = {
+	.hw_params = evm_spdif_hw_params,
+};
+
 /* davinci-evm machine dapm widgets */
 static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
@@ -165,7 +179,7 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.stream_name = "spdif",
 		.cpu_dai = &davinci_mcasp_dai[DAVINCI_MCASP_DIT_DAI],
 		.codec_dai = &dit_stub_dai,
-		.ops = &evm_ops,
+		.ops = &evm_spdif_ops,
 	},
 };
 static struct snd_soc_dai_link da8xx_evm_dai = {
-- 
1.5.6
