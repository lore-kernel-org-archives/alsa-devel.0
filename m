From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH] ASoC: pxa-ssp.c fix clock/frame invert
Date: Wed, 08 Apr 2009 10:51:24 -0300
Message-ID: <1239198684.20192.8.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 81CBB1037EB
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 15:52:53 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 5so79025ywr.2
	for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2009 06:52:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: openezx-devel <openezx-devel@lists.openezx.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

>From the pxa27x developers manual, Table 8-8 SSPSP Bit Definitions:

SCMODE(0): Data Driven (Falling), Data Sampled (Rising), Idle State (Low)
SCMODE(1): Data Driven (Rising), Data Sampled (Falling), Idle State (Low)
SCMODE(2): Data Driven (Rising), Data Sampled (Falling), Idle State (High)
SCMODE(3): Data Driven (Falling), Data Sampled (Rising), Idle State (High)

SCMODE(3) does not invert the clock polarity compared to the default SCMODE(0).

This patch also adds all possible NF/IF, NB/IB combinations to the DSP_A and
DSP_B modes.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 sound/soc/pxa/pxa-ssp.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 308a657..6768e4e 100644
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
tg: (577c9c4..) asoc/pxa-ssp-invert-clock.patch (depends on: master)
total: 0 errors, 0 warnings, 24 lines checked

asoc-pxa-ssp-invert-clock.patch has no obvious style problems and is ready for submission.
