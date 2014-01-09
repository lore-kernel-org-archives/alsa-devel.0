From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/2] ASoC: wm5110: Add controls for
	headphone short circuit protection
Date: Thu,  9 Jan 2014 14:29:25 +0000
Message-ID: <1389277765-23914-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1389277765-23914-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 42FD1261AEC
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:37:35 +0100 (CET)
In-Reply-To: <1389277765-23914-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Add controls to enable/disable the headphone short circuit protection of
the headphone outputs.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 9add6c7..eb526e3 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -267,6 +267,13 @@ ARIZONA_MIXER_CONTROLS("SPKDAT1R", ARIZONA_OUT5RMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT2L", ARIZONA_OUT6LMIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SPKDAT2R", ARIZONA_OUT6RMIX_INPUT_1_SOURCE),
 
+SOC_SINGLE("HPOUT1 SC Protect Switch", ARIZONA_HP1_SHORT_CIRCUIT_CTRL,
+	   ARIZONA_HP1_SC_ENA_SHIFT, 1, 0),
+SOC_SINGLE("HPOUT2 SC Protect Switch", ARIZONA_HP2_SHORT_CIRCUIT_CTRL,
+	   ARIZONA_HP2_SC_ENA_SHIFT, 1, 0),
+SOC_SINGLE("HPOUT3 SC Protect Switch", ARIZONA_HP3_SHORT_CIRCUIT_CTRL,
+	   ARIZONA_HP3_SC_ENA_SHIFT, 1, 0),
+
 SOC_DOUBLE_R("HPOUT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE_R("HPOUT2 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
-- 
1.7.2.5
