From: "Richard A. Holden III" <aciddeath@gmail.com>
Subject: [PATCH] Remove unused variable from tlv320aic23 codec
Date: Thu, 20 Nov 2008 11:03:23 -0700
Message-ID: <1227204203-32112-3-git-send-email-aciddeath@gmail.com>
References: <1227204203-32112-1-git-send-email-aciddeath@gmail.com>
 <1227204203-32112-2-git-send-email-aciddeath@gmail.com>
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <1227204203-32112-2-git-send-email-aciddeath@gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Remove codec var from tlv320aic23_set_dai_sysclk, it is assigned to
but never read.

Signed-off-by: Richard A. Holden III <aciddeath@gmail.com>

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/tlv320aic23.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 44308da..45395d0 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -421,8 +421,6 @@ static int tlv320aic23_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int tlv320aic23_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				      int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-
 	switch (freq) {
 	case 12000000:
 		return 0;
-- 
1.5.6.4
