From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8741: Fix setting BCLK and LRCLK
	polarity" to the asoc tree
Date: Fri, 03 Nov 2017 18:50:34 +0000
Message-ID: <E1eAh34-0005lQ-U9@debutante>
References: <1509628982-9767-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B287F2675B3
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 19:50:38 +0100 (CET)
In-Reply-To: <1509628982-9767-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, ce3a@gmx.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8741: Fix setting BCLK and LRCLK polarity

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 81b3cc55afc3cde54df98f93fbd4704fab7cc0e0 Mon Sep 17 00:00:00 2001
From: Sergej Sawazki <sergej@taudac.com>
Date: Fri, 3 Nov 2017 19:34:28 +0100
Subject: [PATCH] ASoC: wm8741: Fix setting BCLK and LRCLK polarity

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
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8741.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 3c96af057a3e..a394dbee77aa 100644
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
2.15.0
