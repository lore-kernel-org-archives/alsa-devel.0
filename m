From: Sergej Sawazki <sergej@taudac.com>
Subject: [PATCH] ASoC: wm8741: Fix setting BCLK and LRCLK
	polarity
Date: Thu,  2 Nov 2017 14:23:02 +0100
Message-ID: <1509628982-9767-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s62.goserver.host (s62.goserver.host [37.17.224.62])
 by alsa0.perex.cz (Postfix) with ESMTP id A61E3266DEA
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 14:24:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.cirrus.com
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Sergej Sawazki <sergej@taudac.com>
List-Id: alsa-devel@alsa-project.org

After checking the code and the datasheet, it seems like we are handling
the clock inversion (SND_SOC_DAIFMT_NB_IF and SND_SOC_DAIFMT_IB_IF) not
correctly.

>From the datasheet (Table 58):
R5 Format Control, BITS[5:4], [BCP:LRP]:
  (0) 00 =  normal   BCLK, normal   LRCLK
  (1) 01 =  normal   BCLK, inverted LRCLK <-- Fix this
  (2) 10 =  inverted BCLK, normal   LRCLK
  (3) 11 =  inverted BCLK, inverted LRCLK <-- Fix this

Signed-off-by: Sergej Sawazki <sergej@taudac.com>
---
 sound/soc/codecs/wm8741.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 3c96af0..a394dbe 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -333,13 +333,13 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		break;
-	case SND_SOC_DAIFMT_IB_IF:
+	case SND_SOC_DAIFMT_NB_IF:
 		iface |= 0x10;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
 		iface |= 0x20;
 		break;
-	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_IF:
 		iface |= 0x30;
 		break;
 	default:
-- 
2.7.4
