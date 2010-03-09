From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: SSM2602: add SND control for mic boost2
	and default it to off
Date: Tue,  9 Mar 2010 12:58:09 -0500
Message-ID: <1268157489-13412-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id C343C10381E
	for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2010 18:54:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
this is fine for 2.6.34 or 2.6.35

 sound/soc/codecs/ssm2602.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index d2ff1cd..942f5dc 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -139,6 +139,7 @@ SOC_DOUBLE_R("Capture Volume", SSM2602_LINVOL, SSM2602_RINVOL, 0, 31, 0),
 SOC_DOUBLE_R("Capture Switch", SSM2602_LINVOL, SSM2602_RINVOL, 7, 1, 1),
 
 SOC_SINGLE("Mic Boost (+20dB)", SSM2602_APANA, 0, 1, 0),
+SOC_SINGLE("Mic Boost2 (+20dB)", SSM2602_APANA, 7, 1, 0),
 SOC_SINGLE("Mic Switch", SSM2602_APANA, 1, 1, 1),
 
 SOC_SINGLE("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1),
@@ -604,8 +605,7 @@ static int ssm2602_init(struct snd_soc_device *socdev)
 	reg = ssm2602_read_reg_cache(codec, SSM2602_ROUT1V);
 	ssm2602_write(codec, SSM2602_ROUT1V, reg | ROUT1V_RLHP_BOTH);
 	/*select Line in as default input*/
-	ssm2602_write(codec, SSM2602_APANA,
-			APANA_ENABLE_MIC_BOOST2 | APANA_SELECT_DAC |
+	ssm2602_write(codec, SSM2602_APANA, APANA_SELECT_DAC |
 			APANA_ENABLE_MIC_BOOST);
 	ssm2602_write(codec, SSM2602_PWR, 0);
 
-- 
1.7.0.2
