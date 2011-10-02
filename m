From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix setting update bits for WM8753_LADC
 and WM8753_RADC
Date: Sun, 02 Oct 2011 20:41:04 +0800
Message-ID: <1317559264.21926.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id CE2A8244D6
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Oct 2011 14:41:16 +0200 (CEST)
Received: by pzd13 with SMTP id 13so9313319pzd.2
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 05:41:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Current code set update bits for WM8753_LDAC and WM8753_RDAC twice,
but missed setting update bits for WM8753_LADC and WM8753_RADC.

I think it is a copy-paste bug in commit 776065
"ASoC: codecs: wm8753: Fix register cache incoherency".

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8753.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index fe04a10..a950471 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1455,8 +1455,8 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	/* set the update bits */
 	snd_soc_update_bits(codec, WM8753_LDAC, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8753_RDAC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_LDAC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8753_RDAC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8753_LADC, 0x0100, 0x0100);
+	snd_soc_update_bits(codec, WM8753_RADC, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8753_LOUT1V, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8753_ROUT1V, 0x0100, 0x0100);
 	snd_soc_update_bits(codec, WM8753_LOUT2V, 0x0100, 0x0100);
-- 
1.7.4.1
