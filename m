From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] ASoC: davinci-mcasp: set up channel status
	bits for S/PDIF mode
Date: Thu, 27 Mar 2014 10:49:04 +0100
Message-ID: <1395913744-29720-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 981A1261717
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 10:49:17 +0100 (CET)
Received: by mail-ee0-f50.google.com with SMTP id c13so2591043eek.23
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 02:49:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

In DIT (S/PDIF) mode, program the transmitted user bits to reflect the
configured sample rate, along with some other details.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
Thanks to Peter for the review and bearing with my confusion :)

 sound/soc/davinci/davinci-mcasp.c | 49 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 375e197..1fbded0 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -27,6 +27,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
 
+#include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -576,8 +577,12 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream)
 }
 
 /* S/PDIF */
-static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
+static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp,
+			      unsigned int rate)
 {
+	u32 val = 0;
+	u8 *bytes = (u8*) &val;
+
 	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
 	   and LSB first */
 	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXFMT_REG, TXROT(6) | TXSSZ(15));
@@ -599,6 +604,46 @@ static int mcasp_dit_hw_param(struct davinci_mcasp *mcasp)
 	/* Enable the DIT */
 	mcasp_set_bits(mcasp, DAVINCI_MCASP_TXDITCTL_REG, DITEN);
 
+	/* Set S/PDIF channel status bits */
+	bytes[0] = IEC958_AES0_CON_NOT_COPYRIGHT;
+	bytes[1] = IEC958_AES1_CON_PCM_CODER;
+
+	switch (rate) {
+	case 22050:
+		bytes[3] |= IEC958_AES3_CON_FS_22050;
+		break;
+	case 24000:
+		bytes[3] |= IEC958_AES3_CON_FS_24000;
+		break;
+	case 32000:
+		bytes[3] |= IEC958_AES3_CON_FS_32000;
+		break;
+	case 44100:
+		bytes[3] |= IEC958_AES3_CON_FS_44100;
+		break;
+	case 48000:
+		bytes[3] |= IEC958_AES3_CON_FS_48000;
+		break;
+	case 88200:
+		bytes[3] |= IEC958_AES3_CON_FS_88200;
+		break;
+	case 96000:
+		bytes[3] |= IEC958_AES3_CON_FS_96000;
+		break;
+	case 176400:
+		bytes[3] |= IEC958_AES3_CON_FS_176400;
+		break;
+	case 192000:
+		bytes[3] |= IEC958_AES3_CON_FS_192000;
+		break;
+	default:
+		printk(KERN_WARNING "unsupported sampling rate: %d\n", rate);
+		return -EINVAL;
+	}
+
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRA_REG, val);
+	mcasp_set_reg(mcasp, DAVINCI_MCASP_DITCSRB_REG, val);
+
 	return 0;
 }
 
@@ -634,7 +679,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	if (mcasp->op_mode == DAVINCI_MCASP_DIT_MODE)
-		ret = mcasp_dit_hw_param(mcasp);
+		ret = mcasp_dit_hw_param(mcasp, params_rate(params));
 	else
 		ret = mcasp_i2s_hw_param(mcasp, substream->stream);
 
-- 
1.8.5.3
