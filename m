From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 3/3] ASoC: fsl_sai: Add support for Right-J mode
Date: Tue, 20 Jan 2015 20:21:20 +0800
Message-ID: <1421756480-7055-4-git-send-email-zidan.wang@freescale.com>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0107.outbound.protection.outlook.com [157.56.111.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 25B1F26055C
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 13:21:13 +0100 (CET)
In-Reply-To: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Add Right-J mode and set TCR5 FBT bit to let data right justify.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 14 +++++++++++---
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 4c5040d..19cd6f3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -228,7 +228,11 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
 		sai->is_dsp_mode = true;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		/* To be done */
+		/* Frame high, one word length for frame sync */
+		val_cr2 |= FSL_SAI_CR2_BCP;
+		sai->is_right_j_mode = true;
+		break;
+
 	default:
 		return -EINVAL;
 	}
@@ -418,9 +422,13 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	val_cr5 |= FSL_SAI_CR5_WNW(sai->slot_width);
 	val_cr5 |= FSL_SAI_CR5_W0W(sai->slot_width);
 
-	if (sai->is_lsb_first)
+	if (sai->is_lsb_first && sai->is_right_j_mode)
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
-	else
+	else if (sai->is_lsb_first && !sai->is_right_j_mode)
+		val_cr5 |= FSL_SAI_CR5_FBT(sai->slot_width - word_width);
+	else if (!sai->is_lsb_first && sai->is_right_j_mode)
+		val_cr5 |= FSL_SAI_CR5_FBT(sai->slot_width - 1);
+	else if (!sai->is_lsb_first && !sai->is_right_j_mode)
 		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
 
 	val_cr4 |= FSL_SAI_CR4_FRSZ(sai->slots * channels);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 111dfce..e220940 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -137,6 +137,7 @@ struct fsl_sai {
 	bool is_lsb_first;
 	bool is_slave_mode;
 	bool is_dsp_mode;
+	bool is_right_j_mode;
 	bool sai_on_imx;
 	bool synchronous[2];
 
-- 
1.9.1
