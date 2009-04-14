From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/14] ASoC: pxa-ssp.c fix clock/frame invert
Date: Tue, 14 Apr 2009 13:33:12 +0100
Message-ID: <1239712393-6428-14-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1BC624156
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:17 +0200 (CEST)
In-Reply-To: <20090414123220.GA6342@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Daniel Ribeiro <drwyrm@gmail.com>

SCMODE(0): Data Driven (Falling), Data Sampled (Rising), Idle State (Low)
SCMODE(1): Data Driven (Rising), Data Sampled (Falling), Idle State (Low)
SCMODE(2): Data Driven (Rising), Data Sampled (Falling), Idle State (High)
SCMODE(3): Data Driven (Falling), Data Sampled (Rising), Idle State (High)

SCMODE(3) does not invert the clock polarity compared to the default SCMODE(0).

This patch also adds all possible NF/IF, NB/IB combinations to the DSP_A and
DSP_B modes.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa-ssp.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c7c1996..176af7f 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -568,7 +568,10 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		case SND_SOC_DAIFMT_NB_IF:
 			break;
 		case SND_SOC_DAIFMT_IB_IF:
-			sspsp |= SSPSP_SCMODE(3);
+			sspsp |= SSPSP_SCMODE(2);
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			sspsp |= SSPSP_SCMODE(2) | SSPSP_SFRMP;
 			break;
 		default:
 			return -EINVAL;
@@ -585,7 +588,13 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		case SND_SOC_DAIFMT_NB_NF:
 			sspsp |= SSPSP_SFRMP;
 			break;
+		case SND_SOC_DAIFMT_NB_IF:
+			break;
 		case SND_SOC_DAIFMT_IB_IF:
+			sspsp |= SSPSP_SCMODE(2);
+			break;
+		case SND_SOC_DAIFMT_IB_NF:
+			sspsp |= SSPSP_SCMODE(2) | SSPSP_SFRMP;
 			break;
 		default:
 			return -EINVAL;
-- 
1.6.2.2
