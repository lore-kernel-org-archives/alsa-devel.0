From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 076/102] ASoC: ad1836: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:32 +0100
Message-ID: <1392723517-12772-49-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BA1212655E8
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ad1836.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 77f459868579..685998dd086e 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -40,8 +40,8 @@ struct ad1836_priv {
  */
 static const char *ad1836_deemp[] = {"None", "44.1kHz", "32kHz", "48kHz"};
 
-static const struct soc_enum ad1836_deemp_enum =
-	SOC_ENUM_SINGLE(AD1836_DAC_CTRL1, 8, 4, ad1836_deemp);
+static SOC_ENUM_SINGLE_DECL(ad1836_deemp_enum,
+			    AD1836_DAC_CTRL1, 8, ad1836_deemp);
 
 #define AD1836_DAC_VOLUME(x) \
 	SOC_DOUBLE_R("DAC" #x " Playback Volume", AD1836_DAC_L_VOL(x), \
-- 
1.8.5.2
