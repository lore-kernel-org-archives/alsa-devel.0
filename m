From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: [PATCH 1/2] spitz: MONO -> MONO1
Date: Mon, 11 Aug 2008 12:45:45 +0400
Message-ID: <1218444346-19153-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F5941037FE
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Aug 2008 10:46:59 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id u40so439732ugc.50
	for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2008 01:46:58 -0700 (PDT)
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
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/spitz.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 8f5c2ac..dff0f0e 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -303,7 +303,7 @@ static int spitz_wm8750_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_disable_pin(codec, "LINPUT3");
 	snd_soc_dapm_disable_pin(codec, "RINPUT3");
 	snd_soc_dapm_disable_pin(codec, "OUT3");
-	snd_soc_dapm_disable_pin(codec, "MONO");
+	snd_soc_dapm_disable_pin(codec, "MONO1");
 
 	/* Add spitz specific controls */
 	for (i = 0; i < ARRAY_SIZE(wm8750_spitz_controls); i++) {
-- 
1.5.6.3
