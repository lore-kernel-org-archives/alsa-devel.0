From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH] ASoC: fsl_ssi: Fixing invalid fmt
	SND_SOC_DAIFMT_AC97 test
Date: Fri,  5 Jun 2015 15:43:14 +0200
Message-ID: <1433511794-29284-1-git-send-email-arnaud.mouiche@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 51BBD2667CE
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 15:43:24 +0200 (CEST)
Received: by wgbgq6 with SMTP id gq6so57238923wgb.3
 for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2015 06:43:24 -0700 (PDT)
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
Cc: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_DAIFMT_AC97 (6) has similar bits than SND_SOC_DAIFMT_DSP_A (4)
and can't be tested with a simple AND operation

Signed-off-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
---
 sound/soc/fsl/fsl_ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6b0c8f7..c25a1e8 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -249,7 +249,8 @@ MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
 
 static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 {
-	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
+	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
+		SND_SOC_DAIFMT_AC97;
 }
 
 static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
@@ -945,7 +946,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 				CCSR_SSI_SCR_TCH_EN);
 	}
 
-	if (fmt & SND_SOC_DAIFMT_AC97)
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi_private);
 
 	return 0;
-- 
1.9.1
