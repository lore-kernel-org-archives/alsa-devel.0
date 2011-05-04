From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 05/19] ASoC: mrst_machine: enable user to
 select different output
Date: Wed, 04 May 2011 21:45:19 +0800
Message-ID: <20110504134519.32443.90599.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id DCBC810381F
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:43:56 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

All these two output device can be enabled and disabled independently.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index 0bce388..b4d542e 100644
--- a/sound/soc/mid-x86/mrst_machine.c
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -36,6 +36,11 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+static const struct snd_kcontrol_new mrst_snd_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
 /*
  * GPIO pin to power on/off Internal Speaker
  */
@@ -85,13 +90,19 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 	if (ret)
 		return ret;
 
+	ret = snd_soc_add_controls(codec,
+				   mrst_snd_controls,
+				   ARRAY_SIZE(mrst_snd_controls));
+	if (ret)
+		return ret;
+
 	snd_soc_dapm_nc_pin(dapm, "LINEINL");
 	snd_soc_dapm_nc_pin(dapm, "LINEINR");
 	snd_soc_dapm_nc_pin(dapm, "LINEOUTL");
 	snd_soc_dapm_nc_pin(dapm, "LINEOUTR");
 
-	snd_soc_dapm_enable_pin(dapm, "Headphone");
-	snd_soc_dapm_disable_pin(dapm, "Speaker");
+	snd_soc_dapm_disable_pin(dapm, "Headphone");
+	snd_soc_dapm_enable_pin(dapm, "Speaker");
 
 	snd_soc_dapm_sync(dapm);
 
