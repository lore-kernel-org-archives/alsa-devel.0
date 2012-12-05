From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 3/3] ALSA: ASoC: McASP: implement a way to
	force BCLK/LRCLK ratios
Date: Wed,  5 Dec 2012 18:20:38 +0100
Message-ID: <1354728038-5506-3-git-send-email-zonque@gmail.com>
References: <1354728038-5506-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id E963B2650D4
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 18:20:49 +0100 (CET)
In-Reply-To: <1354728038-5506-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mporter@ti.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, vaibhav.bedia@ti.com, Daniel Mack <zonque@gmail.com>, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

Depending on the Codec, the the BCLK/LRCLK ratio might not be freely
chosen by the CPU DAI.

For example, some Codec might want to be supplied with 32-bit samples
for both its channels regardless of the actual audio word size the CPU
sends. In such cases, the rest of the bits on the data lines must be
padded with zeros:

          _______________________________
LRCLK    /                               \
      --'                                 `---------- .....

BCLK  ||||||||||||||||||||||||||||||||||||||||||||||| .....

DATA  ____||||||||||||||||_________________|||||||||| .....

          |<--  data  -->|<--   pads  --> |

This patch adds a new clock divider to configure the BCLK/LRCLK ratio.
If the machine code uses that divider, the driver uses the specified
value, instead of deriving that information from the audio word size.

Otherwise, the original behaviour is retained.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/davinci/davinci-mcasp.c | 15 +++++++++++++++
 sound/soc/davinci/davinci-mcasp.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index d940e01..e0c252a 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -593,6 +593,10 @@ static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div
 			       ACLKRDIV(div - 1), ACLKRDIV_MASK);
 		break;
 
+	case 2:		/* BCLK/LRCLK ratio */
+		dev->bclk_lrclk_ratio = div;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -625,6 +629,17 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 	u32 rotate = (32 - word_length) / 4;
 	u32 mask = (1ULL << word_length) - 1;
 
+	/*
+	 * if s BCLK-to-LRCLK ratio has been configured via the set_clkdiv()
+	 * callback, take it into account here. That allows us to for example
+	 * send 32 bits per channel to the codec, while only 16 of them carry
+	 * audio payload.
+	 * The clock ratio is given for a full period of data (both left and
+	 * right channels), so it has to be divided by 2.
+	 */
+	if (dev->bclk_lrclk_ratio)
+		word_length = dev->bclk_lrclk_ratio / 2;
+
 	/* mapping of the XSSZ bit-field as described in the datasheet */
 	fmt = (word_length >> 1) - 1;
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index d2449a8..0edd3b5 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -38,6 +38,7 @@ struct davinci_audio_dev {
 	u8	num_serializer;
 	u8	*serial_dir;
 	u8	version;
+	u8	bclk_lrclk_ratio;
 
 	/* McASP FIFO related */
 	u8	txnumevt;
-- 
1.7.11.7
