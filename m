From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 7/7] ASoC: stm32: i2s: skip useless write in slave mode
Date: Tue, 26 Feb 2019 14:51:10 +0100
Message-ID: <1551189070-15469-8-git-send-email-olivier.moysan@st.com>
References: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Dummy write in capture master mode is used to gate
bus clocks. This write is useless in slave mode
as the clocks are not managed by slave.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 42ce87a35104..47c334de6b09 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -623,8 +623,8 @@ static int stm32_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 		} else {
 			ier = I2S_IER_OVRIE;
 
-			if (i2s->refcount == 1)
-				/* dummy write to trigger capture */
+			if (STM32_I2S_IS_MASTER(i2s) && i2s->refcount == 1)
+				/* dummy write to gate bus clocks */
 				regmap_write(i2s->regmap,
 					     STM32_I2S_TXDR_REG, 0);
 		}
-- 
2.7.4
