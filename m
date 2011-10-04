From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: wm8994: Slightly optimize
	configure_clock
Date: Tue, 04 Oct 2011 20:07:03 +0800
Message-ID: <1317730023.17783.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5AA582461C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 14:07:15 +0200 (CEST)
Received: by ywn1 with SMTP id 1so449814ywn.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 05:07:13 -0700 (PDT)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

snd_soc_update_bits() will only write new register value
if the old value is different from the new value.
In additional, snd_soc_update_bits() returns 0 for no change.
No need to read WM8994_CLOCKING_1 register before calling snd_soc_update_bits().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8994.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e537267..4225e1f 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -208,7 +208,7 @@ static int configure_aif_clock(struct snd_soc_codec *codec, int aif)
 static int configure_clock(struct snd_soc_codec *codec)
 {
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
-	int old, new;
+	int change, new;
 
 	/* Bring up the AIF clocks first */
 	configure_aif_clock(codec, 0);
@@ -229,14 +229,11 @@ static int configure_clock(struct snd_soc_codec *codec)
 	else
 		new = 0;
 
-	old = snd_soc_read(codec, WM8994_CLOCKING_1) & WM8994_SYSCLK_SRC;
-
-	/* If there's no change then we're done. */
-	if (old == new)
+	change = snd_soc_update_bits(codec, WM8994_CLOCKING_1,
+				     WM8994_SYSCLK_SRC, new);
+	if (!change)
 		return 0;
 
-	snd_soc_update_bits(codec, WM8994_CLOCKING_1, WM8994_SYSCLK_SRC, new);
-
 	snd_soc_dapm_sync(&codec->dapm);
 
 	return 0;
-- 
1.7.4.1
