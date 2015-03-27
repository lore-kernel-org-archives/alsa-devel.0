From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: max98925: Fix bit-width 24 settings
 in max98925_dai_hw_params
Date: Fri, 27 Mar 2015 17:25:21 +0800
Message-ID: <1427448321.29963.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id E0F702606D1
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 10:25:27 +0100 (CET)
Received: by pdnc3 with SMTP id c3so91202397pdn.0
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 02:25:26 -0700 (PDT)
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
Cc: Anish kumar <anish.kumar@maximintegrated.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ralph Birt <rdbirt@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Trivial typo fix.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Anish,
This looks like a typo, can you confirm if this patch is correct.
Thanks.

 sound/soc/codecs/max98925.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 0796dfa..9b5a17d 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -442,8 +442,8 @@ static int max98925_dai_hw_params(struct snd_pcm_substream *substream,
 	case 24:
 		regmap_update_bits(max98925->regmap,
 				MAX98925_FORMAT,
-				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_32);
-		max98925->ch_size = 32;
+				M98925_DAI_CHANSZ_MASK, M98925_DAI_CHANSZ_24);
+		max98925->ch_size = 24;
 		break;
 	case 32:
 		regmap_update_bits(max98925->regmap,
-- 
1.9.1
