From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: wm8995: Slightly optimize
	configure_clock
Date: Tue, 04 Oct 2011 20:08:04 +0800
Message-ID: <1317730084.17783.3.camel@phoenix>
References: <1317730023.17783.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6E2392461C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 14:08:11 +0200 (CEST)
Received: by ywn1 with SMTP id 1so450652ywn.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 05:08:10 -0700 (PDT)
In-Reply-To: <1317730023.17783.2.camel@phoenix>
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
No need to read WM8995_CLOCKING_1 register before calling snd_soc_update_bits().

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8995.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8995.c b/sound/soc/codecs/wm8995.c
index e05ee79..78eeb21 100644
--- a/sound/soc/codecs/wm8995.c
+++ b/sound/soc/codecs/wm8995.c
@@ -485,7 +485,7 @@ static int configure_aif_clock(struct snd_soc_codec *codec, int aif)
 static int configure_clock(struct snd_soc_codec *codec)
 {
 	struct wm8995_priv *wm8995;
-	int old, new;
+	int change, new;
 
 	wm8995 = snd_soc_codec_get_drvdata(codec);
 
@@ -509,15 +509,11 @@ static int configure_clock(struct snd_soc_codec *codec)
 	else
 		new = 0;
 
-	old = snd_soc_read(codec, WM8995_CLOCKING_1) & WM8995_SYSCLK_SRC;
-
-	/* If there's no change then we're done. */
-	if (old == new)
+	change = snd_soc_update_bits(codec, WM8995_CLOCKING_1,
+				     WM8995_SYSCLK_SRC_MASK, new);
+	if (!change)
 		return 0;
 
-	snd_soc_update_bits(codec, WM8995_CLOCKING_1,
-			    WM8995_SYSCLK_SRC_MASK, new);
-
 	snd_soc_dapm_sync(&codec->dapm);
 
 	return 0;
-- 
1.7.4.1
