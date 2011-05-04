From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 11/19] ASoC: upd9976: add jack detection
	function
Date: Wed, 04 May 2011 21:45:50 +0800
Message-ID: <20110504134550.32443.87977.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 84F14103957
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:44:26 +0200 (CEST)
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
 sound/soc/codecs/upd9976.c |   28 ++++++++++++++++++++++++++++
 sound/soc/codecs/upd9976.h |    2 ++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/upd9976.c b/sound/soc/codecs/upd9976.c
index 69d83ea..9231cee 100644
--- a/sound/soc/codecs/upd9976.c
+++ b/sound/soc/codecs/upd9976.c
@@ -60,6 +60,34 @@ static inline int upd9976_write(struct snd_soc_codec *codec,
 	return ret;
 }
 
+void upd9976_jack_detection(struct snd_soc_jack *jack, u8 interrupt_status)
+{
+	int status = 0;
+	unsigned int value = 0;
+	struct snd_soc_codec *codec = jack->codec;
+	int mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_HEADSET;
+
+	if (interrupt_status & 0x3)
+		value = snd_soc_read(codec, UPD9976_SAUXINT);
+
+	if (interrupt_status & 0x1 && value == 0x1)
+		status |= SND_JACK_HEADSET;
+
+	if (interrupt_status & 0x2 && value == 0x2)
+		status |= SND_JACK_HEADPHONE;
+
+	if (interrupt_status & 0x4)
+		status |= SND_JACK_HEADSET | SND_JACK_BTN_0;
+
+	if (interrupt_status & 0x8)
+		status |= SND_JACK_HEADSET | SND_JACK_BTN_1;
+
+	snd_soc_jack_report(jack, status, mask);
+	if (status & (SND_JACK_BTN_0 | SND_JACK_BTN_1))
+		snd_soc_jack_report(jack, SND_JACK_HEADSET, mask);
+}
+EXPORT_SYMBOL_GPL(upd9976_jack_detection);
+
 static int upd9976_mic2_bias_event(struct snd_soc_dapm_widget *widget,
 				   struct snd_kcontrol *kcontrol, int event)
 {
diff --git a/sound/soc/codecs/upd9976.h b/sound/soc/codecs/upd9976.h
index ab2ea15..090dd0b 100644
--- a/sound/soc/codecs/upd9976.h
+++ b/sound/soc/codecs/upd9976.h
@@ -80,4 +80,6 @@
 
 #define UPD9976_SAUXINT		0x132
 
+void upd9976_jack_detection(struct snd_soc_jack *jack, u8 interrupt_status);
+
 #endif
