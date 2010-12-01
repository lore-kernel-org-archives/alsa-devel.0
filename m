From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8731: Fix incorrect mask for bypass
	path disable
Date: Wed,  1 Dec 2010 09:38:55 +0000
Message-ID: <1291196335-7118-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E123F1039B9
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 10:39:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

According to the datasheet the bypass path enable/disable is
bit 3 therefore we need 0x8 and not 0x4.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index a104145..94e0cf3 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -526,7 +526,7 @@ static int wm8731_probe(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);
 
 	/* Disable bypass path by default */
-	snd_soc_update_bits(codec, WM8731_APANA, 0x4, 0);
+	snd_soc_update_bits(codec, WM8731_APANA, 0x8, 0);
 
 	snd_soc_add_controls(codec, wm8731_snd_controls,
 			     ARRAY_SIZE(wm8731_snd_controls));
-- 
1.7.3.2
