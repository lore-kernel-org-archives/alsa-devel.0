From: Caleb Crome <caleb@crome.org>
Subject: [PATCH v2 1/1] ASoC: fsl_ssi: add CCSR_SSI_SOR to volatile register list
Date: Mon, 25 Apr 2016 11:36:18 -0700
Message-ID: <1461609378-467-1-git-send-email-caleb@crome.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Caleb Crome <caleb@crome.org>
List-Id: alsa-devel@alsa-project.org

The CCSR_SSI_SOR is a register that clears the TX and/or the RX fifo
on the i.MX SSI port.  The fsl_ssi_trigger writes this register in
order to clear the fifo at trigger time.

However, since the CCSR_SSI_SOR register is not in the volatile list,
the caching mechanism prevented the register write in the trigger
function.  This caused the fifo to not be cleared (because the value
was unchanged from the last time the register was written), and thus
causes the channels in both TDM or simple I2S mode to slip and be in
the wrong time slots on SSI restart.

This has gone unnoticed for so long because with simple stereo mode,
the consequence is that left and right are swapped, which isn't that
noticeable.  However, it's catestrophic in some systems that
require the channels to be in the right slots.

Signed-off-by: Caleb Crome <caleb@crome.org>
Suggested-by: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

---
 sound/soc/fsl/fsl_ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 216e3cb..2f3bf9c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -151,6 +151,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	case CCSR_SSI_SACDAT:
 	case CCSR_SSI_SATAG:
 	case CCSR_SSI_SACCST:
+	case CCSR_SSI_SOR:
 		return true;
 	default:
 		return false;
-- 
1.9.1
