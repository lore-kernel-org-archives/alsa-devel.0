From: Taylor Hutt <thutt@chromium.org>
Subject: [PATCH] Max98095: Move existing NULL check before pointer dereference.
Date: Tue, 17 May 2011 18:03:54 -0700
Message-ID: <1305680634-10484-1-git-send-email-thutt@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hsiang <peter.hsiang@maxim-ic.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Taylor Hutt <thutt@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Visual inspection shows that max98095_put_eq_enum() and
max98095_put_bq_enum() each have a possible NULL deref of 'pdata'.

This change moves the NULL check above the use.

BUG=none
TEST=Visual inspection
Change-Id: Ic53a7e38a958f39225ac4961bcfd3812a95ea1b5
Signed-off-by: Taylor Hutt <thutt@chromium.org>
---
 sound/soc/codecs/max98095.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index a6cc94e..e1d282d 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -1872,16 +1872,14 @@ static int max98095_put_eq_enum(struct snd_kcontrol *kcontrol,
 
 	BUG_ON(channel > 1);
 
-	cdata = &max98095->dai[channel];
+	if (!pdata || !max98095->eq_textcnt)
+		return 0;
 
 	if (sel >= pdata->eq_cfgcnt)
 		return -EINVAL;
 
+	cdata = &max98095->dai[channel];
 	cdata->eq_sel = sel;
-
-	if (!pdata || !max98095->eq_textcnt)
-		return 0;
-
 	fs = cdata->rate;
 
 	/* Find the selected configuration with nearest sample rate */
@@ -2020,16 +2018,14 @@ static int max98095_put_bq_enum(struct snd_kcontrol *kcontrol,
 
 	BUG_ON(channel > 1);
 
-	cdata = &max98095->dai[channel];
+	if (!pdata || !max98095->bq_textcnt)
+		return 0;
 
 	if (sel >= pdata->bq_cfgcnt)
 		return -EINVAL;
 
+	cdata = &max98095->dai[channel];
 	cdata->bq_sel = sel;
-
-	if (!pdata || !max98095->bq_textcnt)
-		return 0;
-
 	fs = cdata->rate;
 
 	/* Find the selected configuration with nearest sample rate */
-- 
1.7.3.1
