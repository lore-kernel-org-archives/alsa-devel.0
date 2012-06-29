From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: spdif: Build separate RX and TX objects
Date: Fri, 29 Jun 2012 02:44:39 +0100
Message-ID: <1340934279-26457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16CC310BA04
	for <alsa-devel@Alsa-project.org>;
	Fri, 29 Jun 2012 03:44:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vipin Kumar <vipin.kumar@st.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, wfg@linux.intel.com, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@Alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Otherwise we fail to link when building as modules due to multiple
init/exit functions.

Reported-by: Fengguang Wu <wfg@linux.intel.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 62c3d4d..acf8088 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -45,7 +45,8 @@ snd-soc-alc5623-objs := alc5623.o
 snd-soc-alc5632-objs := alc5632.o
 snd-soc-sigmadsp-objs := sigmadsp.o
 snd-soc-sn95031-objs := sn95031.o
-snd-soc-spdif-objs := spdif_transciever.o spdif_receiver.o
+snd-soc-spdif-tx-objs := spdif_transciever.o
+snd-soc-spdif-rx-objs := spdif_receiver.o
 snd-soc-ssm2602-objs := ssm2602.o
 snd-soc-sta32x-objs := sta32x.o
 snd-soc-stac9766-objs := stac9766.o
@@ -159,7 +160,7 @@ obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_SGTL5000)  += snd-soc-sgtl5000.o
 obj-$(CONFIG_SND_SOC_SIGMADSP)	+= snd-soc-sigmadsp.o
 obj-$(CONFIG_SND_SOC_SN95031)	+=snd-soc-sn95031.o
-obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif.o
+obj-$(CONFIG_SND_SOC_SPDIF)	+= snd-soc-spdif-rx.o snd-soc-spdif-tx.o
 obj-$(CONFIG_SND_SOC_SSM2602)	+= snd-soc-ssm2602.o
 obj-$(CONFIG_SND_SOC_STA32X)   += snd-soc-sta32x.o
 obj-$(CONFIG_SND_SOC_STAC9766)	+= snd-soc-stac9766.o
-- 
1.7.10
