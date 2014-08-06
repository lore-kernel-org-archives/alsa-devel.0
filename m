From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 1/9] ASoC: mcasp: Fix implicit BLCK divider
	setting
Date: Wed, 6 Aug 2014 16:52:38 +0300
Message-ID: <5e5987c830439e39d26a44580ebe01de631c10cc.1407332062.git.jsarha__33542.5948877402$1407333237$gmane$org@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FBAD260815
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:52:51 +0200 (CEST)
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
 by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76DqoLb029189
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:50 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
 by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dqo1S003413
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76Dqmkn006158	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:49 -0500
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
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
List-Id: alsa-devel@alsa-project.org

The implicit BLCK divider setting was broken by "ASoC: mcasp: don't
override bclk divider if it was provided by the machine"-patch. After
the BCLK divider is implicitly set for the first time the
mcasp->bclk_div gets a non zero value and the implicit setting is
"turned off".

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index c28508d..6a6b2ff 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -403,7 +403,8 @@ out:
 	return ret;
 }
 
-static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+static int __davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
+				      int div, bool explicit)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
@@ -420,7 +421,8 @@ static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div
 			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG,
 			       ACLKRDIV(div - 1), ACLKRDIV_MASK);
-		mcasp->bclk_div = div;
+		if (explicit)
+			mcasp->bclk_div = div;
 		break;
 
 	case 2:		/* BCLK/LRCLK ratio */
@@ -434,6 +436,12 @@ static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div
 	return 0;
 }
 
+static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id,
+				    int div)
+{
+	return __davinci_mcasp_set_clkdiv(dai, div_id, div, 1);
+}
+
 static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 				    unsigned int freq, int dir)
 {
@@ -738,7 +746,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 				 "Inaccurate BCLK: %u Hz / %u != %u Hz\n",
 				 mcasp->sysclk_freq, div, bclk_freq);
 		}
-		davinci_mcasp_set_clkdiv(cpu_dai, 1, div);
+		__davinci_mcasp_set_clkdiv(cpu_dai, 1, div, 0);
 	}
 
 	ret = mcasp_common_hw_param(mcasp, substream->stream,
-- 
1.7.9.5
