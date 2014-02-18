From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 092/102] ASoC: uad1380: Use
	SOC_ENUM_SINGLE_CONST()
Date: Tue, 18 Feb 2014 12:51:38 +0100
Message-ID: <1392724308-13375-12-git-send-email-tiwai@suse.de>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 50D51265766
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
 sound/soc/codecs/uda1380.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 72ee8e1838e5..9f112c41325e 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -237,10 +237,8 @@ static const char *uda1380_os_setting[] = {
 };
 
 static const struct soc_enum uda1380_deemp_enum[] = {
-	SOC_ENUM_SINGLE(UDA1380_DEEMP, 8, ARRAY_SIZE(uda1380_deemp),
-			uda1380_deemp),
-	SOC_ENUM_SINGLE(UDA1380_DEEMP, 0, ARRAY_SIZE(uda1380_deemp),
-			uda1380_deemp),
+	SOC_ENUM_SINGLE_CONST(UDA1380_DEEMP, 8, uda1380_deemp),
+	SOC_ENUM_SINGLE_CONST(UDA1380_DEEMP, 0, uda1380_deemp),
 };
 static SOC_ENUM_SINGLE_DECL(uda1380_input_sel_enum,
 			    UDA1380_ADC, 2, uda1380_input_sel);		/* SEL_MIC, SEL_LNA */
-- 
1.8.5.2
