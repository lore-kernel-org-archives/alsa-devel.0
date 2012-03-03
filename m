From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Suppres noop updates of FLL K
Date: Sat,  3 Mar 2012 15:33:54 +0000
Message-ID: <1330788834-18634-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB27E245A8
	for <alsa-devel@alsa-project.org>; Sat,  3 Mar 2012 16:33:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Using snd_soc_write() means we always write to the register even if it
already contains the newly calculated value.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 3009541..6d351b9 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -1920,7 +1920,8 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 			    WM8994_FLL1_OUTDIV_MASK |
 			    WM8994_FLL1_FRATIO_MASK, reg);
 
-	snd_soc_write(codec, WM8994_FLL1_CONTROL_3 + reg_offset, fll.k);
+	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_3 + reg_offset,
+			    WM8994_FLL1_K_MASK, fll.k);
 
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_4 + reg_offset,
 			    WM8994_FLL1_N_MASK,
-- 
1.7.9.1
