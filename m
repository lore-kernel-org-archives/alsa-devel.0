From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 3/3] ad193x: fix typo, delete redundant space
Date: Wed, 21 Apr 2010 17:36:49 +0800
Message-ID: <1271842609-18276-4-git-send-email-21cnbao@gmail.com>
References: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-2-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 23D10103835
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 11:38:15 +0200 (CEST)
In-Reply-To: <1271842609-18276-3-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad193x.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index e79788c..d4089b8 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -46,13 +46,13 @@ static const struct soc_enum ad193x_deemp_enum =
 
 static const struct snd_kcontrol_new ad193x_snd_controls[] = {
 	/* DAC volume control */
-	SOC_DOUBLE_R("DAC1  Volume", AD193X_DAC_L1_VOL,
+	SOC_DOUBLE_R("DAC1 Volume", AD193X_DAC_L1_VOL,
 			AD193X_DAC_R1_VOL, 0, 0xFF, 1),
-	SOC_DOUBLE_R("DAC2  Volume", AD193X_DAC_L2_VOL,
+	SOC_DOUBLE_R("DAC2 Volume", AD193X_DAC_L2_VOL,
 			AD193X_DAC_R2_VOL, 0, 0xFF, 1),
-	SOC_DOUBLE_R("DAC3  Volume", AD193X_DAC_L3_VOL,
+	SOC_DOUBLE_R("DAC3 Volume", AD193X_DAC_L3_VOL,
 			AD193X_DAC_R3_VOL, 0, 0xFF, 1),
-	SOC_DOUBLE_R("DAC4  Volume", AD193X_DAC_L4_VOL,
+	SOC_DOUBLE_R("DAC4 Volume", AD193X_DAC_L4_VOL,
 			AD193X_DAC_R4_VOL, 0, 0xFF, 1),
 
 	/* ADC switch control */
-- 
1.5.6.3
