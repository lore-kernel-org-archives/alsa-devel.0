From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH v2] asoc: davinci: da830/omap-l137: correct
	cpu_dai_name
Date: Thu,  3 Feb 2011 16:42:25 +0530
Message-ID: <1296731545-8338-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 68BF5103A50
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2011 12:12:39 +0100 (CET)
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
Cc: davinci-linux-open-source@linux.davincidsp.com, sshtylyov@mvista.com, broonie@opensource.wolfsonmicro.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, stable@kernel.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

McASP1 is used on the DA830/OMAP-L137 platform for the codec.
This is different from the DA850/OMAP-L138 platform which uses McASP0.

This is fixed by adding a new snd_soc_dai_link struct.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---

v2: 
Fixed the subject as pointed out by Sergei.

 sound/soc/davinci/davinci-evm.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index b36f0b3..fe79842 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -218,7 +218,19 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 		.ops = &evm_spdif_ops,
 	},
 };
-static struct snd_soc_dai_link da8xx_evm_dai = {
+
+static struct snd_soc_dai_link da830_evm_dai = {
+	.name = "TLV320AIC3X",
+	.stream_name = "AIC3X",
+	.cpu_dai_name = "davinci-mcasp.1",
+	.codec_dai_name = "tlv320aic3x-hifi",
+	.codec_name = "tlv320aic3x-codec.1-0018",
+	.platform_name = "davinci-pcm-audio",
+	.init = evm_aic3x_init,
+	.ops = &evm_ops,
+};
+
+static struct snd_soc_dai_link da850_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
 	.cpu_dai_name= "davinci-mcasp.0",
@@ -259,13 +271,13 @@ static struct snd_soc_card dm6467_snd_soc_card_evm = {
 
 static struct snd_soc_card da830_snd_soc_card = {
 	.name = "DA830/OMAP-L137 EVM",
-	.dai_link = &da8xx_evm_dai,
+	.dai_link = &da830_evm_dai,
 	.num_links = 1,
 };
 
 static struct snd_soc_card da850_snd_soc_card = {
 	.name = "DA850/OMAP-L138 EVM",
-	.dai_link = &da8xx_evm_dai,
+	.dai_link = &da850_evm_dai,
 	.num_links = 1,
 };
 
-- 
1.6.2.4
