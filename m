From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 1/1] ASoC: stm32: sai: fix warning in
	stm32_sai_set_config()
Date: Thu, 2 Nov 2017 11:20:09 +0100
Message-ID: <1509618009-30804-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F1A452673E8
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 11:20:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Fix uninitialized warning introduced by
"Move static settings to DAI init" commit
in stm32_sai_set_config() function.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 150ad54..08583b9 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -482,13 +482,13 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 	cr1_mask = SAI_XCR1_DS_MASK;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_8);
 		break;
 	case SNDRV_PCM_FORMAT_S16_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_16);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_16);
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_32);
+		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_32);
 		break;
 	default:
 		dev_err(cpu_dai->dev, "Data format not supported");
-- 
1.9.1
