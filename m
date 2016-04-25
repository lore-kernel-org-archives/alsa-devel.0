From: kernel@martin.sperl.org
Subject: [PATCH 2/3] ASoC: bcm2835: setup clock only if CPU is clock master
Date: Mon, 25 Apr 2016 13:39:39 +0000
Message-ID: <1461591580-7565-2-git-send-email-kernel@martin.sperl.org>
References: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Matthias Reichl <hias@horus.com>, Florian Meier <florian.meier@koalo.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: alsa-devel@alsa-project.org

From: Matthias Reichl <hias@horus.com>

We only need to enable the clock if we are a clock master.

Code ported from bcm2708-i2s driver in Raspberry Pi tree.
Original work by Zoltan Szenczi.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index d2663e7..a0026e2 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -276,8 +276,15 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 		/* otherwise calculate a fitting block ratio */
 		bclk_ratio = 2 * data_length;

-	/* set target clock rate*/
-	clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
+	/* Clock should only be set up here if CPU is clock master */
+	switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBS_CFM:
+		clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
+		break;
+	default:
+		break;
+	}

 	/* Setup the frame format */
 	format = BCM2835_I2S_CHEN;
--
2.1.4
