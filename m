From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][RFC 1/1] ASoC: OMAP: Add support for mono
	link configuration to McBSP DAI
Date: Mon, 24 Nov 2008 15:09:24 +0200
Message-ID: <1227532164-2612-2-git-send-email-jarkko.nikula@nokia.com>
References: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 476DB243E9
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 14:09:48 +0100 (CET)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mAOD933p003488
	for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2008 07:09:46 -0600
In-Reply-To: <1227532164-2612-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Patch adds support for mono audio link configuration to function
omap_mcbsp_dai_hw_params but doesn't expose it in omap_mcbsp_dai table by
default.

Main idea behind this is to allow operate with real mono codecs but not
break compatibility with existing codecs which can expose their channels_min
as 1. Machine driver can use functionality provided by this patch by
re-configuring runtime DAI's channels_min and channel_max to 1 for a link
having mono codec.

For mono link, the I2S signalling remains the same but only first frame
(left channel) is transmitting audio data and second frame is having a
null data. In DSP_A, only first frame is transmitted.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 2eeb135..bb05c76 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -203,7 +203,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
-	int wlen;
+	int wlen, channels;
 	unsigned long port;
 
 	if (cpu_class_is_omap1()) {
@@ -232,12 +232,17 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	switch (params_channels(params)) {
+	channels = params_channels(params);
+	switch (channels) {
 	case 2:
-		/* Set 1 word per (McBPSP) frame and use dual-phase frames */
-		regs->rcr2	|= RFRLEN2(1 - 1) | RPHASE;
+		/* Use dual-phase frames */
+		regs->rcr2	|= RPHASE;
+		regs->xcr2	|= XPHASE;
+	case 1:
+		/* Set 1 word per (McBSP) frame */
+		regs->rcr2	|= RFRLEN2(1 - 1);
 		regs->rcr1	|= RFRLEN1(1 - 1);
-		regs->xcr2	|= XFRLEN2(1 - 1) | XPHASE;
+		regs->xcr2	|= XFRLEN2(1 - 1);
 		regs->xcr1	|= XFRLEN1(1 - 1);
 		break;
 	default:
@@ -266,8 +271,8 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		regs->srgr1	|= FWID(wlen - 1);
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		regs->srgr2	|= FPER(wlen * 2 - 1);
-		regs->srgr1	|= FWID(wlen * 2 - 2);
+		regs->srgr2	|= FPER(wlen * channels - 1);
+		regs->srgr1	|= FWID(wlen * channels - 2);
 		break;
 	}
 
-- 
1.5.6.5
