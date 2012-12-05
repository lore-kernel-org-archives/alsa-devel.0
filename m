From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Add LHPF coefficient
	configuration
Date: Wed,  5 Dec 2012 16:38:59 +0900
Message-ID: <1354693139-3845-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1354693139-3845-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB0092650AE
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 09:21:05 +0100 (CET)
In-Reply-To: <1354693139-3845-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index fe54596..ed093ee 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -160,6 +160,11 @@ ARIZONA_MIXER_CONTROLS("LHPF2", ARIZONA_HPLP2MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF3", ARIZONA_HPLP3MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("LHPF4", ARIZONA_HPLP4MIX_INPUT_1_SOURCE),
 
+SND_SOC_BYTES("LHPF1 Coefficients", ARIZONA_HPLPF1_2, 1),
+SND_SOC_BYTES("LHPF2 Coefficients", ARIZONA_HPLPF2_2, 1),
+SND_SOC_BYTES("LHPF3 Coefficients", ARIZONA_HPLPF3_2, 1),
+SND_SOC_BYTES("LHPF4 Coefficients", ARIZONA_HPLPF4_2, 1),
+
 SOC_ENUM("LHPF1 Mode", arizona_lhpf1_mode),
 SOC_ENUM("LHPF2 Mode", arizona_lhpf2_mode),
 SOC_ENUM("LHPF3 Mode", arizona_lhpf3_mode),
-- 
1.7.10.4
