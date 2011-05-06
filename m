From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH v2 08/10] ASoC: mrst_machine: add capture
	functionality
Date: Fri, 06 May 2011 13:46:39 +0800
Message-ID: <20110506054639.26312.77715.stgit@localhost>
References: <20110506053852.26312.79083.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id DE6E7103A82
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 07:45:11 +0200 (CEST)
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

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index 10e4d40..131deff 100644
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
@@ -85,6 +94,9 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_disable_pin(dapm, "Headphone");
 	snd_soc_dapm_enable_pin(dapm, "Speaker");
 
+	snd_soc_dapm_disable_pin(dapm, "Headset MIC");
+	snd_soc_dapm_enable_pin(dapm, "Internal MIC");
+
 	snd_soc_dapm_sync(dapm);
 
 	return 0;
