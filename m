From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 091/102] ASoC: uad134x: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:37 +0100
Message-ID: <1392724308-13375-11-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 63BB426576B
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:51:52 +0100 (CET)
In-Reply-To: <1392724308-13375-1-git-send-email-tiwai@suse.de>
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

... for improving readability and maintainability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/uda134x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index c94d4c1e3dac..cce7adf35531 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -362,9 +362,9 @@ static const char *uda134x_mixmode[] = {"Differential", "Analog1",
 					"Analog2", "Both"};
 
 static const struct soc_enum uda134x_mixer_enum[] = {
-SOC_ENUM_SINGLE(UDA134X_DATA010, 0, 0x04, uda134x_dsp_setting),
-SOC_ENUM_SINGLE(UDA134X_DATA010, 3, 0x04, uda134x_deemph),
-SOC_ENUM_SINGLE(UDA134X_EA010, 0, 0x04, uda134x_mixmode),
+SOC_ENUM_SINGLE_CONST(UDA134X_DATA010, 0, uda134x_dsp_setting),
+SOC_ENUM_SINGLE_CONST(UDA134X_DATA010, 3, uda134x_deemph),
+SOC_ENUM_SINGLE_CONST(UDA134X_EA010, 0, uda134x_mixmode),
 };
 
 static const struct snd_kcontrol_new uda1341_snd_controls[] = {
-- 
1.8.5.2
