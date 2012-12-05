From: <MR.Swami.Reddy@ti.com>
Subject: [PATCH] ASoC: lm49453: Fix analog and digital volume
	ranges
Date: Wed, 5 Dec 2012 13:29:53 +0530
Message-ID: <1354694393-11805-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id DA3EA26036F
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 08:43:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

From: MR Swami Reddy <MR.Swami.Reddy@ti.com>

[PATCH] ASoC: lm49453: Fix analog and digital volume ranges"

Signed-off-by: M R Swami Reddy <mr.swami.reddy@ti.com>

--
 sound/soc/codecs/lm49453.c |    7 +++++----
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index 808e50a..ba1aec4 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -494,8 +494,9 @@ SOC_DAPM_SINGLE("Port2_2 Switch", LM49453_P0_PORT2_TX2_REG, 7, 1, 0),
 };
 
 /* TLV Declarations */
-static const DECLARE_TLV_DB_SCALE(port_tlv, 0, 600, 0);
+static const DECLARE_TLV_DB_SCALE(analog_tlv, 0, 200, 1);
+static const DECLARE_TLV_DB_SCALE(port_tlv, -1800, 600, 0);
 
 static const struct snd_kcontrol_new lm49453_sidetone_mixer_controls[] = {
 /* Sidetone supports mono only */
@@ -516,9 +517,9 @@ SOC_DAPM_SINGLE_TLV("Sidetone DMIC2R Volume", LM49453_P0_STN_VOL_DMIC2R_REG,
 static const struct snd_kcontrol_new lm49453_snd_controls[] = {
 	/* mic1 and mic2 supports mono only */
 	SOC_SINGLE_TLV("Mic1 Volume", LM49453_P0_ADC_LEVELL_REG, 0, 6,
-			0, digital_tlv),
+			0, analog_tlv),
 	SOC_SINGLE_TLV("Mic2 Volume", LM49453_P0_ADC_LEVELR_REG, 0, 6,
-			0, digital_tlv),
+			0, analog_tlv),
 
 	SOC_DOUBLE_R_TLV("DMIC1 Volume", LM49453_P0_DMIC1_LEVELL_REG,
 			  LM49453_P0_DMIC1_LEVELR_REG, 0, 6, 0, digital_tlv),
