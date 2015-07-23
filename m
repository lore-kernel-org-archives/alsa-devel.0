From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: cs42l73: Fix mask for setting
	CS42L73_SP_3ST bit
Date: Thu, 23 Jul 2015 08:26:57 +0800
Message-ID: <1437611217.6620.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DC3126559B
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 02:27:05 +0200 (CEST)
Received: by padck2 with SMTP id ck2so146255296pad.0
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 17:27:03 -0700 (PDT)
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

CS42L73_SP_3ST is BIT(7), so the mask field is wrong. Fix it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l73.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 7cb1d70..be6477f 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1236,8 +1236,8 @@ static int cs42l73_set_tristate(struct snd_soc_dai *dai, int tristate)
 	struct snd_soc_codec *codec = dai->codec;
 	int id = dai->id;
 
-	return snd_soc_update_bits(codec, CS42L73_SPC(id),
-					0x7F, tristate << 7);
+	return snd_soc_update_bits(codec, CS42L73_SPC(id), CS42L73_SP_3ST,
+				   tristate << 7);
 }
 
 static const struct snd_pcm_hw_constraint_list constraints_12_24 = {
-- 
2.1.0
