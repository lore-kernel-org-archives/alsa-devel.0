From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Register DSP1 Aux widgets
Date: Tue, 20 Nov 2012 13:15:21 +0000
Message-ID: <1353417321-4100-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1D7A26538C
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 14:27:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

It seems WM_ADSP2("DSP1", 0) is added twice to the widgets list, remove
that and in place use ARIZONA_DSP_WIDGETS(DSP1, "DSP1").

We need to make sure that the DSP1 Aux widgets are provided otherwise
we'll see errors such as "Failed to add route DSP1 Aux 1 -> DSP1" etc.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 54485d4..e2826bf 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1033,7 +1033,7 @@ SND_SOC_DAPM_AIF_IN("AIF3RX1", NULL, 0,
 SND_SOC_DAPM_AIF_IN("AIF3RX2", NULL, 0,
 		    ARIZONA_AIF3_RX_ENABLES, ARIZONA_AIF3RX2_ENA_SHIFT, 0),
 
-WM_ADSP2("DSP1", 0),
+ARIZONA_DSP_WIDGETS(DSP1, "DSP1"),
 
 SND_SOC_DAPM_VALUE_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
 		       ARIZONA_AEC_LOOPBACK_ENA, 0, &wm5102_aec_loopback_mux),
-- 
1.8.0
