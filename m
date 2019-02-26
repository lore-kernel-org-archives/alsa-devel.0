From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/7] ASoC: stm32: i2s: fix 16 bit format support
Date: Tue, 26 Feb 2019 14:51:05 +0100
Message-ID: <1551189070-15469-3-git-send-email-olivier.moysan@st.com>
References: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

I2S supports 16 bits data in 32 channel length.
However the expected driver behavior, is to
set channel length to 16 bits when data format is 16 bits.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 339cd4715b2e..7d4c67433916 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -501,7 +501,7 @@ static int stm32_i2s_configure(struct snd_soc_dai *cpu_dai,
 	switch (format) {
 	case 16:
 		cfgr = I2S_CGFR_DATLEN_SET(I2S_I2SMOD_DATLEN_16);
-		cfgr_mask = I2S_CGFR_DATLEN_MASK;
+		cfgr_mask = I2S_CGFR_DATLEN_MASK | I2S_CGFR_CHLEN;
 		break;
 	case 32:
 		cfgr = I2S_CGFR_DATLEN_SET(I2S_I2SMOD_DATLEN_32) |
-- 
2.7.4
