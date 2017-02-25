From: "sergiu.weisz" <sergiu121@gmail.com>
Subject: [PATCH] davinci: davinci-evm: Put spaces before '='
Date: Sat, 25 Feb 2017 12:45:36 +0200
Message-ID: <20170225104536.12396-1-sergiu121@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: "sergiu.weisz" <sergiu121@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: sergiu.weisz <sergiu121@gmail.com>
---
 sound/soc/davinci/davinci-evm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7a369e0..c5d80e8 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -195,7 +195,7 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "TLV320AIC3X",
 		.stream_name = "AIC3X",
-		.cpu_dai_name= "davinci-mcasp.0",
+		.cpu_dai_name = "davinci-mcasp.0",
 		.codec_dai_name = "tlv320aic3x-hifi",
 		.platform_name = "davinci-mcasp.0",
 		.codec_name = "tlv320aic3x-codec.0-001a",
@@ -207,7 +207,7 @@ static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "McASP",
 		.stream_name = "spdif",
-		.cpu_dai_name= "davinci-mcasp.1",
+		.cpu_dai_name = "davinci-mcasp.1",
 		.codec_dai_name = "dit-hifi",
 		.codec_name = "spdif_dit",
 		.platform_name = "davinci-mcasp.1",
@@ -232,7 +232,7 @@ static struct snd_soc_dai_link da830_evm_dai = {
 static struct snd_soc_dai_link da850_evm_dai = {
 	.name = "TLV320AIC3X",
 	.stream_name = "AIC3X",
-	.cpu_dai_name= "davinci-mcasp.0",
+	.cpu_dai_name = "davinci-mcasp.0",
 	.codec_dai_name = "tlv320aic3x-hifi",
 	.codec_name = "tlv320aic3x-codec.1-0018",
 	.platform_name = "davinci-mcasp.0",
-- 
2.9.3
