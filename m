From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH 24/26] ASoC: wm8994: Don't test for NULL before
 release_firmware()
Date: Mon, 9 Apr 2012 22:52:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204092243450.14420@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1204092157340.13925@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id 7D7572456C
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Apr 2012 22:52:19 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1204092157340.13925@swampdragon.chaosbits.net>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, trivial@kernel.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

release_firmware() does its own NULL ptr testing, it's redundant to
also test before calling it.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/soc/codecs/wm8994.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 7c49642..cf7e5d2 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3972,7 +3972,7 @@ err_irq:
 	return ret;
 }
 
-static int  wm8994_codec_remove(struct snd_soc_codec *codec)
+static int wm8994_codec_remove(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
@@ -4013,14 +4013,10 @@ static int  wm8994_codec_remove(struct snd_soc_codec *codec)
 			free_irq(wm8994->micdet_irq, wm8994);
 		break;
 	}
-	if (wm8994->mbc)
-		release_firmware(wm8994->mbc);
-	if (wm8994->mbc_vss)
-		release_firmware(wm8994->mbc_vss);
-	if (wm8994->enh_eq)
-		release_firmware(wm8994->enh_eq);
+	release_firmware(wm8994->mbc);
+	release_firmware(wm8994->mbc_vss);
+	release_firmware(wm8994->enh_eq);
 	kfree(wm8994->retune_mobile_texts);
-
 	return 0;
 }
 
-- 
1.7.10


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
