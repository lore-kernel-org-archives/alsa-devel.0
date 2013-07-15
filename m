From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH RESEND] ASoC: max98088 - fix element type of
	the register cache.
Date: Mon, 15 Jul 2013 09:38:46 -0700
Message-ID: <1373906326-18601-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f202.google.com (mail-ye0-f202.google.com
 [209.85.213.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 78B58261989
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 18:39:00 +0200 (CEST)
Received: by mail-ye0-f202.google.com with SMTP id r11so1089525yen.1
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2013 09:38:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Chih-Chung Chang <chihchung@chromium.org>, Dylan Reid <dgreid@chromium.org>, broonie@kernel.org, lgirdwood@gmail.com, evan.ragsdale@maxim-ic.com
List-Id: alsa-devel@alsa-project.org

From: Chih-Chung Chang <chihchung@chromium.org>

The registers of max98088 are 8 bits, not 16 bits. This bug causes the
contents of registers to be overwritten with bad values when the codec
is suspended and then resumed.

Signed-off-by: Chih-Chung Chang <chihchung@chromium.org>
Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/codecs/max98088.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 3eeada5..566a367 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1612,7 +1612,7 @@ static int max98088_dai2_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 
 static void max98088_sync_cache(struct snd_soc_codec *codec)
 {
-       u16 *reg_cache = codec->reg_cache;
+       u8 *reg_cache = codec->reg_cache;
        int i;
 
        if (!codec->cache_sync)
-- 
1.8.1.3.605.g02339dd
