From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Tue, 5 Nov 2013 16:30:08 +0800
Message-ID: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E6184265072
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 09:30:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@alsa-project.org, chao.xie@marvell.com, trinity.qiao.zhou@gmail.com
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

add TISSP mode support. with this mode enabled, ssp controller
works in TI-ssp protocol automatically and doesn't need to
configure sspsp register to set the timing for tx/rx.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 include/sound/soc-dai.h |    1 +
 sound/soc/pxa/pxa-ssp.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ae9a227..43fc5d0 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -33,6 +33,7 @@ struct snd_compr_stream;
 #define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
 #define SND_SOC_DAIFMT_AC97		6 /* AC97 */
 #define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */
+#define SND_SOC_DAIFMT_SSP		8 /* SSP mode */
 
 /* left and right justified also known as MSB and LSB respectively */
 #define SND_SOC_DAIFMT_MSB		SND_SOC_DAIFMT_LEFT_J
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index a3119a0..effa8d1 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -505,6 +505,14 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		sscr0 |= SSCR0_MOD | SSCR0_PSP;
 		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
 		break;
+	/*
+	 * add TISSP protocol support. setting to this mode, ssp controller
+	 * works in TI-ssp mode, and need not set psp register to conf
+	 * detailed timing.
+	 */
+	case SND_SOC_DAIFMT_SSP:
+		sscr0 |= SSCR0_TISSP;
+		sscr1 |= SSCR1_RWOT;
 
 	default:
 		return -EINVAL;
-- 
1.7.0.4
