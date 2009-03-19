From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 3/3] ASoC: pxa-ssp: Don't use SSCR0_SerClkDiv
	and SSCR0_SCR
Date: Thu, 19 Mar 2009 09:34:52 +0100
Message-ID: <1237451692.14402.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 476CC103922
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 09:34:54 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e12so23849fga.21
	for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2009 01:34:54 -0700 (PDT)
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
Cc: eric miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Those macros are just screwed as soon as CONFIG_PXA25x is enabled.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c7c1996..cc8dbd4 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -283,9 +283,32 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 static void ssp_set_scr(struct ssp_dev *dev, u32 div)
 {
 	struct ssp_device *ssp = dev->ssp;
-	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+
+	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
+		sscr0 &= ~0x0000ff00;
+		sscr0 |= ((div - 2)/2) << 8; /* 2..512 */
+	} else {
+		sscr0 &= ~0x000fff00;
+		sscr0 |= (div - 1) << 8;     /* 1..4096 */
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
+}
 
-	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
+/**
+ * ssp_get_clkdiv - get SSP clock divider
+ */
+static u32 ssp_get_scr(struct ssp_dev *dev)
+{
+	struct ssp_device *ssp = dev->ssp;
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+	u32 div;
+
+	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP)
+		div = ((sscr0 >> 8) & 0xff) * 2 + 2;
+	else
+		div = ((sscr0 >> 8) & 0xfff) + 1;
+	return div;
 }
 
 /*
@@ -674,8 +697,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	case SND_SOC_DAIFMT_I2S:
 	       sspsp = ssp_read_reg(ssp, SSPSP);
 
-		if (((sscr0 & SSCR0_SCR) == SSCR0_SerClkDiv(4)) &&
-		     (width == 16)) {
+		if ((ssp_get_scr(ssp) == 4) && (width == 16)) {
 			/* This is a special case where the bitclk is 64fs
 			* and we're not dealing with 2*32 bits of audio
 			* samples.
-- 
1.6.2
