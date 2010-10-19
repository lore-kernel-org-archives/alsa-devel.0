From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 01/25] ASoC: WM8580: Remove useless assignment
Date: Tue, 19 Oct 2010 16:04:21 +0900
Message-ID: <1287471861-23724-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 02B0910392B
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:35 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

The variable is not used anyway.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/codecs/wm8580.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index ad5987e..a2e0ed5 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -548,11 +548,9 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 				      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	unsigned int aifa;
 	unsigned int aifb;
 	int can_invert_lrclk;
-	int sysclk;
 
 	aifa = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->driver->id);
 	aifb = snd_soc_read(codec, WM8580_PAIF3 + codec_dai->driver->id);
@@ -621,8 +619,6 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	sysclk = wm8580->sysclk[codec_dai->driver->id];
-
 	snd_soc_write(codec, WM8580_PAIF1 + codec_dai->driver->id, aifa);
 	snd_soc_write(codec, WM8580_PAIF3 + codec_dai->driver->id, aifb);
 
-- 
1.6.2.5
