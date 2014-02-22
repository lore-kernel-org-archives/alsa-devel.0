From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: wm8958-dsp: Fix firmware block loading
Date: Sat, 22 Feb 2014 18:30:13 +0100
Message-ID: <1393090213-10532-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-015.synserver.de (smtp-out-131.synserver.de
 [212.40.185.131])
 by alsa0.perex.cz (Postfix) with ESMTP id D9265261B0C
 for <alsa-devel@alsa-project.org>; Sat, 22 Feb 2014 18:29:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The codec->control_data contains a pointer to the device's regmap struct. But
wm8994_bulk_write() expects a pointer to the parent wm8998 device.

The issue was introduced in commit d9a7666f ("ASoC: Remove ASoC-specific
WM8994 I/O code").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8958-dsp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 1974377..7ac2e51 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -153,7 +153,7 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 
 			data32 &= 0xffffff;
 
-			wm8994_bulk_write(codec->control_data,
+			wm8994_bulk_write(wm8994->wm8994,
 					  data32 & 0xffffff,
 					  block_len / 2,
 					  (void *)(data + 8));
-- 
1.8.0
