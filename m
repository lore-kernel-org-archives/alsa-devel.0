From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: i2s: skip useless write in slave mode" to the
 asoc tree
Date: Tue, 26 Feb 2019 16:22:23 +0000 (GMT)
Message-ID: <20190226162223.0EDC21121A0A@debutante.sirena.org.uk>
References: <1551189070-15469-8-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551189070-15469-8-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, perex@perex.cz, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: i2s: skip useless write in slave mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7b6b0049e2b70d103adf1b7d0320802f70ddceca Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Tue, 26 Feb 2019 14:51:10 +0100
Subject: [PATCH] ASoC: stm32: i2s: skip useless write in slave mode

Dummy write in capture master mode is used to gate
bus clocks. This write is useless in slave mode
as the clocks are not managed by slave.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
