From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 12/19] ASoC: mrst_machine: add capture
	functionality
Date: Wed, 04 May 2011 21:45:54 +0800
Message-ID: <20110504134554.32443.49303.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id BF544103966
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:30 +0200 (CEST)
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

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index b4d542e..d70b26e 100644
--- a/sound/soc/mid-x86/mrst_machine.c
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -39,6 +39,9 @@
 static const struct snd_kcontrol_new mrst_snd_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Speaker"),
+
+	SOC_DAPM_PIN_SWITCH("Headset MIC"),
+	SOC_DAPM_PIN_SWITCH("Internal MIC"),
 };
 
 /*
@@ -59,6 +62,9 @@ static int mrst_speaker_event(struct snd_soc_dapm_widget *widget,
 static const struct snd_soc_dapm_widget mrst_audio_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_SPK("Speaker", mrst_speaker_event),
+
+	SND_SOC_DAPM_MIC("Headset MIC", NULL),
+	SND_SOC_DAPM_MIC("Internal MIC", NULL),
 };
 
 static const struct snd_soc_dapm_route mrst_audio_map[] = {
@@ -70,6 +76,9 @@ static const struct snd_soc_dapm_route mrst_audio_map[] = {
 
 	{"Speaker", NULL, "PREOUTL"},
 	{"Speaker", NULL, "PREOUTR"},
+
+	{"MIC2", NULL, "Headset MIC"},
+	{"DMICDAT", NULL, "Internal MIC"},
 };
 
 static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
@@ -104,6 +113,9 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "Headphone");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 
+	snd_soc_dapm_disable_pin(dapm, "Headset MIC");
+	snd_soc_dapm_enable_pin(dapm, "Internal MIC");
+
 	snd_soc_dapm_sync(dapm);
 
 	return 0;
