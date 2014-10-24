From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv5 5/9] ASOC: wm8971: improve the function of
	wm8971_set_dai_fmt()
Date: Fri, 24 Oct 2014 14:00:31 +0800
Message-ID: <1414130435-14183-5-git-send-email-xavier.hsu@linaro.org>
References: <1414130435-14183-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 439852604BD
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 08:01:07 +0200 (CEST)
In-Reply-To: <1414130435-14183-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: Xavier Hsu <xavier.hsu@linaro.org>, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

We use snd_soc_update_bits() to replace
snd_soc_write().
"As suggested by Mark Brown"

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 4572446..1c871de 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -552,12 +552,11 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = 0;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		iface = 0x0040;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0040, 0x0040);
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
@@ -568,18 +567,18 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		iface |= 0x0002;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0002, 0x0002);
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		iface |= 0x0001;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0001, 0x0001);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		iface |= 0x0003;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0003, 0x0003);
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		iface |= 0x0013;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0013, 0x0013);
 		break;
 	default:
 		return -EINVAL;
@@ -590,19 +589,18 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
-		iface |= 0x0090;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0090, 0x0090);
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		iface |= 0x0080;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0080, 0x0080);
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		iface |= 0x0010;
+		snd_soc_update_bits(codec, WM8971_IFACE, 0x0010, 0x0010);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8971_IFACE, iface);
 	return 0;
 }
 
-- 
1.7.9.5
