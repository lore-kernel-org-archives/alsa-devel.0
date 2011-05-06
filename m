From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 09/10] ASoC: mrst_machine: add jack
	detection support
Date: Fri, 06 May 2011 13:46:44 +0800
Message-ID: <20110506054644.26312.1898.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DDB0103A23
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:45:17 +0200 (CEST)
In-Reply-To: <20110506053852.26312.79083.stgit@localhost>
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

The jack processing logic only pulls the trigger, all the heavy work such as
interrupt handling is done in codec driver.

We need to enable MIC2 Bias to be able to get the jack interrupts.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index 131deff..eb52a2b 100644
--- a/sound/soc/mid-x86/mrst_machine.c
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -35,6 +35,10 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
+#include <../codecs/upd9976.h>
+
+static struct snd_soc_jack mrst_jack;
 
 static const struct snd_kcontrol_new mrst_snd_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
@@ -85,6 +89,7 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
 
 	snd_soc_dapm_nc_pin(dapm, "LINEINL");
 	snd_soc_dapm_nc_pin(dapm, "LINEINR");
@@ -99,6 +104,17 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 
 	snd_soc_dapm_sync(dapm);
 
+	ret = snd_soc_jack_new(codec, "Intel(R) MID Audio Jack",
+			       (SND_JACK_HEADSET |
+				SND_JACK_BTN_0 |
+				SND_JACK_BTN_1),
+			       &mrst_jack);
+	if (ret)
+		return ret;
+
+	if (!upd9976_jack_detect(codec, &mrst_jack, 0xff))
+		snd_soc_dapm_force_enable_pin(dapm, "MIC2 Bias");
+
 	return 0;
 }
 
