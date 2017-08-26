From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 5/9] ASoC: max98927: Removed obsolete variables
Date: Fri, 25 Aug 2017 17:41:06 -0700
Message-ID: <1503708070-7906-5-git-send-email-ryans.lee@maximintegrated.com>
References: <1503708070-7906-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0108.outbound.protection.outlook.com [104.47.37.108])
 by alsa0.perex.cz (Postfix) with ESMTP id F40DA267408
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 02:41:41 +0200 (CEST)
In-Reply-To: <1503708070-7906-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changes : Removed obsolete variables from max98927_priv

 sound/soc/codecs/max98927.h | 4 ----
 1 file changed, 4 deletions(-)
 mode change 100644 => 100755 sound/soc/codecs/max98927.h

diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
old mode 100644
new mode 100755
index 3069a09..30cc40a
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -263,16 +263,12 @@
 struct max98927_priv {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
-	struct max98927_pdata *pdata;
-	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
 	unsigned int i_l_slot;
 	bool interleave_mode;
 	unsigned int ch_size;
-	unsigned int rate;
 	unsigned int iface;
 	unsigned int master;
-	unsigned int digital_gain;
 };
 #endif
-- 
1.9.1
