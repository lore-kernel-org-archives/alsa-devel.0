From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm5102: Correct AEC loopback enable
	definiton
Date: Tue, 26 Feb 2013 17:15:30 +0000
Message-ID: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D4B62650F1
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 18:15:40 +0100 (CET)
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

Reported-by: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index c1ea75c..efd7317 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1083,7 +1083,8 @@ SND_SOC_DAPM_AIF_IN("AIF3RX2", NULL, 0,
 ARIZONA_DSP_WIDGETS(DSP1, "DSP1"),
 
 SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA, 0, &wm5102_aec_loopback_mux),
+		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
+		       &wm5102_aec_loopback_mux),
 
 SND_SOC_DAPM_PGA_E("OUT1L", SND_SOC_NOPM,
 		   ARIZONA_OUT1L_ENA_SHIFT, 0, NULL, 0, arizona_hp_ev,
-- 
1.7.10.4
