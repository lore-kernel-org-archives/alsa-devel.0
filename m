From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 1/2] tosa: fix compilation with new DAPM API
Date: Tue, 8 Jul 2008 19:45:20 +0400
Message-ID: <20080708154520.GA6596@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id D44BF24436
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 17:45:30 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id u40so1159418ugc.50
	for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2008 08:45:30 -0700 (PDT)
Content-Disposition: inline
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
---
 sound/soc/pxa/tosa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index b59a8df..fe6cca9 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -151,7 +151,7 @@ SND_SOC_DAPM_SPK("Speaker", NULL),
 };
 
 /* tosa audio map */
-static const snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* headphone connected to HPOUTL, HPOUTR */
 	{"Headphone Jack", NULL, "HPOUTL"},
@@ -203,7 +203,7 @@ static int tosa_ac97_init(struct snd_soc_codec *codec)
 	}
 
 	/* add tosa specific widgets */
-	snd_soc_dapm_new_controls(codec, &tosa_dapm_widgets,
+	snd_soc_dapm_new_controls(codec, tosa_dapm_widgets,
 				  ARRAY_SIZE(tosa_dapm_widgets));
 
 	/* set up tosa specific audio path audio_map */
-- 
1.5.6


-- 
With best wishes
Dmitry
