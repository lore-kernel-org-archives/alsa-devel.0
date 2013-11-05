From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/31] ASoC: max98088: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:39:49 +0100
Message-ID: <1383673218-18405-3-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C4C3E261ABC
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:41 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
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

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/max98088.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 66ceee22fdad..53d7dab4e054 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -568,8 +568,9 @@ static void m98088_eq_band(struct snd_soc_codec *codec, unsigned int dai,
        unsigned int eq_reg;
        unsigned int i;
 
-       BUG_ON(band > 4);
-       BUG_ON(dai > 1);
+	if (WARN_ON(band > 4) ||
+	    WARN_ON(dai > 1))
+		return;
 
        /* Load the base register address */
        eq_reg = dai ? M98088_REG_84_DAI2_EQ_BASE : M98088_REG_52_DAI1_EQ_BASE;
@@ -909,7 +910,8 @@ static int max98088_line_pga(struct snd_soc_dapm_widget *w,
        struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
        u8 *state;
 
-       BUG_ON(!((channel == 1) || (channel == 2)));
+	if (WARN_ON(!(channel == 1 || channel == 2)))
+		return -EINVAL;
 
        switch (line) {
        case LINE_INA:
-- 
1.8.4.2
