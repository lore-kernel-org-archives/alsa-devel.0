From: naresh@ti.com
Subject: [PATCH] ASoC: DaVinci: Fix audio stall when doing full
	duplex
Date: Tue, 18 Nov 2008 11:01:03 +0530
Message-ID: <1226986263-7815-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FCE624489
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 07:31:37 +0100 (CET)
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Steve Chen <schen@mvista.com>, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Naresh Medisetty <naresh@ti.com>

Fix concurrent capture/playback issue.
The issue is caused by re-initialization of control registers used specifically
for capture or playback in both capture and playback operations.

Signed-off-by: Steve Chen <schen@mvista.com>
	       Naresh Medisetty <naresh@ti.com>
---
 sound/soc/davinci/davinci-i2s.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 8c1bf87..11c20d0 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -295,10 +295,14 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	u32 w;
 
 	/* general line settings */
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
-				DAVINCI_MCBSP_SPCR_RINTM(3) |
-				DAVINCI_MCBSP_SPCR_XINTM(3) |
-				DAVINCI_MCBSP_SPCR_FREE);
+	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		w |= DAVINCI_MCBSP_SPCR_RINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+	} else {
+		w |= DAVINCI_MCBSP_SPCR_XINTM(3) | DAVINCI_MCBSP_SPCR_FREE;
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, w);
+	}
 
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SRGR_REG);
@@ -329,16 +333,19 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_RCR_REG);
-	MOD_REG_BIT(w, DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
-		       DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length), 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, w);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_RCR_REG);
+		MOD_REG_BIT(w, DAVINCI_MCBSP_RCR_RWDLEN1(mcbsp_word_length) |
+			       DAVINCI_MCBSP_RCR_RWDLEN2(mcbsp_word_length), 1);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, w);
 
-	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_XCR_REG);
-	MOD_REG_BIT(w, DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
-		       DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length), 1);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, w);
+	} else {
+		w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_XCR_REG);
+		MOD_REG_BIT(w, DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
+			       DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length), 1);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, w);
 
+	}
 	return 0;
 }
 
-- 
1.5.4.1
