From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Correct AEC loopback enable
	definition
Date: Tue, 26 Feb 2013 17:15:32 +0000
Message-ID: <1361898934-615-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2601265324
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 18:15:40 +0100 (CET)
In-Reply-To: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 47ce8de..ff9f133 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -503,7 +503,8 @@ SND_SOC_DAPM_PGA("ASRC2R", ARIZONA_ASRC_ENABLE, ARIZONA_ASRC2R_ENA_SHIFT, 0,
 		 NULL, 0),
 
 SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA, 0, &wm5110_aec_loopback_mux),
+		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
+		       &wm5110_aec_loopback_mux),
 
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", NULL, 0,
 		     ARIZONA_AIF1_TX_ENABLES, ARIZONA_AIF1TX1_ENA_SHIFT, 0),
-- 
1.7.10.4
