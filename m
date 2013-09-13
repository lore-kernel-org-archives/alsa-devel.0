From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] ASoC: fsl_ssi: Staticize local symbols
Date: Fri, 13 Sep 2013 15:22:17 +0530
Message-ID: <1379065938-26728-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F1582608B7
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:10:29 +0200 (CEST)
Received: by mail-pa0-f51.google.com with SMTP id lf1so2331871pab.24
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:10:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, bardliao@realtek.com, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

Local symbols used only in this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c6b7439..4973be7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -748,7 +748,7 @@ static void fsl_ssi_ac97_init(void)
 	fsl_ssi_setup(fsl_ac97_data);
 }
 
-void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
+static void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 		unsigned short val)
 {
 	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
@@ -770,7 +770,7 @@ void fsl_ssi_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	udelay(100);
 }
 
-unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
+static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
 		unsigned short reg)
 {
 	struct ccsr_ssi *ssi = fsl_ac97_data->ssi;
-- 
1.7.9.5
