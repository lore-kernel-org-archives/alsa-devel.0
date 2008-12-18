From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 7/8] ALSA: ASoC: DaVinci: document I2S
	limitations
Date: Thu, 18 Dec 2008 12:36:45 -0700
Message-ID: <1229629006-4261-8-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-5-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-6-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-7-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id CA929244C3
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:36:59 +0100 (CET)
In-Reply-To: <1229629006-4261-7-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

DaVinci does not support true I2S or right justified
mode so not all I2S codecs will work with it when the codec is
master. Document this limitation.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index c425c86..735ec86 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -241,9 +241,26 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	rcr = DAVINCI_MCBSP_RCR_RFRLEN1(1);
 	xcr = DAVINCI_MCBSP_XCR_XFIG | DAVINCI_MCBSP_XCR_XFRLEN1(1);
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_DSP_A:
 		break;
 	case SND_SOC_DAIFMT_I2S:
+		/* Davinci doesn't support TRUE I2S, but some codecs will have
+		 * the left and right channels contiguous. This allows
+		 * dsp_b mode to be used with an inverted normal frame clk.
+		 * If your codec is master and does not have contiguous
+		 * channels, then you will have sound on only one channel.
+		 * Try using a different mode, or codec as slave.
+		 *
+		 * The TLV320AIC33 is an example of a codec where this works.
+		 * It has a variable bit clock frequency allowing it to have
+		 * valid data on every bit clock.
+		 *
+		 * The TLV320AIC23 is an example of a codec where this does not
+		 * work. It has a fixed bit clock frequency with progressively
+		 * more empty bit clock slots between channels as the sample
+		 * rate is lowered.
+		 */
+		fmt ^= SND_SOC_DAIFMT_NB_IF;
 	case SND_SOC_DAIFMT_DSP_B:
 		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
-- 
1.5.4.3
