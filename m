From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 023/102] ASoC: wm8770: Fix wrong number of enum
	items
Date: Tue, 18 Feb 2014 12:36:58 +0100
Message-ID: <1392723422-12689-8-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 54DF0265589
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
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

wm8770 codec driver defines ain_enum with a wrong number of items.

Use SOC_ENUM_DOUBLE_DECL() macro and it's automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8770.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8770.c b/sound/soc/codecs/wm8770.c
index 89a18d82f303..5bce21013485 100644
--- a/sound/soc/codecs/wm8770.c
+++ b/sound/soc/codecs/wm8770.c
@@ -196,8 +196,8 @@ static const char *ain_text[] = {
 	"AIN5", "AIN6", "AIN7", "AIN8"
 };
 
-static const struct soc_enum ain_enum =
-	SOC_ENUM_DOUBLE(WM8770_ADCMUX, 0, 4, 8, ain_text);
+static SOC_ENUM_DOUBLE_DECL(ain_enum,
+			    WM8770_ADCMUX, 0, 4, ain_text);
 
 static const struct snd_kcontrol_new ain_mux =
 	SOC_DAPM_ENUM("Capture Mux", ain_enum);
-- 
1.8.5.2
