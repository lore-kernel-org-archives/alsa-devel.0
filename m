From: Xavier Hsu <xavier.hsu@linaro.org>
Subject: [PATCHv3 4/9] Improve wm8971_set_dai_fmt
Date: Tue,  2 Sep 2014 11:30:43 +0800
Message-ID: <1409628648-13732-4-git-send-email-xavier.hsu@linaro.org>
References: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Kraken (unknown [124.219.7.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 097022654FB
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 05:30:53 +0200 (CEST)
In-Reply-To: <1409628648-13732-1-git-send-email-xavier.hsu@linaro.org>
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

This patch improves WM8971.
We modify the function of wm8971_set_dai_fmt().

Any comments about improving the patch are welcome.
Thanks.

Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---
 sound/soc/codecs/wm8971.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 7c2b175..64ed226 100755
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -550,12 +550,11 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
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
@@ -566,18 +565,18 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
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
@@ -588,19 +587,18 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
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
